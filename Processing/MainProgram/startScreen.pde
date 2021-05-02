//float tableW = width*0.6;
//float tableH = height*0.55;
//float marginX = (width-tableW)/2;
//float marginY = (height-tableH)/2;

void startScreen()
{
  //loading backgroung image
  pushStyle();
  //image(bgImg[1], 0, height, width, -width/1200*980);
  //tint(0, 0, 0, 120);
  image(bgImg[1], 0, 0, width, height);
  //filter(BLUR, 4);
  //noTint();
  popStyle();

  //heading
  pushStyle();
  pushMatrix();
  textFont(font[1]);
  textAlign(CENTER, CENTER);
  textSize(36);
  //fill(250,250,0);
  fill(255, 200, 1);
  text("Welcome to", width/2, height*0.2);
  //fill(0, 120, 70);
  fill(255, 0, 0);
  textSize(85);
  text("EXPLODING BOMBS", width/2, height*0.35);
  //image(logo, width/2, height*0.35, width*0.55, width*0.55/1800*1275); 
  popMatrix();
  popStyle();

  //buttons
  pushStyle();
  textAlign(CENTER, CENTER);
  //fill(0, 120, 70);
  strokeWeight(3);
  //stroke(80, 150, 70);
  //fill(255, 200, 1);
  //stroke(225, 173, 1);
  fill(0, 0, 0, 210);
  stroke(0);
  rectMode(CENTER);
  rect(width/2, height*0.6, width*0.3, height*0.1, 20);
  rect(width/2, height*0.75, width*0.3, height*0.1, 20);
  textSize(24);
  fill(255);
  text("Start Game", width/2, height*0.6);
  text("How to Play", width/2, height*0.75);

  //change color on hover resp.
  if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.6-height*0.1/2 && mouseY<height*0.6+height*0.1/2)
  {
    //fill(80, 150, 70);
    //fill(225, 173, 1); //change color on hover
    fill(0, 0, 0, 210);
    stroke(225, 173, 1);
    rect(width/2, height*0.6, width*0.3, height*0.1, 20);
    textSize(28);
    fill(0, 250, 0);
    text("Start Game", width/2, height*0.6);
  }

  //text("Start Game", width/2, height*0.6);

  if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.75-height*0.1/2 && mouseY<height*0.75+height*0.1/2)
  {
    //fill(80, 150, 70);
    //fill(225, 173, 1); //change color on hover
    fill(0, 0, 0, 210);
    //stroke(225, 173, 1);
    stroke(255, 200, 1);
    rect(width/2, height*0.75, width*0.3, height*0.1, 20);
    textSize(28);
    //fill(0, 0, 250);
    fill(0, 204, 255);
    text("How to Play", width/2, height*0.75);
  }

  //text("How to Play", width/2, height*0.75);

  popStyle();
}

//============================================================================================================

void instrucScreen()
{
  //loading backgroung image
  image(bgImg[1], 0, 0, width, height);
  
  //white slate
  pushStyle();
  rectMode(CORNERS);
  fill(255,255,255,150);
  noStroke();
  rect(width*0.1, height*.1, width*0.9, height*.9);
  popStyle();
  
  //heading
  pushStyle();
  pushMatrix();
  textFont(font[1]);
  textAlign(CENTER, CENTER);
  textSize(45);
  fill(255, 0, 0);
  text("How to Play", width/2, height*0.18);
  popMatrix();
  popStyle();
  
  //body text
  pushStyle();
  textSize(24);
  fill(0);
  String s = "This is a bomb diffusing game. \n\nYou have been called into a house to diffuse a bomb. It is time sensitive. You have only got 5 minutes. \n\nOnce you enter the room with the bomb, you will see a screen with a bomb interface (Processing) and some hardware attached (Arduino). \n\nYou will have to follow a series of instructions to diffuse the bomb. These instructions can be read by your partner or by yourself if you are alone. \nFollowing the steps is crucial as a wrong move could set off the bomb or reduce your time. \nCommunication is essential. \n\n GOOD LUCK!";
  text(s, width*0.15, height*0.25, width*0.7, height*0.6);
  popStyle();
}

//============================================================================================================

void modeScreen() //to choose player mode - bomb diffuser or instructions giver
{
  //loading backgroung image
  image(bgImg[1], 0, 0, width, height);

  //heading
  pushStyle();
  pushMatrix();
  textFont(font[1]);
  textAlign(CENTER, CENTER);
  textSize(62);
  fill(255, 0, 0);
  text("Choose player mode:", width/2, height*0.3);
  popMatrix();
  popStyle();
  
  //buttons
  pushStyle();
  textAlign(CENTER, CENTER);
  //fill(0, 120, 70);
  strokeWeight(3);
  //stroke(80, 150, 70);
  //fill(255, 200, 1);
  //stroke(225, 173, 1);
  fill(0, 0, 0, 210);
  stroke(0);
  rectMode(CENTER);
  rect(width/2, height*0.55, width*0.3, height*0.1, 20);
  rect(width/2, height*0.7, width*0.3, height*0.1, 20);
  textSize(24);
  fill(255);
  text("Bomb Diffuser", width/2, height*0.55);
  text("Instructions Giver", width/2, height*0.7);

  //change color on hover resp.
  if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.55-height*0.1/2 && mouseY<height*0.55+height*0.1/2)
  {
    //fill(80, 150, 70);
    //fill(225, 173, 1); //change color on hover
    fill(0, 0, 0, 210);
    stroke(225, 173, 1);
    rect(width/2, height*0.55, width*0.3, height*0.1, 20);
    textSize(28);
    fill(0, 250, 0);
    text("Bomb Diffuser", width/2, height*0.55);
  }

  //text("Start Game", width/2, height*0.6);

  if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.7-height*0.1/2 && mouseY<height*0.7+height*0.1/2)
  {
    //fill(80, 150, 70);
    //fill(225, 173, 1); //change color on hover
    fill(0, 0, 0, 210);
    //stroke(225, 173, 1);
    stroke(255, 200, 1);
    rect(width/2, height*0.7, width*0.3, height*0.1, 20);
    textSize(28);
    //fill(0, 0, 250);
    fill(0, 204, 255);
    text("Instructions Giver", width/2, height*0.7);
  }

  popStyle();
}

//============================================================================================================

void bombInstScreen()
{
  //loading backgroung image
  image(bgImg[0], 0, 0, width, height);
  image(bgImg[3], 0, 0, width, height);
}
