import ddf.minim.*; //<>// //<>// //<>//
import ddf.minim.analysis.*;

Minim       minim;
AudioPlayer player;
FFT         fft;
JoyFFTList fft_list;

boolean playing = true;
int vis_width = 800;
int vis_height = 800;
int line_separation = 20;
int points_per_line = 50;
int point_separation = 0;
int max_z_deviation = 5;
int max_lines = vis_height / line_separation;
ArrayList<JoyLine> lines = new ArrayList<JoyLine>();
int num_lines = 50;
float rotate_factor = 0;
int min_noise = 5;
int start_x = 0;
int start_y = 0;
int x_shift_2d_plot = 80;
boolean debug_spectrum = false;
String audio_file = "disorder.mp3";
int scale_factor = 15;
void setup()
{
  size(800, 800, P3D);    // use 3D renderer
  stroke(255, 255, 255);  // white pen, with a touch of alpha
  strokeWeight(1); 

  minim = new Minim(this);
  frameRate(30);

  setup_audio();

  //noLoop(); // only draw through once. useful for debugging. change this when we have sound coming in and we're processing each frame
}

void setup_audio()
{
  // specify that we want the audio buffers of the AudioPlayer
  // to be 1024 samples long because our FFT needs to have 
  // a power-of-two buffer size and this is a good size.
  player = minim.loadFile(audio_file, 1024);

  // loop the file indefinitely
  player.loop();

  // create an FFT object that has a time-domain buffer 
  // the same size as player's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be half as large.
  fft = new FFT( player.bufferSize(), player.sampleRate() );

  // build the array of lines
  for (int i = 0; i < num_lines; i++)
  {
    // step down in y by 'line_separation'
    int y = (i * line_separation);
    point_separation = vis_width / points_per_line;
    // restrict the x value of the lines to within the size of the canvas
    //JoyLine my_line = new JoyLine(new JoyPoint(width-vis_width, y, 0.0), new JoyPoint(vis_width, y, 0.0), points_per_line, 10);
    JoyLine my_line = new JoyLine(new JoyPoint(0, y, 0.0), new JoyPoint(vis_width, y, 0.0), points_per_line, 15);
    lines.add(my_line);
  }
  //start_x = 
  fft_list = new JoyFFTList(points_per_line);
}

void draw()
{
  background(0);                  // black background
  translate(0, 20, -800);          // reposition the drawn area centrally
  rotateX(radians(30));           // tilt the drawn area back
  translate(0, -200, 0);
  //noFill();
  fill(0);


  // plot a 2D spectrum under the main plot
  if (debug_spectrum)
  {
    for (int i = 0; i < fft.specSize(); i++)
    {
      int x = int(map(i, 0, fft.specSize(), 200, 600));
      // draw the line for frequency band i, scaling it by 4 so we can see it a bit better
      line(x, 1200, x, 1200 - fft.getBand(i)*2);
    }
  }

  // perform a forward FFT on the samples in jingle's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward( player.mix );

  // create an array to hold the fft values for each point on each line
  JoyFFTLine fft_line = new JoyFFTLine(points_per_line);

  // draw the fft for the current lne (the nearest line)
  for (int j = 0; j < points_per_line; j++)
  {
    float fft_point = fft.getBand(int(map(j, 0, points_per_line, 0, fft.specSize()))) * scale_factor; // x5 scaling factor so we can see it!!
    fft_line.add_at(j, fft_point);
  }

  // add the new line to the head of the linked list
  fft_list.add(fft_line);
  // check and shrink the list to max_size
  fft_list.trim();


  // now loop through each line, creating a shape from each of the lines points.

  // get the first line in the fft linked list
  JoyFFTLine fft_this_line;

  for (int i = 0; i < num_lines; i++)
  {
    // get the appropriate line in the fft linked list
    fft_this_line = fft_list.get(i);

    // start drawing the shape
    beginShape();

    // draw the first point manually, so we set the z to 0
    JoyPoint first_point = lines.get(i).get_point(0);
    curveVertex(first_point.x, first_point.y, 0);

    // now loop through the remaining points, setting the z from the fft_list we populated
    // at the start of draw()
    for (int pt = 1; pt < points_per_line - 1; pt ++)
    {
      JoyPoint my_point = lines.get(i).get_point(pt);

      // set the z value, but give the first 1/4 of the points of the line a minimal z value set from Perlin noise
      // this is because the original album cover art does this. (the last 1/4 is also just minimal noise). 
      float z = 0;
      if ((pt > (points_per_line * 0.25)) && (pt < (points_per_line * 0.75)))
      {
        if (fft_this_line == null)
        {
          z = int(random(1, min_noise));
        } else
        {
          // set a proper value from the fft_list
          z = fft_this_line.get_at(pt);  
          if (z < min_noise)
          {
            // if the value would be too low (usually approxiamtes to 0 with our pixel precision) 
            // because of silence in the audio, then just give it the same minimal Perlin noise
            z = int(random(1, min_noise));
          }
        }
      } else 
      {
        // give the last 1/4 of the points of the line a minimal z value set from Perlin noise
        // this is because the original album cover art does this. (the first 1/4 is also just minimal noise). 
        z = int(random(1, min_noise));
      }
      // set the vertex
      curveVertex(my_point.x, my_point.y, z);
    }

    // set the last point manually, so we can set z to 0
    JoyPoint last_point = lines.get(i).get_point(points_per_line - 1);
    curveVertex(last_point.x, last_point.y, 0);
    endShape();
  }
  drawUI();
}
// pause audio if mouse button is clicked
void keyPressed()
{
  if (key == 'p' || key == 'P')
  {
    if ( player.isPlaying() )
    {
      player.pause();
    } else
    {
      // simply call loop again to resume playing from where it was paused
      player.loop();
    }
  } else if (key == 'l' || key == 'L')
  {
    selectInput("Select a file to process:", "fileSelected");
  }
  else if (key == '+')
  {
    scale_factor++;
  }
  else if (key == '-')
  {
    scale_factor--;
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    audio_file = selection.getAbsolutePath();
    player.pause();
    setup_audio();
  }
}

// show text instructions for use
void drawUI()
{
  fill(255, 255, 255);
  textSize(22);
  text("press 'P' to pause audio", 10, height+200);
  text("press 'L' to open file browser", 10, height+220);
  text("press '+ / -' to increase / decrease amplitude (now x" + scale_factor + ")", 10, height+240);
}