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
  bombDefused = true;
  
  //loading backgroung image
  image(bgImg[1], 0, 0, width, height);
}

//===============================================================================================================

void loseScreen()
{
  bombExploded = true; 
  
  //loading backgroung image
  image(bgImg[0], 0, 0, width, height);
  
  //pushMatrix();
  pushStyle();
  //tint(0,0,0,150);
  imageMode(CORNER);
  image(endImg[0], 0, height, width*0.3, -height*0.3);
  image(endImg[3], width, height, -width*0.3, -height*0.3);
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
  image(endImg[1], width/2, height/2, width*0.9, height*0.8);
  image(endImg[8], width/2, height/2, width*0.55, height*0.5);
  //image(endImg[8], width*0.47, height*0.47, width*0.45, height*0.4);
  //noTint();
  popStyle();


  //button to restart
  pushStyle();
  fill(0, 0, 0, 210);
  strokeWeight(2);
  stroke(150);
  rectMode(CENTER);
  rect(width/2, height*0.85, width*0.2, height*0.08, 10);
  //fill(255,0,0);
  fill(255, 255, 0);
  textAlign(CENTER, CENTER);
  textFont(font[0]);
  textSize(24);
  text("Play Again", width/2, height*0.85);
  //popStyle();

  //for above text
  //pushStyle();
  fill(255, 255, 0);
  //fill(255, 0, 0);
  //textAlign(CENTER, CENTER);
  //textFont(font);
  textSize(36);
  text("OOPS! The Bomb Exploded. YOU LOST :(", width/2, height*0.08);
  popStyle();

  //popMatrix();
}
