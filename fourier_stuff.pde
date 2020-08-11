void fftSetup(){
    // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
}

float maxValue(){
  float max = -1;
  for(int i = 0; i < spectrum.length; i++){
    if(spectrum[i] > max){
      max = spectrum[i];
    }
  }
  return max;
}

int maxIndex(){
  float max = -1;
  int maxIndex = -1;
  for(int i = 0; i < spectrum.length; i++){
    if(spectrum[i] > max){
      max = spectrum[i];
      maxIndex = i;
    }
  }
  return maxIndex;
}
