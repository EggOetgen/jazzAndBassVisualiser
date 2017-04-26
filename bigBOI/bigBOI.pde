import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;


MyAudioSocket mySocket;
int SWOTCH;

Minim             context;
AudioInput        in;
AudioOutput       out;
//ED

EnvelopeFollower  envFol;
FFT         fft;



//AKHIL
AudioPlayer akSong;
akAv akhilAV;
float spread;

Particle bass;
Particle[] mid;
Particle hi;

//BECKY
AudioPlayer song;
BeatDetect beat;
FFT fftB;
int bands = 2048;


float midB;

float summed=10;
float smoothScale = 0.05;
int elements = 1000;
float spacing = TWO_PI/elements;
float sum[] = new float[bands];
int co = 1;
//int magnify = 37;
int magnify = 40;

int[] r = new int[co];
int[] g = new int[co];
int[] b = new int[co];
int[] amp1 = new int[co];
int[] amp2 = new int[co];



int[] r2 = new int[co];
int[] g2 = new int[co];
int[] b2 = new int[co];
int[] amp3 = new int[co];
int[] amp4 = new int[co];


int[] r3 = new int[co];
int[] g3 = new int[co];
int[] b3 = new int[co];
int[] amp5 = new int[co];
int[] amp6 = new int[co];

int[] r4 = new int[co];
int[] g4 = new int[co];
int[] b4 = new int[co];
int[] amp7 = new int[co];
int[] amp8 = new int[co];


int[] r5 = new int[co];
int[] g5 = new int[co];
int[] b5 = new int[co];
int[] amp9 = new int[co];
int[] amp10 = new int[co];


float backR, backG, backB;

float adder = 10;

int scaleX1;
int scaleY1;
int scaleX2;
int scaleY2;

float angle;

//SEB 
  Audio audio = new Audio(); 
  Output output;
  EnvelopeFollower envFollow;
  Sampler sampler;

void setup()
{
 // size(1280, 800, P3D);
//  size(1280, 1280, P3D);
  //frameRate(60);
   fullScreen(P3D);
  smooth();
  SWOTCH = 0;
  context = new Minim(this);
  
  in = context.getLineIn(Minim.MONO, 1024, 44100);
 // in.setGain(10); 
  in.disableMonitoring();
  out = context.getLineOut();
 
  //ED
  // Create the socket to connect input to output
  mySocket = new MyAudioSocket(1024);
  // Connect the socket as a "listener" for the line-in
  in.addListener(mySocket);
  //patch directly out, but you can patch into another UGen first
 // mySocket.patch(out);
  

  envFol = new EnvelopeFollower(0.0, 0.1, 1024);

  fft = new FFT( 1024, 44100 );
  fft.logAverages( 11, 1); //


  Sink sink = new Sink();
 
  fft.forward(in.mix);
 // sampler.patch( envFol ).patch( sink ).patch( out );
  mySocket.patch( envFol ).patch( sink ).patch( out );
  //sampler.trigger();




  bass = new Particle(height/2, -1);
  hi = new Particle(height, 1);
  mid = new Particle[8];
  for ( int i = 0; i < mid.length; i++) {
  mid[i] = new Particle(height/7, 1);
  }
  
 //BECKY
  
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  beat.detectMode(1);

  beat.setSensitivity(1);
  fftB = new FFT(in.bufferSize(), in.sampleRate());

  for (int i = 0; i < co; i++) {
    amp1[i] = int(random(1, 40));
    amp2[i] = int(random(1, 40));
    r[i] = int(random(0, 255));
    g[i] = int(random(0, 255));
    b[i] = int(random(0, 255));



    amp3[i] = int(random(1, 40));
    amp4[i] = int(random(1, 40));
    r2[i] = int(random(10, 255));
    g2[i] = int(random(10, 255));
    b2[i] = int(random(10, 255));

    amp5[i] = int(random(1, 40));
    amp6[i] = int(random(1, 40));
    r3[i] = int(random(10, 255));
    g3[i] = int(random(10, 255));
    b3[i] = int(random(10, 255));


    amp7[i] = int(random(1, 40));
    amp8[i] = int(random(1, 40));
    r4[i] = int(random(10, 255));
    g4[i] = int(random(10, 255));
    b4[i] = int(random(10, 255));


    amp9[i] = int(random(1, 40));
    amp10[i] = int(random(1, 40));
    r5[i] = int(random(10, 255));
    g5[i] = int(random(10, 255));
    b5[i] = int(random(10, 255));
  }

  scaleX1 = int(random(-150, 150));
  scaleY1 = int(random(-50, 10));
  scaleX2 = int(random(-150, 150));
  scaleY2 = int(random(-50, 50));
  
  //SEB
   output = new Output();
   envFollow = new EnvelopeFollower(0.0, 0.1, out.bufferSize()  ); //Envelope follower for tracking amplitude of the song
   // Sink sinkS = new Sink();
  
  output.initialise();
   mySocket.patch( envFollow ).patch( sink ).patch( out );
 // sampler = new Sampler(output.filename, 1, context); //loading song file
 // sampler.patch(envFollow).patch(sink).patch(out);
 // sampler.trigger();
  //sampler.patch(out);  
  
  
  
  
  akhilAV = new akAv();
}


