import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.*;

MyAudioSocket mySocket;

Minim             context;
AudioInput        in;
AudioOutput       out;
Sampler           sampler;
EnvelopeFollower  envFol;
FFT         fft;

float spread;

Particle bass;
Particle[] mid;
Particle hi;

void setup()
{
  size(800, 800, P3D);
  //frameRate(60);
   //fullScreen();
  smooth();
  context = new Minim(this);

  in = context.getLineIn(Minim.MONO, 1024, 44100);
  in.setGain(5); 
  in.disableMonitoring();
  out = context.getLineOut();
  
  // Create the socket to connect input to output
  mySocket = new MyAudioSocket(1024);
  // Connect the socket as a "listener" for the line-in
  in.addListener(mySocket);
  //patch directly out, but you can patch into another UGen first
 // mySocket.patch(out);
  
//Selection of songs if you fancy ( open eye signal works best but each looks pretty different)
  // sampler = new Sampler("01 Face A.mp3", 1 ,context);
  // sampler = new Sampler("1-09 I Bite Through It.mp3", 1 ,context);
 // sampler = new Sampler("02 Open Eye Signal.mp3", 1, context);
  //sampler = new Sampler("07 Hammers.wav", 1, context);
  //sampler = new Sampler("01 bread, cheese, bow and arrow.mp3", 1 ,context);
  sampler = new Sampler("hackney.mp3", 1 ,context);


  
 // sampler.patch( out );

  envFol = new EnvelopeFollower(0.0, 0.1, 1024);

  fft = new FFT( 1024, 44100 );
  fft.logAverages( 11, 1); //


  Sink sink = new Sink();
 
  fft.forward(in.mix);
 // sampler.patch( envFol ).patch( sink ).patch( out );
  mySocket.patch( envFol ).patch( sink ).patch( out );
  //sampler.trigger();




  bass = new Particle(width/2, -1);
  hi = new Particle(width, 1);
  mid = new Particle[8];
  for ( int i = 0; i < mid.length; i++) {
    mid[i] = new Particle(width/7, 1);
  }
}


void draw() {
  fft.forward(in.mix);
  translate(width/2, height/2);
  background(0);

  float ENV = envFol.getLastValues()[0]*10 ;
 // if(ENV >1.) ENV =1.;
  
  float bassFft = fft.getAvg(1);
  if (bassFft < 20) bassFft =0;
      //first band, will get low end frequencies (kick, bass)
  float midFft = fft.getAvg(7)*10;
      //mid frequencies 
  float hiFft = fft.getAvg(5)*5;
      //higher frequencies 
  println(bassFft, midFft, hiFft);
  pushMatrix(); 
  
  
 
  hi.update(hiFft, ENV); 
  hi.display();
  
   fill(0);
  strokeWeight(6);
 
  //  black circle put beihind the bass object so its patterns dont mix too much with hi
  bass.update(bassFft, ENV); 
  ellipse(0, 0, bass.size*2, bass.size*2);
//  println(ENV, bassFft, frameRate);
  bass.display(); 

  pushMatrix();
  int t = 0;
  //for ( int t = 0; t < 360; t +=28) { 
     //make a ring of mid objects
  for ( int i = 0; i < mid.length; i ++) {
    float r = bass.size+mid[0].size;
    
    //convert polar coordinates to cartesian
    float x = r * cos(radians(t));
    float y = r * sin(radians(t));
    
    pushMatrix();
    translate(x, y);
  
    

      mid[i].update(midFft, ENV);
      mid[i].display();
   // }

    popMatrix();
    t+=45;
  }
  popMatrix();
  popMatrix();
}