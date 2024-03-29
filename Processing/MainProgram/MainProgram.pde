//for ARDUINO
import processing.serial.*;
import processing.sound.*;
Serial myPort;

//PROCESSING STUFF
SoundFile[] sounds = new SoundFile[3];

PFont[] font;

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
PImage[] endImg; //images for end screen
PImage arcImg;
PImage needleImg;

boolean PButton[] = {false, false}; //for the 2 buttons - green and blue on Processing interface --> 0 = green, 1 = blue

//Arduino sensor values and light booleans
boolean bombExploded = false;
boolean bombDefused = false;
int distance = distMeterMin; //(Value inputted is 0-35cm)
int potentiometer = 0;
boolean lights[] = {false, false, false, false};  //yellow light, green light, red light, blue light
int buttonDown[] = {0, 0, 0, 0}; //yellow button down, green button down, red button down, blue button down

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
  font = new PFont[5];
  font[0] = loadFont("Monaco.vlw");
  font[1] = loadFont("handwriting.vlw");
  //println(Serial.list());
  //connecting to ARDUINO  
  String portname=Serial.list()[1]; //on cole's laptop 
  //String portname=Serial.list()[4]; //on shreya's laptop
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  //PROCESSING STUFF
  sounds[0] = new SoundFile(this, "Defused.mp3");
  sounds[1] = new SoundFile(this, "Explosion.mp3");
  sounds[2] = new SoundFile(this, "Beep.mp3");

  //initializing global variables
  wireSetupH = height;
  wireSetupW = width/2;
  distMeterH = height*0.8;
  distMeterW = width/15;

  //loading images
  //for the wires
  wireImg = new PImage[6];
  wireImg[0] = loadImage("yellowwire.png"); 
  wireImg[1] = loadImage("greenwire.png");
  wireImg[2] = loadImage("redwire.png");
  wireImg[3] = loadImage("bluewire.png");
  wireImg[4] = loadImage("wirebanner.png");
  wireImg[5] = loadImage("wirecross.png");

  //background and game screen
  bgImg = new PImage[6];
  bgImg[0] = loadImage("bg2.jpeg");
  bgImg[1] = loadImage("bg7.png");
  bgImg[2] = loadImage("bg6.jpeg");
  bgImg[3] = loadImage("Instructions.png");
  bgImg[4] = loadImage("back.png");
  bgImg[5] = loadImage("home.png");
  arcImg = loadImage("arc.png");
  needleImg = loadImage("needle2.png");

  //endscreen
  endImg = new PImage[10];
  endImg[0] = loadImage("shrapnel.png");
  endImg[1] = loadImage("explode2.png");
  endImg[2] = loadImage("shrapnel2.png");
  endImg[3] = loadImage("shrapnel3.png");
  endImg[4] = loadImage("shrapnel4.png");
  endImg[5] = loadImage("cables.png");
  endImg[6] = loadImage("cable2.png");
  endImg[7] = loadImage("cables3.png");
  endImg[8] = loadImage("boom.png");
  endImg[9] = loadImage("badge1.png");

  //initializing class objects
  wires = new Wire[4];
  for (int i=0; i<wires.length; i++) {
    wires[i] = new Wire(colNames[i]);
  }

  //gameStage = new GameStage();
}

//=====================================================================================================

void draw() 
{

  //if (!fail && !pass) {
  //  gameStage.runGame();
  //}

  if (fail || pass) {
    screenMode = 6;
  }

  switch (screenMode)
  {
  case 1 :  
    startScreen();  
    //gameStage.runGame();
    break;
  case 2 : 
    instrucScreen(); 
    break;
  case 3 : 
    modeScreen(); //to choose player mode
    break;
  case 4 : 
    bombInstScreen(); //instruction screen for bomb diffusion
    break; 
  case 5 : 
    gameScreen(); //instruction screen for bomb diffusion
    //gameStage.runGame();
    break; 
  case 6 : 
    endScreen(); //instruction screen for bomb diffusion
    break;
  }
}

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  //println("S:" + s);
  if (s!=null) {
    int values[]=int(split(s, ','));
    //println(values);
    if (values.length==6) {
      potentiometer=(int)values[0];
      distance=(int)values[1];
      buttonDown[0]=(int)values[2];//Yellow button
      buttonDown[1]=(int)values[3];//Green button
      buttonDown[2]=(int)values[4];//Red button
      buttonDown[3]=(int)values[5];//Blue button
    }
  }
  myPort.write(int(lights[0])+","+int(lights[1])+","+int(lights[2])+","+int(lights[3])+","+int(bombExploded)+","+int(bombDefused)+"\n");
}


//=====================================================================================================

void mouseClicked()
{
  //for gamescreen
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
        //only for testing purposes
        //pass = true;
        //timer.timeTaken = timer.timerLength - timer.timeLeft;
      }
    }
  }

  //for buttons og different screens

  if (screenMode == 2)
  {
    //back buttton
    if (mouseX>width*0.98-height*0.08 && mouseX<width*0.98 && mouseY>height*0.98-height*0.08 && mouseY<height*0.98)
      screenMode = 1;
  }

  if (screenMode == 3)
  {
    if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.55-height*0.1/2 && mouseY<height*0.55+height*0.1/2)
      screenMode = 5;
    if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.7-height*0.1/2 && mouseY<height*0.7+height*0.1/2)
      screenMode = 4;

    //back button
    if (mouseX>width*0.98-height*0.08 && mouseX<width*0.98 && mouseY>height*0.98-height*0.08 && mouseY<height*0.98)
      screenMode = 1;
  }

  if (screenMode == 1)
  {
    if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.6-height*0.1/2 && mouseY<height*0.6+height*0.1/2)
      screenMode = 3;
    if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.75-height*0.1/2 && mouseY<height*0.75+height*0.1/2)
      screenMode = 2;
  }

  if (screenMode == 4)
  {
    //back button
    if (mouseX>width*0.98-height*0.08 && mouseX<width*0.98 && mouseY>height*0.98-height*0.08 && mouseY<height*0.98)
      screenMode = 3;
  }

  //specifically no back or home button on game screen

  if (screenMode == 6)
  {
    //play again button
    if (mouseX > width/2-width*0.18/2 && mouseX < width/2+width*0.18/2 && mouseY > height*0.88-height*0.07/2 && mouseY < height*0.88+height*0.07/2)
    {
      screenMode = 1;
      pass = false;
      fail = false;
      bombExploded = false;
      bombDefused = false;
      sounds[0].stop();
      sounds[1].stop();
      sounds[2].stop();
      lights[0] = false;
      lights[1] = false;
      lights[2] = false;
      lights[3] = false;
    }

    //home button
  }
}
