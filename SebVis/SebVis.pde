/*
Welcome to my Audio Visual Particle System. Click play and select a song from the file browser
or alternatively use the one provided.
*/

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
  Output output;
  Minim context;
  AudioOutput out;
  Audio audio = new Audio(); 
  EnvelopeFollower envFollow;
  Sampler sampler;

void setup() { 
  fullScreen(P3D); //comment this out and uncomment the line above if you wish to not use fullscreen mode
  lights();
  smooth(); 
  envFollow = new EnvelopeFollower(0.0, 0.1, 512); //Envelope follower for tracking amplitude of the song
  output = new Output();
  context = new Minim(this);
  out = context.getLineOut();
  Sink sink = new Sink();
 
  output.initialise();
  sampler = new Sampler(output.filename, 1, context); //loading song file
  sampler.patch(envFollow).patch(sink).patch(out);
  sampler.trigger();
  sampler.patch(out);  
}

void draw() {
  audio.run();
  output.display();
}