import java.util.Iterator;

class Demo {
  int time;
  int timeout;
  
  Demo() {
    time = 0;
    timeout = 200;
  }
  
  void update(ArrayList<GuitarBar> midibars) {
    
    if (time < timeout) {
      time ++;
      
      if (time % 20 == 0) {
        stopNotes(midibars);
        addNewNote(midibars, time / 20);
      }
    } else if (time == timeout) {
      stopNotes(midibars);
    }
  }
  
  void stopNotes(ArrayList<GuitarBar> midibars) {
    Iterator<GuitarBar> i = midibars.iterator();
    
    while(i.hasNext()) {
      i.next().on = false;
    }
  }
  
  void addNewNote(ArrayList<GuitarBar> midibars, int index) {
    midibars.add(new GuitarBar(new Note(440 + 30 * index, 10)));
  }
}