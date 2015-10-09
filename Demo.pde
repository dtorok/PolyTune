import java.util.Iterator;

class Demo {
  int time;
  int timeout;
  int[] song = {0, 0, 0, 4, 7, 7, 7, 99, 7, 0, 4, 7, 0, 0, 0};
  int noteLength = 20;
  int noteIndex;
  
  Demo() {
    time = 0;
    timeout = 200;
    noteIndex = 0;
  }
  
  private int getFrequency(int index) {
    return (int) (440.0 * Math.pow(1.059463094359, index));
  }

  void update(ArrayList<GuitarBar> midibars) {
    if (time == 0) {
      if (noteIndex < song.length) {
        if (song[noteIndex] != 99) {
          addNewNote(midibars, song[noteIndex]);
        }
        noteIndex ++;
        time ++;
      }
    } else if (time >= noteLength) {
      stopNotes(midibars);
      time = 0;
    } else {
      time ++;
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