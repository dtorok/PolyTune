class GuitarRenderer implements MusicRenderer {
  PImage back, backSharp, backSoft;

  GuitarRenderer(boolean blurredBack) {
    if (blurredBack)
    {
        backSharp = loadImage("er4-sharp.jpg");
        backSoft = loadImage("er4-soft.jpg");
    } else { 
        back = loadImage("er4.jpg");
    }
  }    

  void drawBackground() {
    background(0);
    if (blurredBack)
    {
       image(backSoft, 0, 0);
        
               
        
       backSharpAlpha = max(0, backSharpAlpha - numOns * 5);
       pushStyle();
        
       backSharpAlpha = min(255, backSharpAlpha + 3);
       tint(255, backSharpAlpha);
       image(backSharp, 0, 0);
       popStyle();
       //println("backSharpAlpha " + backSharpAlpha);
    } 
    else
       image(back, 0, 0);
  }
  
  
  
  void drawNotes(Note[] notes) {
    boolean mesh = true;
    boolean thinMesh = false;

    // clean old 
    numOns = 0;
    for (int i=0; i<midibars.size (); i++)
    {
        if (midibars.get(i).on) numOns++;
        if ((midibars.get(i).x>width) || (midibars.get(i).x < - midibars.get(i).w * 4)) {
            midibars.remove(midibars.get(i));
        }
    }
    
    if (autoPeak)
    {
        int fresh = 0;
        for (int i=0; i<midibars.size (); i++)
        {
            if (frameCount - midibars.get(i).note.noteOnFrame < 20) fresh++;
        }
        if (fresh == 0) PEAK_THRESHOLD = max(3, PEAK_THRESHOLD-1);
        if (fresh > 5) PEAK_THRESHOLD += 1;
    }

    // notes 
    for (int i=0; i<midibars.size (); i++)
    {
        midibars.get(i).display();
    }

    // lines
    if (mesh)
    {
        float xLimit = 30;
        float yLimit = 100;
        // calculate links
        for (int i=0; i<midibars.size ()-1; i++) 
        {
            if (midibars.get(i).x < 600 && !thinMesh) continue;
            if (midibars.get(i).after != null && !thinMesh) continue;

            for (int k = 0; k < midibars.size (); k++)
            {
                if (i==k || abs(midibars.get(i).y - midibars.get(k).y) > yLimit) continue;
                float diff = midibars.get(k).x - midibars.get(i).x;
                if ( diff < xLimit && diff > 0 && midibars.get(i).after == null)
                {
                    midibars.get(i).after = midibars.get(k);
                } else if (diff < xLimit && diff > 0 && midibars.get(i).after.x > midibars.get(k).x)
                {
                    midibars.get(i).after = midibars.get(k);
                }


                // thin mesh
                if (thinMesh)
                {
                    strokeWeight(1);
                    stroke(0, 50);
                    if (abs(midibars.get(i).x - midibars.get(k).x) < 50 &&
                        abs(midibars.get(i).y - midibars.get(k).y) < 100 )
                    {
                        line(midibars.get(i).x, midibars.get(i).y, midibars.get(i).z, 
                        midibars.get(k).x, midibars.get(k).y, midibars.get(k).z);
                    }
                }
            }
        }

        // draw links
        strokeWeight(8);
        stroke(255, 222);
        noFill();
        for (int i=0; i<midibars.size ()-1; i++) 
        {
            if (midibars.get(i).after != null)
            {
                if (song == NUTHSELL)
                {
                    line(midibars.get(i).x, midibars.get(i).y, midibars.get(i).z, 
                         midibars.get(i).after.x, midibars.get(i).after.y, midibars.get(i).after.z);
                } else if (song == KISKECE)
                {   
                    PVector p = new PVector(midibars.get(i).x, midibars.get(i).y, midibars.get(i).z);
                    PVector q = new PVector(midibars.get(i).after.x, midibars.get(i).after.y, midibars.get(i).after.z);
                    curve(p.x, p.y - q.y/2, p.z, p.x, p.y, p.z, q.x, q.y, q.z, q.x, q.y + p.y/2, q.z);
                }
            }
        }
    } else
    {
        strokeWeight(5);
        stroke(255, 222);
        for (int i=0; i<midibars.size ()-1; i++) 
        {
            if (abs(midibars.get(i).x - midibars.get(i+1).x) > 100 ||
                abs(midibars.get(i).y - midibars.get(i+1).y) > 100 )
            {
                continue;
            }      
            line(midibars.get(i).x, midibars.get(i).y, midibars.get(i).z, 
            midibars.get(i+1).x, midibars.get(i+1).y, midibars.get(i+1).z);
        }
    }
  
  }
}