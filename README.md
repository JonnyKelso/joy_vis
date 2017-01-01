# joy-vis
This is a simple audio visualiser, witten using Processing (https://processing.org)

It aims to emulate the classic Joy Division 'Unknown Pleasures' album cover art. 

![alt text](http://i.imgur.com/jRECeda.jpg "Joy Division - Unknown Pleasures cover art")

The original Joy Division art is an image based on a stacked plot of radio waves from pulsar CP 1919. https://en.wikipedia.org/wiki/Unknown_Pleasures#Cover_and_sleeve

# the code
The main entry point is in joy_vis.pde, which contains the setup() and draw()functions. Processing calls setup() once at startup and then draw() once every frame.

joy_vis.pde  - Main entry point, contains main drawing loop
JoyLine.pde	 - A class defining a line to draw, contains an array of JoyPoints
JoyPoint.pde - A class defining a single point. Simple x,y,z container.

JoyFFTList.pde - A linked list class defining a list of JoyFFTLines.
JoyFFTLine.pde - A class defining a sinlge FFT line. Contains the FFT values of the incoming audio, transformed into z-values ready for plotting.

# how to use
Download Processing here: http://processing.org
Copy the files in this repo into the default sketchbook and run using the Processing GUI/IDE.

# current screenshot

![alt text](http://i.imgur.com/QkyEDiM.gif)
