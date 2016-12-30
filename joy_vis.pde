int vis_width = 600; //<>//
int vis_height = 600;
int line_separation = 5;
int points_per_line = 100;
int point_separation = 0;
int max_z_deviation = 5;
int max_lines = vis_height / line_separation;
ArrayList<JoyLine> lines = new ArrayList<JoyLine>();
int num_lines = 100;
float rotate_factor = 0;
void setup()
{
  size(800, 800, P3D);         // use 3D renderer

  stroke(255, 255, 255, 100);  // white pen, with a touch of alpha

  // build the array of lines
  for (int i = 0; i < num_lines; i++)
  {
    // step down in y by 'line_separation'
    int y = (i * line_separation);
    point_separation = vis_width / points_per_line;
    // restrict the x value of the lines to within the size of the canvas
    JoyLine my_line = new JoyLine(new JoyPoint(200, y, 0.0), new JoyPoint(vis_width, y, 0.0), points_per_line, 5);
    lines.add(my_line);
  }
  noLoop(); // only draw through once. change this when we have sound coming in and we're processing each frame
}


void draw()
{
  background(0); // black background
 
  ellipse(0,0,10,10); // put a reference circle at (0,0), for debugging
  translate(-50, height/6,-80);
  rotateX(radians(40));

  //noFill();
  fill(0);

  // now loop through each line, creating a shape from each of the lines points.
  float yoff = 0; // for indexing into noise()
  for (int i = 0; i < num_lines; i++)
  {
    beginShape();
    JoyPoint first_point = lines.get(i).get_point(0);
    vertex(first_point.x, first_point.y, 0);
    //ellipse(first_point.x, first_point.y, 10, 10);

    for (int pt = 1; pt < points_per_line - 1; pt ++)
    {
      float xoff = 0; // for indexing into noise()
      JoyPoint my_point = lines.get(i).get_point(pt);
      //if(pt == 5){ my_point.z = 5; }
      vertex(my_point.x, my_point.y, map(noise(xoff,yoff),0,1,0,50));
      xoff += 0.1;
      yoff += 0.1;
    }
    
    JoyPoint last_point = lines.get(i).get_point(points_per_line - 1);
    vertex(last_point.x, last_point.y, 0);
    endShape();
  }
}