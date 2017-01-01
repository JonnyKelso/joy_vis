# joy-vis
This is a simple audio visualiser, witten using Processing (https://processing.org)

It aims to emulate the classic Joy Division 'Unknown Pleasures' album cover art. 

![alt text](http://i.imgur.com/jRECeda.jpg "Joy Division - Unknown Pleasures cover art")

The original Joy Division art is an image based on a stacked plot of radio waves from pulsar CP 1919. https://en.wikipedia.org/wiki/Unknown_Pleasures#Cover_and_sleeve

# how to use
Download Processing here: http://processing.org
Add the files in this repo to a sketchbook and run using the Processing GUI/IDE

# still to do
It's all early days still :)

1. Sample audio signal - 
Currently plays hardcoded mp3 file from local directory, maybe add controls to load mp3s, or read audio from audio line out (system audio)

2. Fix plot orientation - 
Not quite happy with the orientation of the plot yet - the original has verical sides, but this one has sides that are angled due to perspective.

3. Cover art seems to use only the middle third or so of the plot - 
Restrict plot area to this size

4. Line stroke width and colouring don't match original yet

~~5. Animate - only single draw done for now~~

6. Move the visualisation to javascript Processing and host online - currently uses Java for Processing, for the desktop

# current screenshot

![alt text](http://i.imgur.com/QkyEDiM.gifv "joy-vis")
