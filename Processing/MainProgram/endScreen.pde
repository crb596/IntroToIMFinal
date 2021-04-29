void endScreen()
{
  //loading backgroung image
  image(bgImg[0], 0, 0, width, height);
  
  if (pass)
    winScreen();
  if (fail)
    loseScreen();
}

void winScreen()
{
  bombDefused = true;
}

void loseScreen()
{
 
    bombExploded = true; 
}
