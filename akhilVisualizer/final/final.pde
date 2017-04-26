import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


//minim objects
Minim minim;
AudioPlayer song;
FFT fft;

//important frequencies of various instruments in song
float beepF = 1162.793;
float clapF = 1874.9219;
float kickF = 129.19922;
float sawF = 2024.1211;
float snareF = 9087.012;
float breathF = 2885.4492;
float saw1F = 516.797;

//beat objects that detect if amplitude of a certain band is above a threshhold 
Beat beepB;
Beat clapB;
Beat saw1B;

float c = 0;


int dim = 100;
int s = 1680/dim;
float h = 500;

void setup() {


  size(1680, 1050, P3D);


  minim = new Minim(this);
  song = minim.loadFile("500.mp3", 1024);

  song.loop();

  fft = new FFT(song.bufferSize(), song.sampleRate());



  ellipseMode(CENTER);
  beepB = new Beat(beepF, 40, 500);
  clapB = new Beat(clapF, 5, 10);
  saw1B = new Beat(saw1F, 10, 1000);
}

void draw() {

  beginCamera();
  camera((width/2.0), (height/2.0), ((height/2.0) / tan(PI*30.0 / 180.0))-(saw1B.inc), width/2.0, height/2.0, 0, 0, 1, 0);
  endCamera();

  fft.forward(song.mix);
  saw1B.check();
  float l= (width/fft.specSize());
  color bc = color(0, 0, map(saw1B.inc, 0, 255, 0, 255));
  background(bc);
  stroke(255);
  fill(255);
  for (int i=0; i<fft.specSize(); i++) {



    if ((mouseX>(i*l))&&(mouseX<(((i+1)%fft.specSize())*l))) {
      stroke(255, 0, 0);
      c = fft.indexToFreq(i);
    } else {
      stroke(255);
    }
    line(i*l, height, i*l, height-fft.getBand(i)*3);
  }
  textSize(50);
  stroke(255);
  text(c, mouseX, mouseY);
  text(fft.getFreq(saw1F), mouseX+200, mouseY);


  println(fft.getFreq(1119.7266));
  /*
  if(fft.getFreq(clap)>30){
   
   w1 = 400;
   
   }*/
  beepB.check();


  clapB.check();




  /* visual */
  ellipse(width/2, height/2, beepB.inc, beepB.inc);
  ellipse(400, 400, clapB.inc, clapB.inc);

  background(0);
  directionalLight(saw1B.inc, saw1B.inc, saw1B.inc, 0, 0, -1);
  pushMatrix();
  scale(1, 1, -1);
  rotateX(-1);
  translate(0, -485, -95);


  for (int i=0; i<dim; i++) {
    for (int j=0; j<dim; j++) {
      fill(0);

      int iN = (i+1);
      int jN = (j+1);
      float c = map(noise(i*0.02, (j+frameCount)*0.02), 0, 1, 0, 255);
      fill(0, c, 255-c);

      beginShape();

      vertex(i*s, j*s, h*noise(i*0.02, (j+frameCount)*0.02));
      vertex(iN*s, j*s, h*noise(iN*0.02, (j+frameCount)*0.02));
      vertex(iN*s, jN*s, h*noise(iN*0.02, (jN+frameCount)*0.02));
      vertex(i*s, jN*s, h*noise(i*0.02, (jN+frameCount)*0.02));
      endShape();
    }
  }
  popMatrix();
}