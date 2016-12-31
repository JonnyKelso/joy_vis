class JoyFFTList
{
  // head of list
  JoyFFTLine head = null;

  // next
  JoyFFTLine next = null;
  
  int max_size = 0;

  // constructor
  JoyFFTList(int max_size_)
  {
    head = new JoyFFTLine(points_per_line);
    max_size = max_size_;
  }

  void add(JoyFFTLine line)
  {
    // we always add onto the head.
    // so set the current head, to the 'next' of this new one,
    line.next = head;

    // and set the new one as the new head.
    head = line;
  }

  JoyFFTLine get(int index)
  {
    // there isn't an array to index through, 
    // so we have to step through each node until we find the one at 'index'. 0 == head
    JoyFFTLine line;
    if ((index < (size() - 1)) && (index >= 0))
    {
      line = head;
      if(index == 0)
      {
        return line;
      }
      for (int i = 0; i < index; i++)
      {
        line = line.next;
      }
      return (line);
    }
    // index must've been out of bounds
    //print("JoyFFTList: get() - index out ofbounds \n");
    return null;
  }

  int size()
  {
    // there is no array to index into, so step through the list until we find a 'null'
    int count = 0;
    JoyFFTLine line = head;
    while (line != null)
    {
      count++;
      line = line.next;
    }
    return (count);
  }
  
  // remove items at positions greater than 'max_size'
  void trim()
  {
    int count = 0;
    JoyFFTLine line = head;
    while (line != null)
    {
      count++;
      line = line.next;
      if(count >= max_size)
      {
       line = null; 
      }
    }
  }
}