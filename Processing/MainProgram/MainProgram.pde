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
//boolean yellowLight = false;  //SHould the light be on or off
//int yellowButtonPressed = 0;  //Was the button just pressed
//int yellowButtonDown = 0;  //What is the current state of the button (down or up)
////boolean greenLight = false;  //SHould the light be on or off
//int greenButtonPressed = 0;  //Was the button just pressed
//int greenButtonDown = 0;  //What is the current state of the button (down or up)
////boolean redLight = true;  //SHould the light be on or off
//int redButtonPressed = 0;  //Was the button just pressed
//int redButtonDown = 0;  //What is the current state of the button (down or up)
////boolean blueLight = true;  //SHould the light be on or off
//int blueButtonPressed = 0;  //Was the button just pressed
//int blueButtonDown = 0;  //What is the current state of the button (down or up)
boolean bombExploded = false;
int distance = 0; //(Value inputted is 0-35cm)
int potentiometer = 0;
boolean lights[] = {false, false, false, false};  //yellow light, green light, red light, blue light
int buttonDown[] = {0, 0, 0, 0}; //yellow button down, green button down, red button down, blue button down
int buttonPressed[] = {0, 0, 0, 0}; //yellow button pressed, green button pressed, red button pressed, blue button pressed



Wire[] wires;

GameStage gameStage; //used to control flow of game
boolean pass = false;  //Won game
boolean fail = false;  //Failed game

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
  for (int i=0; i<wires.length; i++){
    wires[i] = new Wire(colNames[i]);
  }
  
  gameStage = new GameStage();
}

//=====================================================================================================

void draw() {
  startGame();
  if(!fail && !pass){
    gameStage.runGame();
  }
  if(fail){
    bombExploded = true;
  }
  
  
}

//=====================================================================================================

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  //println("S:" + s);
  if (s!=null){
    int values[]=int(split(s,','));
    //println(values);
    if (values.length==10){
      potentiometer=(int)values[0];
      distance=(int)values[1];
      buttonPressed[0]=(int)values[2];  //Yellow button
      buttonDown[0]=(int)values[3];
      buttonPressed[1]=(int)values[4];  //Green button
      buttonDown[1]=(int)values[5];
      buttonPressed[2]=(int)values[6];  //Red button
      buttonDown[2]=(int)values[7];
      buttonPressed[3]=(int)values[8];  //Blue button
      buttonDown[3]=(int)values[9];
    }
  }
  myPort.write(int(lights[0])+","+int(lights[1])+","+int(lights[2])+","+int(lights[3])+","+int(bombExploded)+"\n");
}
