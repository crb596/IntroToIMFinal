void endScreen()
{
  //loading backgroung image
  //image(bgImg[0], 0, 0, width, height);

  started = false;

  if (pass)
    winScreen();
  if (fail)
    loseScreen();
}

//===============================================================================================================

void winScreen()
{
  sounds[0].stop();
  sounds[1].stop();
  sounds[2].stop();
  sounds[0].play();
  bombDefused = true;

  //loading backgroung image
  image(bgImg[1], 0, 0, width, height);

  //white slate
  pushStyle();
  rectMode(CORNERS);
  fill(0, 0, 0, 150);
  noStroke();
  rect(width*0.15, height*.1, width*0.85, height*.8);
  popStyle();

  pushStyle();
  imageMode(CORNER);
  image(endImg[9], width*0.05, width*0.05, width*0.2, width*0.2/4307*5919);
  popStyle();

  //heading
  pushStyle();
  pushMatrix();
  textFont(font[1]);
  textAlign(CENTER, CENTER);
  textSize(62);
  fill(255, 0, 0);
  text("Congratulations!", width/2, height*0.18);
  textSize(30);
  fill(255);
  String s1 = "You have successfully been able to diffuse the bomb.\n\nYou are our #1 bomb diffusing team.\n\nKeep up the GOOD WORK!";
  text(s1, width*0.5, height*0.4);
  textSize(38);
  fill(250, 250, 0);
  String s2 = "TOTAL TIME TAKEN: \n";
  text(s2, width*0.5, height*0.65);
  timer.display2();
  popMatrix();
  popStyle();

  //button to restart
  pushStyle();
  strokeWeight(2);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textFont(font[0]);
  if (mouseX > width/2-width*0.18/2 && mouseX < width/2+width*0.18/2 && mouseY > height*0.88-height*0.07/2 && mouseY < height*0.88+height*0.07/2)
  {
    fill(255, 255, 255);
    stroke(0, 0, 250);
    rect(width/2, height*0.88, width*0.18, height*0.07, 10);
    textSize(24);
  } else
  { 
    fill(255, 255, 255, 210);
    stroke(150);
    rect(width/2, height*0.88, width*0.18, height*0.07, 10);
    textSize(22);
  }
  fill(0, 0, 250);
  text("Play Again", width/2, height*0.88);

  popStyle();
}

//===============================================================================================================

void loseScreen()
{
  bombExploded = true; 

  //loading backgroung image
  image(bgImg[1], 0, 0, width, height);

  //pushMatrix();
  pushStyle();
  //tint(0,0,0,150);
  imageMode(CORNER);
  image(endImg[0], width*0.05, height*1.05, width*0.2, -height*0.2);
  image(endImg[3], width*0.95, height*1.05, -width*0.2, -height*0.2);
  imageMode(CENTER);
  image(endImg[2], width*0.55, height*0.85, width*0.9, height*0.4);
  imageMode(CORNER);
  image(endImg[4], width*0.25, height*0.9, width*0.1, height*0.1);
  image(endImg[4], width*0.65, height*0.8, width*0.1, height*0.1);
  image(endImg[5], 0, 0, width, height*0.5);
  image(endImg[6], 0, 0, width, height*0.5);
  image(endImg[7], 0, 0, width, height*0.5);

  //boom
  imageMode(CENTER);
  image(endImg[1], width/2, height/2, width*0.8, height*0.7);
  image(endImg[8], width/2, height/2, width*0.45, height*0.4);
  //image(endImg[8], width*0.47, height*0.47, width*0.45, height*0.4);
  //noTint();
  popStyle();


  //button to restart
  //pushStyle();
  //fill(0, 0, 0, 210);
  //strokeWeight(2);
  //stroke(150);
  //rectMode(CENTER);
  //rect(width/2, height*0.85, width*0.2, height*0.08, 10);
  //fill(255, 255, 0);
  //textAlign(CENTER, CENTER);
  //textFont(font[0]);
  //textSize(24);
  //text("Play Again", width/2, height*0.85);
  //popStyle();
  
  //button to restart
  pushStyle();
  strokeWeight(2);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textFont(font[0]);
  if (mouseX > width/2-width*0.18/2 && mouseX < width/2+width*0.18/2 && mouseY > height*0.88-height*0.07/2 && mouseY < height*0.88+height*0.07/2)
  {
    fill(0);
    stroke(250,250,0);
    rect(width/2, height*0.88, width*0.18, height*0.07, 10);
    textSize(24);
  } else
  { 
    fill(0,0,0, 210);
    stroke(150);
    rect(width/2, height*0.88, width*0.18, height*0.07, 10);
    textSize(22);
  }
  fill(250, 250, 0);
  text("Play Again", width/2, height*0.88);

  //for above text
  //pushStyle();
  fill(255, 255, 0);
  //fill(255, 0, 0);
  //textAlign(CENTER, CENTER);
  textFont(font[1]);
  textSize(36);
  text("OOPS! The Bomb Exploded. YOU LOST :(", width/2, height*0.08);
  popStyle();

  //popMatrix();
}
