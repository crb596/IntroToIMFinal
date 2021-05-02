void gameScreen() //was initially named startGame()
{
  //for the timer
  if (!started)
  {
    gameStage = new GameStage();
    reInitialize();
    //Timer timer;
    timer = new Timer(millis()); //initialize the object when game is started
    timer.display1();
    started = true;
  }

  gameSetup(); //needs to be called when game is started

  //update and display timer periodically
  timer.update();
  timer.display1();

  distMeter();
  potMeter();

  if (timer.timeLeft<=0)
    fail = true;

  //println(gameStage);
  //println(gameStage.buttonCol);

  gameStage.runGame();
}

//=====================================================================================================

void gameSetup()
{
  //loading backgroung image
  image(bgImg[0], 0, 0, width, height);

  //for the wire setup
  //tint(0, 0, 0, 100);
  //image(wireImg[5], width-wireSetupW+width/25, 0, wireSetupW, wireSetupH);
  //noTint();
  for (int i=0; i<wires.length; i++)
    if (wires[i].state)
      image(wireImg[i], width-wireSetupW+width/25, 0, wireSetupW, wireSetupH);
  image(wireImg[4], width-wireSetupW+width/25, 0, wireSetupW, wireSetupH);

  //for the distance meter (thermometer)
  pushStyle();
  strokeWeight(5);
  stroke(150);
  fill(180);
  //check
  rect(width/25, height*0.05, distMeterW, distMeterH, 50);
  textFont(font[0]);
  textSize(12);
  for (int i = 1; i <= distDiv; i++)
  {
    //textAlign(CENTER);
    fill(0);
    //text("-- "+ (distDiv-i+1) + " --", width/25, height/2-distMeterH/2+distMeterH/(distDiv+1)*i);
    text("-- "+ (distDiv-i+1) + " --", width/25, height*0.05+distMeterH/(distDiv+1)*i);
  }

  //submit button
  strokeWeight(2);
  stroke(150); //i.e. game has been started
  if (mouseX >= width/25*2+distMeterW*2 && mouseX <= width/25*2+distMeterW*6 
    && mouseY >= height-(height-distMeterH)/2-height*0.1/2 && mouseY <= height-(height-distMeterH)/2+height*0.1/2 )
    fill(150, 0, 0, 99);
  else
    fill(150, 0, 0, 80);
  rectMode(CENTER);
  rect(width/25*2+distMeterW*4, height-(height-distMeterH)/2, distMeterW*4, height*0.1, 10);
  textAlign(CENTER, CENTER);
  fill(150);
  textSize(42);
  text("SUBMIT", width/25*2+distMeterW*4, height-(height-distMeterH)/2);
  popStyle();

  //for the potentiometer (speedometer)
  pushStyle();
  //fill(220);
  //arc(width/25*2+distMeterW*4, height/15+distMeterH, distMeterW*5, distMeterW*5, PI, 2*PI);
  //image(arcImg, width/25*2+distMeterW*1.5-5, height/15+distMeterH-distMeterW*5*191/390-10, distMeterW*5+12, distMeterW*5*191/390+10);
  //OR
  noStroke();
  fill(128, 255, 128);
  arc(width/25*2+distMeterW*4, distMeterH, distMeterW*5, distMeterW*5, PI, 5*PI/4);
  fill(255, 255, 102);
  arc(width/25*2+distMeterW*4, distMeterH, distMeterW*5, distMeterW*5, 5*PI/4, 6*PI/4);
  fill(255, 166, 77);
  arc(width/25*2+distMeterW*4, distMeterH, distMeterW*5, distMeterW*5, 6*PI/4, 7*PI/4);
  fill(255, 77, 77);
  arc(width/25*2+distMeterW*4, distMeterH, distMeterW*5, distMeterW*5, 7*PI/4, 8*PI/4);
  strokeWeight(5);
  stroke(180);
  noFill();
  arc(width/25*2+distMeterW*4, distMeterH, distMeterW*5, distMeterW*5, PI, 2*PI, CHORD);
  //image(needleImg, width/25*2+distMeterW*4, height/15+distMeterH-15, distMeterW*2.5, distMeterW*2.5*18/200);
  popStyle();

  //green and blue signal buttons
  pushStyle();
  rectMode(CENTER);
  strokeWeight(3);
  stroke(180);
  //fill(0,168,107,75); //actual wire color
  //fill(16,52,166,75); //actual wire color
  if (PButton[0] == true)
  {
    fill(115, 250, 37);
    rect(width/25*2+distMeterW*4-distMeterW*1.2, height*0.15+distMeterW*2, height*0.15, height*0.15, 10);
    //fill(0, 0, 0, 99);
    //rect(width/25*2+distMeterW*4-distMeterW*1.2, height*0.15+distMeterW*2, height*0.15, height*0.15, 10);
    fill(0, 0, 24);
    rect(width/25*2+distMeterW*4+distMeterW*1.2, height*0.15+distMeterW*2, height*0.15, height*0.15, 10);
  } else if (PButton[1] == true)
  {
    fill(10, 242, 238);
    rect(width/25*2+distMeterW*4+distMeterW*1.2, height*0.15+distMeterW*2, height*0.15, height*0.15, 10);
    fill(0, 24, 0);
    rect(width/25*2+distMeterW*4-distMeterW*1.2, height*0.15+distMeterW*2, height*0.15, height*0.15, 10);
  } else {
    fill(0, 24, 0);
    rect(width/25*2+distMeterW*4-distMeterW*1.2, height*0.15+distMeterW*2, height*0.15, height*0.15, 10);
    fill(0, 0, 24);
    rect(width/25*2+distMeterW*4+distMeterW*1.2, height*0.15+distMeterW*2, height*0.15, height*0.15, 10);
  }
  popStyle();

  //led signal color
  if (buttonDown[0]==1) //i.e. yellow color
    fill(250, 250, 0);
  else if (buttonDown[1]==1) //i.e. green color
    fill(0, 250, 0);
  else if (buttonDown[2]==1) //i.e. red color
    fill(250, 0, 0);
  else if (buttonDown[3]==1) //i.e. blue color
    fill(0, 0, 250);
  else
    fill(0);
  ellipse(width/25+distMeterW/2, height*0.93, height*0.05, height*0.05);
}

