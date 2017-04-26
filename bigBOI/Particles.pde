class Particles {
  float radius;
  float frequency;
  PVector velocity;
  float angle;
  float speed=0;
  float z;
  float lifespan=255;
  float col;
  float audioVis;

  Particles(float r, float f, float l) {
    radius = r;
    frequency =f;
    angle = l;
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity = new PVector(cos(angle)*audioVis+width/2, sin(angle)*audioVis+height/2, (output.ln(radius)*200)-1000);
    audioVis = radius+audio.level;
    //audioVelocity = new PVector(cos(angle)*audioVis+width/2, sin(angle)*audioVis+height/2);
    float col=frequency*audio.level;
    angle=angle+col;
    speed+=0.1;
    radius-=speed;
  }

  boolean isDead() {
    if (radius<=audio.level) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    float r=random(1);
    stroke(audio.amp*255);
    if (r<0.5)
      strokeWeight(audio.amp*10);

    else
      strokeWeight(4);

    point(velocity.x, velocity.y, velocity.z);
    stroke(audio.amp*150, (frameCount%255), audio.amp*255);
    point(velocity.x, velocity.y, velocity.z-(radius*0.5));
  }
}