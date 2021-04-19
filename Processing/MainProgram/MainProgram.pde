//for ARDUINO
import processing.serial.*;
Serial myPort;

//PROCESSING STUFF

PFont font;

//declaring global Variables
float wireSetupH;
float wireSetupW;
int wireCount = 0; //to count how many wires have been cut
float distMeterH;
float distMeterW;
int distDiv = 14; //for the distance meter --> max point is 14 so need to divide into 14 parts
int potDiv = 4; //number of parts we want to divide the potentiometer in

Timer timer;
boolean started = false; //to keep track of whetehr game has been started or not
int distMeterMin = 5;
int distMeterMax = 35;
String[] colNames = {"blue", "green", "yellow", "red"};

//loading images
PImage[] wireImg; //wire setup on screen
PImage bgImg; //for the background
PImage arcImg;
PImage needleImg;

//Arduino sensor values and light booleans
boolean yellowLight = false;  //SHould the light be on or off
int yellowButtonPressed = 0;  //Was the button just pressed
int yellowButtonDown = 0;  //What is the current state of the button (down or up)
boolean greenLight = false;  //SHould the light be on or off
int greenButtonPressed = 0;  //Was the button just pressed
int greenButtonDown = 0;  //What is the current state of the button (down or up)
boolean redLight = true;  //SHould the light be on or off
int redButtonPressed = 0;  //Was the button just pressed
int redButtonDown = 0;  //What is the current state of the button (down or up)
boolean blueLight = true;  //SHould the light be on or off
int blueButtonPressed = 0;  //Was the button just pressed
int blueButtonDown = 0;  //What is the current state of the button (down or up)
boolean bombExploded = false;
int distance = 0; //(Value inputted is 0-35cm)
int potentiometer = 0;


Wire[] wires;

//=====================================================================================================

void setup() {
  size(1350, 800);
  font = loadFont("Monaco.vlw");

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
  
  //test arduino
  if(yellowButtonDown == 1){
    yellowLight = true;
  }
  else{
    yellowLight = false;
  }
  if(blueButtonDown == 1){
    blueLight = true;
  }
  else{
    blueLight = false;
  }
  if(redButtonDown == 1){
    redLight = true;
  }
  else{
    redLight = false;
  }
  if(greenButtonDown == 1){
    greenLight = true;
  }
  else{
    greenLight = false;
  }
}

//=====================================================================================================

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  println("S:" + s);
  if (s!=null){
    int values[]=int(split(s,','));
    //println(values);
    if (values.length==10){
      potentiometer=(int)values[0];
      distance=(int)values[1];
      yellowButtonPressed=(int)values[2];
      yellowButtonDown=(int)values[3];
      greenButtonPressed=(int)values[4];
      greenButtonDown=(int)values[5];
      redButtonPressed=(int)values[6];
      redButtonDown=(int)values[7];
      blueButtonPressed=(int)values[8];
      blueButtonDown=(int)values[9];
    }
  }
  myPort.write(int(yellowLight)+","+int(greenLight)+","+int(redLight)+","+int(blueLight)+","+int(bombExploded)+"\n");
}
