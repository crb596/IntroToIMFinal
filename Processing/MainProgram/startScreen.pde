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
  image(bgImg[0], 0, 0, width, height);
  //filter(BLUR, 4);
  //noTint();
  popStyle();

  //heading
  pushStyle();
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Welcome to", width/2, height*0.2);
  //fill(0, 120, 70);
  fill(255, 255, 255);
  textSize(75);
  text("EXPLODING BOMBS", width/2, height*0.35);
  //image(logo, width/2, height*0.35, width*0.55, width*0.55/1800*1275); 

  //buttons
  //fill(0, 120, 70);
  strokeWeight(5);
  //stroke(80, 150, 70);
  fill(255, 200, 1);
  stroke(225, 173, 1);
  rectMode(CENTER);
  rect(width/2, height*0.6, width*0.3, height*0.1, 20);
  rect(width/2, height*0.75, width*0.3, height*0.1, 20);
  textSize(24);
  fill(255);
  text("Start Game", width/2, height*0.6);
  text("Instructions", width/2, height*0.75);

  //change color on hover resp.
  if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.6-height*0.1/2 && mouseY<height*0.6+height*0.1/2)
  {
    //fill(80, 150, 70);
    fill(225, 173, 1); //change color on hover
    stroke(225, 173, 1);
    rect(width/2, height*0.6, width*0.3, height*0.1, 20);
    textSize(28);
    fill(200);
    text("Start Game", width/2, height*0.6);
  }
  if (mouseX>width/2-width*0.3/2 && mouseX<width/2+width*0.3/2 && mouseY>height*0.75-height*0.1/2 && mouseY<height*0.75+height*0.1/2)
  {
    //fill(80, 150, 70);
    fill(225, 173, 1); //change color on hover
    stroke(225, 173, 1);
    rect(width/2, height*0.75, width*0.3, height*0.1, 20);
    textSize(28);
    fill(200);
    text("Instructions", width/2, height*0.75);
  }
  
  popStyle();
}
