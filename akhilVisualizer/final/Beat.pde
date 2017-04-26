class Beat{
 
  
  float freq;
  float thresh;
  float timeOfLast = 0;
  float timeSinceLast = 0;
  float timeThresh;
  float speed = 0.8;
  
  float inc=0;
  float maxInc=255;
  boolean beatOn = false;
 
  Beat(float f,float th,float tith){
    
    freq = f;
    thresh = th;
    timeThresh = tith;
    
  }
  
  void check() {
    
    if((fft.getFreq(freq)>thresh)&&(timeSinceLast>timeThresh)){
      beatOn = true;
      timeOfLast = millis();
    }
    else{
      beatOn = false;
      timeSinceLast = millis()-timeOfLast;
      
    }
    
    if (beatOn == true){
     
      inc = maxInc;
      
    }
    if (inc>1){
     
      inc *=speed;
    }
    
  }
}