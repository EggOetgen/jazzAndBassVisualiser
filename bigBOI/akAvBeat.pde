class akAvBeat {

  float freq; //the frequency to check at
  float thresh; //the threshold after which a beat is detected
  float timeOfLast = 0; //time of the last beat detected
  float timeSinceLast = 0; //time since the last beat detectd
  float timeThresh; //threshold of how long between beats are allowed to be detected
  float speed = 0.8; //speed of increase and decrease of the inc value

  float inc=0; //inc value is set to maximum if a beat is detected and slowly decreses based on speed
  float maxInc=255;
  boolean beatOn = false; //boolean for if beat is detected

  akAvBeat(float f, float th, float tith) {

    freq = f;
    thresh = th;
    timeThresh = tith;
  }

  void check() {

    if ((fftA.getFreq(freq)>thresh)&&(timeSinceLast>timeThresh)) { //checks if the amplitude of the frequency to be checked is above the threshold and it has been enough time since the last beat
      beatOn = true;
      timeOfLast = millis();
    } else { //at all time beatOn is false and the time since the last beat is recorded
      beatOn = false;
      timeSinceLast = millis()-timeOfLast;
    }

    if (beatOn == true) { //if beatOn is true, sets the inc to the maxInc

      inc = maxInc;
    }
    if (inc>1) { // inc is constantly decreased by speed until it is equal to 1

      inc *=speed;
    }else{inc = 1;}
  }
}