class MIDIBar {
	float x, y, w, h, z;
	boolean on = true;
	int pitch;
	int keyHeight = height / (keyboardEnd - keyboardStart);
	Note note;
	String noteName = "";
	color noteColor;

	MIDIBar(Note _note){
		note = _note;
		h = keyHeight;
		w = 0;
		x = width / 1.4 - 250 + note.pitch * 4;
		y =  (note.pitch - keyboardStart + 1) * keyHeight;

		//colorMode(HSB);
		//noteColor = color(map(note.pitch%12,0,12,0,255),255,100);
		//colorMode(RGB);
	}

	void grow(){
		ellipseMode(CENTER);
		fill(255);
                noStroke();
                float ew = max(w, 30);
		ellipse(x,normalizeY(y), ew, ew);
		w+=2;
	}

        public float normalizeY(float y)
        {
            return y * 2 - 600 ;
        }

	void scroll(PGraphics pg){
		//colorMode(HSB);
		//fill(noteColor);
                pg.pushMatrix();
                pg.ellipseMode(CENTER);
                pg.noStroke();
                pg.translate(x, normalizeY(y), z);
                float size = max(w, 5);
		pg.fill(255, 222);
		pg.ellipse(0,0,size * 2,size* 2);

                pg.fill(0,222);
                pg.ellipse(0,0,size,size);
                pg.popMatrix();
        
		x-=2;
                z += note.amplitude * 0.02;

                /*
		fill(255);
		if(note.amplitude > 40){
			//text(note.label(), x + 5, height - ((note.pitch - keyboardStart) * keyHeight));
		}
		if(w>40){
		//	text(note.label(), x + 5, height - ((note.pitch - keyboardStart) * keyHeight));
		}
                */
		
	}

	void display(PGraphics pg){
		if(on){
			grow();
		}if(!on){
			scroll(pg);
		}
	}
}
