class Particle {


  float size;
  float spread;
  float theta;
  float alpha;
  int rotD;
  color c;
  float posV;


  Particle(float size_, int rotD_) {

    size = size_/2;
    spread = height/ 500;
    rotD = rotD_;
    
  }

  void display() {
    pushMatrix();
    for (int i = 0; i < size; i +=4) {      
      for ( int j = 0; j < size; j +=4) {

        stroke(c, alpha);
           //colour adnd aplpha value defined according to fft 
       
        strokeWeight(5);
                  
        rotate(radians(theta)*rotD);
          //each point is rotated further than the last by an amount set by fft  
          // rotD is used when the object is defined to make set the direction of rotation, (1 for clockwise, -1 for anti)
       float displacer = map(noise(posV),0,1,-posV,posV);
          //used to displace praticles slightly aaccording to volume. the lower the amplitude the more sparse hte particles
        point(i * spread * displacer, j * spread * displacer  );       
      }
    }
     popMatrix();
  }
  
  void update(float fft, float env){
   
    theta = findTheta( fft );
    alpha = findAlpha(  fft );
   // println(alpha);
    c = findColour( fft );
   // posV = findPosV (env);
    posV = 10-(env*10);
  
  }
  
  float findTheta( float x){
   float theta_ = map(x, 0, 400, 0, 360);   
    return theta_;
  }
  
  float findAlpha( float x){
  float alpha_ = map(x, 0, 200, 20, 255);
  return alpha_;
  }
  
  color findColour( float x){
    float r = map(noise(x), 0, 1, 50, 180);
    float g = map(noise(x*100), 0, 1, 50, 180);
    float b = map(noise(x*325), 0, 1, 50, 180);
    color c_ = color(r, g, b);
    return c_;
    
  }
  
  float findPosV( float x ){
   
    float posV_ = map(x, 0, 1, 10, 0);
    return posV_;
  }   
}