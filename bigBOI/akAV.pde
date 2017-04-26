

class akAv {

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
akAvBeat beepB;
akAvBeat clapB;
akAvBeat saw1B;
akAvBeat kickB;
akAvBeat sawB;


//drawing objects
float c = 0;

int dim = 100; //the dimensions of the grid
int s = 1680/dim; //the size of each square in grid
float h = 0; //the multiplier for the noise 




akAv() {
  
   fft = new FFT(song.bufferSize(), song.sampleRate());
  noStroke();
  
  //initalizing all the objects to detect various instruments in song
  beepB = new akAvBeat(beepF, 40, 500); 
  clapB = new akAvBeat(clapF, 5, 10);
  saw1B = new akAvBeat(saw1F, 40, 1000);
  kickB = new akAvBeat(kickF, 100, 200);
  sawB = new akAvBeat(sawF,10, 100);
  
  
}



void akAvDraw() {
  
   
  //these functions check if a beat has been triggered
  
  saw1B.check();

  beepB.check();

  clapB.check();

  kickB.check();

  sawB.check();

  // sets the height of the noise to 100 and reduces it if a kick is detected
  h =100+(255 -kickB.inc)*10;

  colorMode(RGB);
  background(0, beepB.inc/2, clapB.inc/2); //the g component of the color is set to 255 if a beep is detected and the b is set to 255 if a clap is detected

  pushMatrix();
  
  //moves the grid into the view
  scale(1, 1, -1);
  rotateX(2);
  translate(0, -965, -309);

  //creates the grid
  for (int i=0; i<dim; i++) {
    for (int j=0; j<dim; j++) {
      
      //calculates the next vertices
      int iN = (i+1);
      int jN = (j+1);
      
      //sets the b component of the stroke to its height relative to the z axis
      float c = map(noise(i*0.02, (j+frameCount)*0.02), 0, 1, 0, 255);
      
      //sets the r and b values of the stroke to 255 if a synth is heard
      stroke(saw1B.inc, saw1B.inc, c);
      
      //increases the stroke width if a different synth is heard
      strokeWeight(map(sawB.inc,1,255,1,10));
      
      noFill();
      beginShape();
      //creates a grid with y values corresponding to perlin noise. the y axis of the noise is constantly increased
      vertex(i*s, j*s, (h)*(noise(i*0.02, (j+frameCount)*0.02)-0.5));
      vertex(iN*s, j*s, (h)*(noise(iN*0.02, (j+frameCount)*0.02)-0.5));
      vertex(iN*s, jN*s, (h)*(noise(iN*0.02, (jN+frameCount)*0.02)-0.5));
      vertex(i*s, jN*s, (h)*(noise(i*0.02, (jN+frameCount)*0.02)-0.5));
      
      endShape();
    }
  }
  popMatrix();  
  
}




}