class Audio {
  float amp;
  float level;
  float maxLevel=40;
  PVector pulseVector;
  float pulseRadius=0;
  float speed = 50;



  Audio() {
  }
  
  void run() {
    analysis();
    //pulse();
  }

  void analysis() {
    amp = map(envFollow.getLastValues()[0], 0, 1, 0.2, 1 ); //mapping amplitude with a minimum value of 0.2
    level = amp*200; //setting level to amp*200 so that it ranges from values 40 through 200
    if (level>=maxLevel && pulseRadius>=800) {
      maxLevel=level+10; //level is the amplitude value of the small white particles and maxR is their maximum value
      pulseRadius=maxLevel;
      speed=50;
    }
  }
  
  //function to create a circular pulse that spreads out from the center approximately matching the beat of the song
  void pulse() {
    if (pulseRadius<1000)
      pulseRadius+=speed;

    speed+=0.4*amp; //pulse accelerates out

    if (maxLevel>level) {
      maxLevel--; //we constantly decrease maxLevel's value so that it's always pushed fowards by level
      stroke(140, 200, 255);
      strokeWeight(10);
      noFill();
      beginShape();
      for (int i=0; i<360; i+=1) {
        float a = radians(i);
        pulseVector = new PVector(pulseRadius*cos(a)+width/2, pulseRadius*sin(a)+height/2, (output.ln(pulseRadius)*200)-1000);
        vertex(pulseVector.x, pulseVector.y, pulseVector.z );
      }
      endShape(CLOSE);
      //cameraChange();
    }
  }
}


/*
My project is an audio visual particle system that uses an arraylist of particles within an arraylist of particle systems to create a natural dynamic of particle
movement and aesthetic that is also determined by tracking the amplitude of a chosen song. The direction of the particle systems creates a vortex look where
all white particles accelerate inwards towards the center in a circular motion on the x and y axis and a motion that is determined by the natural logarithmic value
of it's radius on the z axis. For each of these white particles there is also a coloured particle with the same x and y position but with the inverse of the logarithmic
Z value to create a dome like shape where the two particle systems meet in the center. by using an envelope follower, the amplitude of the song at any given time
determines the uniform speed at which each particle moves as well as the brightness of the particles and the strokeWeight of half the particles (where the other half
stays in a uniform stroke weight). There is also a pulse effect that shoots out a blue ring from the center whenever the amplitude of the song reaches a distinctly
high value, usually on a kick drum hit which causes the blue pulse to approximately match the rhythm & beat of the song. With this same event, there is also a 10% chance
that the camera will change perspective to a new angle and direction which simulates the aesthetic of a music video where the camera cuts match the rhythm of the song.
*/