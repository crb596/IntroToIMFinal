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
  sounds[0].stop();
  sounds[1].stop();
  sounds[2].stop();
  sounds[0].play();
  bombDefused = true;
}

void loseScreen()
{
  bombExploded = true;
}