void draw() {
  //ED
  if(SWOTCH == 0){
  pushMatrix();
  fft.forward(in.mix);
  //fill(0,0,0,40);
  //rect(-10,-10,width+10, width+10);
  translate(width/2, height/2);
  background(0);

  
  float ENV = envFol.getLastValues()[0] ;
 // if(ENV >1.) ENV =1.;
  
  float bassFft = fft.getAvg(1);
 // if (bassFft >90) bassFft =91.654;
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
  //fill(0,0,0,60);
  //strokeWeight(6);
 noStroke();
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
  
  popMatrix();
  }else if (SWOTCH == 1){
  //BECKY
  background(backR, backG, backB);

  beat.detect(in.mix);
  fftB.forward(in.mix);

  if (beat.isOnset() ) {
   changePat();
   }
   
   


  for (int i = 0; i < fftB.specSize(); i++)
  {
    

   
    // draw the line for frequency band i, scaling it up a bit so we can see it
    sum[i] += (fftB.getBand(i)-sum[i])*smoothScale;
    summed = sum[i]*10;
    midB = fftB.getFreq(i)*2;
  }
  
  

  if (midB > 24.5) {
   changePat();
   stroke(r[0], g[0], b[0]);
   noFill();
   strokeWeight(2);
  }

    ellipse(width/2, height/2, midB*2, midB*2);






  //ellipse (width/2, height/2, val, val);
  pushMatrix();

  //scale(1.5);
  generate2(amp1[0], amp3[0], amp5[0], amp7[0], amp2[0], amp4[0], amp6[0], amp8[0], r[0], g[0], b[0], r3[0], g3[0], b3[0], r5[0], g5[0], b5[0], r2[0], g2[0], b2[0], r4[0], g4[0], b4[0]);


  popMatrix(); 
  } else if (SWOTCH == 2){
 //SEB
 pushMatrix();
  audio.run();
  output.display();
  popMatrix();
 }
 
 
 else if (SWOTCH == 3) {
   
   akhilAV.akAvDraw();
   
   
 }
}

