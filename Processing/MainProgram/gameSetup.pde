void startGame()
{
  //for the timer
  if (!started)
  {
    timer = new Timer(millis()); //initialize the object when game is started
    timer.display();
    started = true;
  }

  gameSetup(); //needs to be called when game is started

  //update and display timer periodically
  timer.update();
  timer.display();

  distMeter();
  potMeter();
}

//=====================================================================================================

void gameSetup()
{
  //loading backgroung image
  image(bgImg, 0, 0, width, height);

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
  rect(width/25, height/15, distMeterW, distMeterH, 50);
  for (int i = 1; i <= distDiv; i++)
  {
    //textAlign(CENTER);
    fill(0);
    text("-- "+ (distDiv-i+1) + " --", width/25, height/15+distMeterH/(distDiv+1)*i); //not able to use distDiv here... WHY??
  }
  //submit button
  strokeWeight(2);
  stroke(150);
  fill(150, 0, 0, 80);
  rect(width/25, height/15+distMeterH+height/30, distMeterW, height*0.05, 10);
  textAlign(CENTER);
  fill(150);
  text("SUBMIT", width/25+distMeterW/2, height/15+distMeterH+height/15);
  popStyle();

  //for the potentiometer (speedometer)
  pushStyle();
  //fill(220);
  //arc(width/25*2+distMeterW*4, height/15+distMeterH, distMeterW*5, distMeterW*5, PI, 2*PI);
  //image(arcImg, width/25*2+distMeterW*1.5-5, height/15+distMeterH-distMeterW*5*191/390-10, distMeterW*5+12, distMeterW*5*191/390+10);
  //OR
  noStroke();
  fill(128, 255, 128);
  arc(width/25*2+distMeterW*4, height/15+distMeterH, distMeterW*5, distMeterW*5, PI, 5*PI/4);
  fill(255, 255, 102);
  arc(width/25*2+distMeterW*4, height/15+distMeterH, distMeterW*5, distMeterW*5, 5*PI/4, 6*PI/4);
  fill(255, 166, 77);
  arc(width/25*2+distMeterW*4, height/15+distMeterH, distMeterW*5, distMeterW*5, 6*PI/4, 7*PI/4);
  fill(255, 77, 77);
  arc(width/25*2+distMeterW*4, height/15+distMeterH, distMeterW*5, distMeterW*5, 7*PI/4, 8*PI/4);
  strokeWeight(5);
  stroke(180);
  noFill();
  arc(width/25*2+distMeterW*4, height/15+distMeterH, distMeterW*5, distMeterW*5, PI, 2*PI, CHORD);
  //image(needleImg, width/25*2+distMeterW*4, height/15+distMeterH-15, distMeterW*2.5, distMeterW*2.5*18/200);

  popStyle();
}

//=====================================================================================================

void distMeter()
{
  float range = map(distReading, distMeterMin, distMeterMax, 0, distMeterH-distMeterH/distDiv); // map values here from reading from arduino
  //float range = map(mouseX, 0, width, 0, distMeterH-distMeterH/distDiv); //for now
  //show the reading go up and down in distance meter on screen
  pushStyle();
  fill(150, 0, 0, 80);
  noStroke();
  rect(width/25, height/15+distMeterH-distMeterH/distDiv/2, distMeterW, -1*range, 20);
  for (int i = 1; i <= distDiv; i++)
  {
    //textAlign(CENTER);
    fill(0);
    text("-- "+ (distDiv-i+1) + " --", width/25, height/15+distMeterH/(distDiv+1)*i);
  }
  popStyle();
}

//=====================================================================================================

void potMeter()
{
  pushMatrix();
  float range = map(mouseX, 0, width, 0, -PI);
  translate(width/25*2+distMeterW*4, height/15+distMeterH);
  rotate(range);
  //println(range);
  image(needleImg, 0, -10, distMeterW*2.5, distMeterW*2.5*18/200);
  //rotate(0);
  //translate(0,0); 
  popMatrix();
}
