// A simple class describing a 3D point
class JoyPoint
{
  int x;
  int y;
  float z;
  
  // constructor
  JoyPoint(int x_, int y_, float z_)
  {
    x = x_;
    y = y_;
    z = z_;
  }
  
  // set co-ordinates from 3 values
  void set_point( int x_, int y_, float z_)
  {
    x = x_;
    y = y_;
    z = z_;
  }
  
  // print the point for debugging
  void print_point()
  {
    print("x=" + x + " y=" + y + " z=" + z);
  }
  
}