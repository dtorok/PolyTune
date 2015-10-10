import java.util.Iterator;

void renderBackground(Vector<MusicRenderer> renderers) {
  Iterator<MusicRenderer> i = renderers.iterator();
  while (i.hasNext()) {
    i.next().drawBackground();
  }
}

void renderNotes(Vector<MusicRenderer> renderers, Note[] notes) {
  Iterator<MusicRenderer> i = renderers.iterator();
  while (i.hasNext()) {
    i.next().drawNotes(notes);
  }
}


boolean checkForHarmonics(MIDIBar m)
{
    Note h = m.note;
    for (int i=0; i<midibars.size (); i++)
    {
        Note base = midibars.get(i).note;
        if (h != base &&
            h.semitone == base.semitone &&
            h.pitch >= base.pitch && 
            h.velocity <= base.velocity &&
            abs(h.noteOnFrame - base.noteOnFrame) < 30)
        {
            return true;
        }
    }
    return false;
}