class JoyFFTLine
{
  int size;
  float[] ffts;
  JoyFFTLine next;

  // constructor
  JoyFFTLine(int size_)
  {
    size = size_;
    ffts = new float[size];
    
  }

  int get_size()
  { 
    return size;
  }

  void add_at(int index, float value)
  {
    if (index < size)
    {
      ffts[index] = value;
    } else
    {
      print("JoyFFTLine: add_at() - index out of bounds\n");
    }
  }

  float get_at(int index)
  {
    float value = 0;
    if (index < size)
    {
      value = ffts[index];
    } else
    {
      print("JoyFFTLine: get_at() - index out of bounds\n");
    }
    return (value);
  }
}