//=====================================================================================================

void distMeter()
{
  float range = map(distance, distMeterMax, distMeterMin, 0, distMeterH-distMeterH/distDiv); // map values here from reading from arduino
  //float range = map(mouseX, 0, width, 0, distMeterH-distMeterH/distDiv); //for now
  //show the reading go up and down in distance meter on screen
  pushStyle();
  fill(150, 0, 0, 80);
  noStroke();
  //height*0.05+distMeterH/(distDiv+1)*i)
  //rect(width/25, height/2+distMeterH/2-distMeterH/distDiv/2, distMeterW, -1*range, 20);
  //rect(width/25, height*0.05+distMeterH-distMeterH/distDiv/2, distMeterW, -1*range, 20);
  rect(width/25, height*0.05+distMeterH, distMeterW, -1*range, 8, 8, 50, 50);
  textFont(font[0]);
  textSize(12);
  for (int i = 1; i <= distDiv; i++)
  {
    //textAlign(CENTER);
    fill(0);
    //text("-- "+ (distDiv-i+1) + " --", width/25, height/2-distMeterH/2+distMeterH/(distDiv+1)*i);
    text("-- "+ (distDiv-i+1) + " --", width/25, height*0.05+distMeterH/(distDiv+1)*i);
  }
  popStyle();
}

//=====================================================================================================

void potMeter()
{
  pushMatrix();
  float range = map(potentiometer, 0, 1023, 0, -PI);
  translate(width/25*2+distMeterW*4, distMeterH);
  rotate(range);
  //println(range);
  image(needleImg, 0, -10, distMeterW*2.5, distMeterW*2.5*18/200);
  //rotate(0);
  //translate(0,0); 
  popMatrix();
}

//=====================================================================================================

void reInitialize()
{
  bombExploded = false;
  bombDefused = false;
  pass = false;  
  fail = false;  
  correctRounds = 0;
  PButton[0] = false;
  PButton[1] = false;
}
