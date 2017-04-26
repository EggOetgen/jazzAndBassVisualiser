
import ddf.minim.*;
import ddf.minim.analysis.*;




Minim minim;
AudioPlayer song;
BeatDetect beat;
FFT fft;
int bands = 2048;


float mid;

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
void setup() {
  size(900, 900, P3D);
  //fullScreen();
  smooth();
  frameRate(60);
  background(60);

  minim = new Minim(this);
  song = minim.loadFile("AboutYou.mp3", bands);
  song.loop();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  beat.detectMode(1);

beat.setSensitivity(1);
  fft = new FFT(song.bufferSize(), song.sampleRate());




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
}


void draw() {
  background(backR, backG, backB);

  beat.detect(song.mix);
  fft.forward(song.mix);

  if (beat.isOnset() ) {
   changePat();
   }
   
   


  for (int i = 0; i < fft.specSize(); i++)
  {
    

   
    // draw the line for frequency band i, scaling it up a bit so we can see it
    sum[i] += (fft.getBand(i)-sum[i])*smoothScale;
    summed = sum[i]*10;
    mid = fft.getFreq(i)*2;
  }
  
  

  if (mid > 24.5) {
   changePat();
   stroke(r[0], g[0], b[0]);
   noFill();
   strokeWeight(2);
  }

    ellipse(width/2, height/2, mid*2, mid*2);






  //ellipse (width/2, height/2, val, val);
  pushMatrix();

  //scale(1.5);
  generate2(amp1[0], amp3[0], amp5[0], amp7[0], amp2[0], amp4[0], amp6[0], amp8[0], r[0], g[0], b[0], r3[0], g3[0], b3[0], r5[0], g5[0], b5[0], r2[0], g2[0], b2[0], r4[0], g4[0], b4[0]);


  popMatrix();
  
  
 
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
    //rotate(elements/i*r);

    //magnify = 100;

    float summed1 = summed/50;
    //ellipse(sin(spacing*i*amp)/cos(spacing*i*amp2)*magnify, sin(spacing*amp*i)*tan(spacing*amp2*i)*magnify, .4, .4);

    float x = ((cos(spacing*i*amp*summed1)))/(sin(spacing*i*amp2/summed1))*magnify;
    float y = (sin(spacing*i*amp*summed1))/(sin(spacing*i*2*amp2*summed1))*magnify;

    fill(r, g, b, 235);
    ellipse(x, y, .9, .9);
    //WEIRD BALL THINGYS - make magnify bigger for these
    float x2 = (sin(spacing*i*amp))*(sin(spacing*i*amp2))*magnify;
    float y2 = (sin(spacing*amp*2*i))*noise(tan(spacing*amp2*i*2))*magnify;
    ellipse(x, y, .8, .8);

    //fill(r*1.2, g*1.2, b*1.2, 255);
    //ellipse(x, y, random(.3, .7), random(.3, .7));*/

    /*
     strokeWeight(0.5);
     stroke(r, g, b, 11);
     line(x, y,  0,0);
     
     
     strokeWeight(0.5);
     //stroke(r*2, g*2, b*2, 55);
     //point(x, y);
     //point(x+0.5, y+0.5);
     //point(x-0.5, y-0.5);
     */





    //ellipse(cos(spacing*i*amp)*noise(spacing*i*amp2)*magnify, sin(spacing*amp*i)*sin(spacing*amp2*i)*magnify, .4, .4);

    popMatrix();
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("SAVEDROG54####.png");
  }

  if (key == 'h') {
    println("Changed");


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