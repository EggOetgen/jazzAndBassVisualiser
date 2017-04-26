class Output {
  String filename; //string for the filepath of our selected song

  

  //used to control the camera within our 3D space
  float camx;
  float camy;
  float camz;

  //initialising audio object

  //used to control the direction of our camera's movement
  int moveX=(int)random(0, 1);
  int moveY=(int)random(0, 1);
  
  AudioOutput out;

  
  ArrayList<ParticleSystem> systems; //Initialising ArrayList of particle systems
  
  Output() {

  }

  void initialise() {
    filename="Promesses.mp3";
    camx=960;
    camy=540; 
    systems = new ArrayList<ParticleSystem>();
    systems.add(new ParticleSystem());
  }
  
  void display () {
    background(0);
    camera(camx, camy, ((height/2.0) / tan(PI*60.0 / 360.0)), width/2, height/2, 0, 0, 1, 0);
    
    for (ParticleSystem ps : systems) {
      ps.run();
      ps.addParticle();
    }
    cameraMove();
  }


  void cameraChange() {
    float r=random(1);
    if (r<0.1) { //10% chance to change camera when this is called
      moveX=(int)random(0, 1);
      moveY=(int)random(0, 1);
      if (r<0.02) {
        camx=random(160, 1800);
        camy=random(40, 1480);
      }
    }
  }

  float ln(float x) {
    return (log(x) / log(exp(1)));
  }

  //void fileSelected(File selection) {
  //  if (selection == null) {
  //    println("Window was closed or the user hit cancel.");
  //  } else {
  //    println("User selected " + selection.getAbsolutePath());
  //    filename = selection.getAbsolutePath();
  //  }
  //}

  //void stopLoop() {
  //  while (filename == null) {
  //    noLoop();
  //  }
  //  loop();
  // }

  void cameraMove() {
    if (moveX == 0) {
      if (camx<=1800) {
        camx+=5;
      } else {
        moveX=1;
      }
    }
    if (moveX == 1) {
      if (camx>=160) {
        camx-=5;
      } else {
        moveX=0;
      }
    }

    if (moveY == 0) {
      if (camy<=1480) {
        camy+=5;
      } else {
        moveY=1;
      }
    }
    if (moveY == 1) {
      if (camy>=40) {
        camy-=5;
      } else {
        moveY=0;
      }
    }
  }
}