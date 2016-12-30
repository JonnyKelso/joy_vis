class JoyLine
{
  JoyPoint[] points;  // the array of points
  JoyPoint start;     // the leftmost point (lowest x)
  JoyPoint end;       // the rightmost point (highest x)
  int num_points = 0;
  int point_sep = 0;
  
  // constructor
  JoyLine(JoyPoint start_, JoyPoint end_, int num_points_, int point_sep_)
  {
    start = start_;
    end = end_;
    num_points = num_points_;
    point_sep = point_sep_; //(end.x - start.x) / num_points;
    points = new JoyPoint[num_points];
    generate();   // generate the co-ordinates for all the points
  }
  
  // generate the co-ordinates for all the points
  void generate()
  {
    for(int i = 0; i < num_points; i++)
    {
      int new_x = start.x + (point_sep * i);
      int new_y = start.y;// - (line_separation * i);
      float new_z = random(0,max_z_deviation) * 5 + 1;
      //if((i > 20) && (i < num_points)){ new_z = 20;}
      
      print("new_z = " + new_z + "\n");
      points[i] = new JoyPoint(new_x, new_y, new_z);
    }
    //points[0] = start;
    //points[num_points - 1] = end; //<>//
  }
  
  // index into the array of points
  JoyPoint get_point(int i)
  {
    return points[i];
  }
  
  // print all lines point co-ordinates for debugging
  void print_line()
  {
    print("line: ");
    for(int i = 0; i < num_points; i++)
    {
      points[i].print_point();
      print(", ");
    }
    print("\n");
  }
}