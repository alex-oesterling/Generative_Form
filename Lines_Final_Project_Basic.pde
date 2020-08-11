import java.util.*;
import processing.sound.*;
import java.io.File;
import java.io.FileNotFoundException;

List<PShape> queue = new ArrayList<PShape>();
List<Float> amplitudes = new ArrayList<Float>();
FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];
float noisefloor;
Scanner scanner;
boolean makeText;
String currentText;
int alphaValue;
long timer;

void setup(){
  size(1000, 1000);
  fftSetup();
  scannerSetup();
  noisefloor = maxValue();
  timer = System.currentTimeMillis();
}

void draw(){
  background(255, 255, 255);
  iterate();
  fft.analyze(spectrum);
  for(PShape ps : queue){
    pushMatrix();
    strokeWeight(generateThickness());
    shape(ps);
    popMatrix();
  }
}

void iterate(){
  
  float xCentral = 500;
  float yCentral = 500;
  
  Random random = new Random();
  
  float x1 = (float)(random.nextGaussian()*100+xCentral);
  float y1 = (float)(random.nextGaussian()*100+yCentral);
  float x2;
  float y2;
  if(Math.random()>.5){
      x2 = (float)(random.nextGaussian()*200+xCentral);
      y2 = y1;
  } else {
      x2 = x1;
      y2 = (float)(random.nextGaussian()*200+yCentral);
  }
  pushMatrix();
  //strokeWeight(random(1, 10));
  //stroke(random(0, 255), random(0, 255), random(0, 255));
  PShape line = createShape(LINE, x1, y1, x2, y2);
  popMatrix();
  queue.add(line);
  if(queue.size() > 50){
    queue.remove(0);
  }
  if(System.currentTimeMillis() > timer + 5000){
    if(!makeText){
      makeText = true;
      alphaValue = 0;
      currentText = getPhrase();
      timer = System.currentTimeMillis();
    } else {
      makeText = false;
      timer = System.currentTimeMillis();
    }
  }
  if(makeText == true){
    fill(0, 0, 0, alphaValue);
    text(currentText, 500, 50);
    textAlign(CENTER);
    if(alphaValue < 255){
      alphaValue++;
    }
  }
}

float generateThickness(){
  float out = 1.0;
  amplitudes.add(maxValue()*1000);
  if(amplitudes.size()>random(1200, 2400)){
    out = amplitudes.remove(0);
  }
  float min = out;
  float max = min+5;
  return random(min, max);
}