void generate2(int amp1, int amp2, int amp3, int amp4, int amp5, int amp6, int amp7, int amp8, int r, int g, int b, int r2, int g2, int b2, int r3, int g3, int b3, int r4, int g4, int b4, int r5, int g5, int b5) {


  pushMatrix();
  //magnify = 100;

  translate(width/2, height/2);

  for (int i = 0; i < co; i++) {
    /*
    pushMatrix();
     
     scale(1.75);
     rotate(angle);
     pattern2(i, amp4, amp1, r, g2, b5);
     popMatrix();
     */
    pushMatrix();

    scale(i/2);
    rotate(angle);
    pattern2(i, amp5, amp4, r5, g2, b5);
    popMatrix();


    pushMatrix();

    scale(2.5);
    rotate(-angle);
    pattern2(i, amp5, amp1, r2, g3, b);
    popMatrix();

    pushMatrix();

    scale(1.5);
    rotate(-angle);
    pattern2(i, amp1, amp4, r3, g, b5);
    popMatrix();


    pushMatrix();

    scale(2);
    rotate(-angle);
    pattern2(i, amp1, amp6, r3, g5, b4);
    popMatrix();

    pushMatrix();

    rotate(angle);
    pattern2(i, amp7, amp5, r2, g, b);
    popMatrix();


    pushMatrix();

    scale(3);
    rotate(-angle);
    pattern2(i, amp7, amp2, r5, g3, b);
    popMatrix();

    /*
    pushMatrix();
     scale(2.75);
     rotate(angle);
     pattern2(i, amp5, amp8, r, g5, b2);
     popMatrix();*/

    pushMatrix();

    scale(3.5);
    rotate(-angle);
    pattern2(i, amp8, amp1, r5, g2, b4);
    popMatrix();

    pushMatrix();

    scale(4);
    rotate(angle);
    pattern2(i, amp4, amp8, r2, g5, b3);
    popMatrix();

    /*
    pushMatrix();
     scale(2.25);
     rotate(-angle);
     pattern2(i, amp6, amp4, r5, g3, b5);
     popMatrix();
    /*
     pushMatrix();
     scale(2.35);
     rotate(angle);
     pattern2(i, amp4, amp8, r, g4, b3);
     popMatrix();*/
  }

  popMatrix();

}





void pattern2(int n, int amp, int amp2, int r, int g, int b) {




  for (int i = 1; i < elements; i++) {

    pushMatrix();

    noFill();
    noStroke();


    float summed1 = summed/50;
    
    float x = ((cos(spacing*i*amp*summed1)))/(sin(spacing*i*amp2/summed1))*magnify;
    float y = (sin(spacing*i*amp*summed1))/(sin(spacing*i*2*amp2*summed1))*magnify;

    fill(r, g, b, 235);
    ellipse(x, y, .9, .9);
    

    popMatrix();
  }
}

void keyPressed() {
  
  if (key == 's') {
    SWOTCH++;
    SWOTCH = SWOTCH%4;
  }
}

void changePat() {

  scaleX1 = int(random(-300, 300));
  scaleY1 = int(random(-100, 100));
  scaleX2 = int(random(-300, 300));
  scaleY2 = int(random(-100, 100));

  //    saveFrame("NEW7_####.png"); 


  backR = random(0, 50);
  backG = random(0, 50);
  backB = random(0, 50);

  for (int i = 0; i < co; i++) {


    amp1[i] = int(random(1, 40));
    amp2[i] = int(random(1, 40));
    r[i] = int(random(50, 255));
    g[i] = int(random(50, 255));
    b[i] = int(random(50, 255));



    amp3[i] = int(random(1, 40));
    amp4[i] = int(random(1, 40));
    r2[i] = int(random(50, 255));
    g2[i] = int(random(50, 255));
    b2[i] = int(random(50, 255));

    amp5[i] = int(random(1, 40));
    amp6[i] = int(random(1, 40));
    r3[i] = int(random(50, 255));
    g3[i] = int(random(50, 255));
    b3[i] = int(random(50, 255));


    amp7[i] = int(random(1, 40));
    amp8[i] = int(random(1, 40));
    r4[i] = int(random(50, 255));
    g4[i] = int(random(50, 255));
    b4[i] = int(random(50, 255));


    amp9[i] = int(random(1, 40));
    amp10[i] = int(random(1, 40));
    r5[i] = int(random(50, 255));
    g5[i] = int(random(50, 255));
    b5[i] = int(random(50, 255));
  }
}