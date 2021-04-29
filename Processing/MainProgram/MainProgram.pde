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
int distDiv = 10; //for the distance meter --> max point is 14 so need to divide into 14 parts
int potDiv = 4; //number of parts we want to divide the potentiometer in

Timer timer;
boolean started = false; //to keep track of whetehr game has been started or not
int distMeterMin = 5;
int distMeterMax = 35;
String[] colNames = {"blue", "green", "yellow", "red"};

//loading images
PImage[] wireImg; //wire setup on screen
PImage[] bgImg; //for the background
PImage arcImg;
PImage needleImg;

boolean PButton[] = {false, false}; //for the 2 buttons - green and blue on Processing interface --> 0 = green, 1 = blue

//Arduino sensor values and light booleans
boolean bombExploded = false;
int distance = distMeterMin; //(Value inputted is 0-35cm)
int potentiometer = 0;
boolean lights[] = {false, false, false, false};  //yellow light, green light, red light, blue light
int buttonDown[] = {0, 0, 0, 0}; //yellow button down, green button down, red button down, blue button down
int buttonPressed[] = {0, 0, 0, 0}; //yellow button pressed, green button pressed, red button pressed, blue button pressed

Wire[] wires;

GameStage gameStage; //used to control flow of game
boolean pass = false;  //Won game
boolean fail = false;  //Failed game
boolean submitButton = false;
int correctRounds = 0; //How many times has the player completed all four stages (3 times needed to win)

int screenMode = 1; //1 for start, 2 for general instructions screen, 
//3 for choose player mode, 4 for bomb instruc., 5 for game screen, 6 for end screen

//=====================================================================================================

void setup() {
  //fullScreen();
  size(1350, 800);
  font = loadFont("Monaco.vlw");
  //println(Serial.list());
  //connecting to ARDUINO  
  //String portname=Serial.list()[1]; //on cole's laptop 
  String portname=Serial.list()[4]; //on shreya's laptop
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
  wireImg[0] = loadImage("yellowwire.png"); 
  wireImg[1] = loadImage("greenwire.png");
  wireImg[2] = loadImage("redwire.png");
  wireImg[3] = loadImage("bluewire.png");
  wireImg[4] = loadImage("wirebanner.png");
  wireImg[5] = loadImage("wirecross.png");

  bgImg = new PImage[3];
  bgImg[0] = loadImage("bg2.jpeg");
  bgImg[1] = loadImage("bg3.jpeg");
  arcImg = loadImage("arc.png");
  needleImg = loadImage("needle2.png");

  //initializing class objects
  wires = new Wire[4];
  for (int i=0; i<wires.length; i++) {
    wires[i] = new Wire(colNames[i]);
  }

  gameStage = new GameStage();
}

//=====================================================================================================

void draw() {

  switch (screenMode)
  {
  case 1 :  
    startScreen();    
    break;
    //case 2 : 
    //  instrucScreen(); 
    //  break;
    //case 3 : 
    //  chooseScreen(); //to choose player mode
    //  break;
    //case 4 : 
    //  bombInstScreen(); //instruction screen for bomb diffusion
    //  break; 
  case 5 : 
    gameScreen(); //instruction screen for bomb diffusion
    break; 
  case 6 : 
    endScreen(); //instruction screen for bomb diffusion
    break;
  }

  //startGame();
  //if (!fail && !pass) {
  //  gameStage.runGame();
  //}
  //if (fail) {
  //  bombExploded = true;
  //  screenMode = 6;
  //}

  //wires[1].state=false;
}

//=====================================================================================================

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  //println("S:" + s);
  if (s!=null) {
    int values[]=int(split(s, ','));
    //println(values);
    if (values.length==10) {
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


//=====================================================================================================

void mousePressed()
{
  if (started) //i.e. game has been started
  {
    if (mouseX >= width/25*2+distMeterW*2 && mouseX <= width/25*2+distMeterW*6 
      && mouseY >= height-(height-distMeterH)/2-height*0.1/2 && mouseY <= height-(height-distMeterH)/2+height*0.1/2 )
    {
      submitButton = true; //submit button was clicked, so make it true
      ///check for game stage
      if (!(gameStage.gameStage == 2 || (gameStage.gameStage == 1 && PButton[1] == true)))
      {
        timer.reduce(10000); //reduce 10 secs
        submitButton = false;
      }
    }
  }
}
