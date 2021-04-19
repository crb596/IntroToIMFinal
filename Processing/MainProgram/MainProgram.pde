//for ARDUINO
import processing.serial.*;
Serial myPort;

//PROCESSING STUFF

//declaring global Variables
float wireSetupH;
float wireSetupW;
int wireCount = 0; //to count how many wires have been cut
float distMeterH;
float distMeterW;
int distDiv = 14; //for the distance meter --> max point is 14 so need to divide into 14 parts
float distReading = 0; //takes reading from distance meter
int potDiv = 4; //number of parts we want to divide the potentiometer in
float potReading = 0; //takes reading from potentiometer

Timer timer;
boolean started = false; //to keep track of whetehr game has been started or not

String[] colNames = {"blue", "green", "yellow", "red"};

//loading images
PImage[] wireImg; //wire setup on screen
PImage bgImg; //for the background
PImage arcImg;
PImage needleImg;

Wire[] wires;

//=====================================================================================================

void setup() {
  size(1350, 800);

  //connecting to ARDUINO  
  String portname=Serial.list()[1];
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  //PROCESSING STUFF

  //initializing global variables
  wireSetupH = height;
  wireSetupW = width/2;
  distMeterH = height*0.8;
  distMeterW = width/15;

  //loading images
  wireImg = new PImage[6];
  wireImg[0] = loadImage("bluewire.png"); 
  wireImg[1] = loadImage("greenwire.png");
  wireImg[2] = loadImage("yellowwire.png");
  wireImg[3] = loadImage("redwire.png");
  wireImg[4] = loadImage("wirebanner.png");
  wireImg[5] = loadImage("wirecross.png");

  bgImg = loadImage("bg2.jpeg");
  arcImg = loadImage("arc.png");
  needleImg = loadImage("needle2.png");

  //initializing class objects
  wires = new Wire[4];
  for (int i=0; i<wires.length; i++)
    wires[i] = new Wire(colNames[i]);
}

//=====================================================================================================

void draw() {
  
  startGame();
  
}

//=====================================================================================================

void serialEvent(Serial myPort) {
}
