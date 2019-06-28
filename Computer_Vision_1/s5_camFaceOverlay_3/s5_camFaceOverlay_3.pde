///modified by Adrion T. Kelley 2018



import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import java.util.Collections;
import java.util.Random;
import dawesometoolkit.*;



PImage img;
PImage faceImg;
boolean newFrame=false;
ArrayList<PVector> vectors;
DawesomeToolkit dawesome;
ArrayList<Integer> colors;

int count  = 0;


//int w = 640, h = 480;


OpenCV cvImg;
Capture cam;
Rectangle[] faces;

void setup(){
  size(640, 480);
  //frameRate(4);
  
  
  //surface.setSize(320, 240);
  cam = new Capture(this, 40*4, 30*4, 4); 
  
 
  cam.start();
  
  
  cvImg = new OpenCV(this, 640, 480);
  
  img = new PImage(640, 480);
  
  dawesome = new DawesomeToolkit(this);
    colors = dawesome.colorSpectrum(160, 100, 50);
 
  cvImg.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  faceImg = loadImage("1.png");
}

void draw(){
  background(0);
  
  
  
  
  if (newFrame)
  {
    newFrame=false;
    //image(cam,-1000,-1000,width,height);
    img.copy(cam, 0, 0, cam.width, cam.height, 
        0, 0, img.width, img.height);
    
  }
  
  //image(img, 0, 0);
  
  
  cvImg.loadImage(img);
  
   
  
  
  
  
  faces = cvImg.detect();
  
  
  
  
  
  cvImg.threshold(70);
  vectors = dawesome.maskToVectors(cvImg.getOutput());
  //image(cvImg.getOutput(), 0, 0);
  
  Collections.shuffle(vectors, new Random(count));
  smooth();
        
         
    
   int count = 0;
  for (PVector p: vectors){
    if (count%4==0){
                        noStroke();
      fill(colors.get(count%colors.size()));
      float dotSize = count%30;
      if (count%4==0){
        //rect(p.x, p.y, dotSize, dotSize);
      //} else {
        ellipse(p.x, p.y, dotSize, dotSize);
      }
    }
    count++;
  }
  
  
  
  for(int i = 0; i < faces.length; i++){
    image(faceImg, faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
  
}

void captureEvent(Capture cam)
{
  cam.read();
  newFrame = true;
}