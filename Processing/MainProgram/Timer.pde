class Timer
{
  int passedTime; //milisec
  int startTime; //milisec
  int timerLength; //milisec
  int timeLeft; //milisec
  int penalty; //reduce time by penalty in milisec
  String minutes;
  int min;
  String seconds;
  int sec;
  int reduceTimeSound;
  int timeTaken;

  Timer(int stime)
  {
    startTime = stime;
    passedTime = 0;
    timerLength = 1000*60*5+1000;
    timeLeft = timerLength/1000;
    timeTaken = 0;
  }

  //for gamescreen
  void display1()
  {
    convert(timeLeft);
    pushStyle();
    //for the box
    rectMode(CENTER);
    fill(0, 0, 0);
    strokeWeight(3);
    stroke(155, 0, 0);
    rect(width/25*2+distMeterW*4, height*0.15, distMeterW*4, distMeterW*1.5);
    //for the time
    textFont(font[0]);
    textSize(75);
    textAlign(CENTER, CENTER);
    fill(250, 0, 0);
    //text(timeLeft, width/4, height/5);
    //text(int((timeLeft/1000)/60) + " : " + (timeLeft/1000)%60, width/4, height/10);
    text(minutes + ":" + seconds, width/25*2+distMeterW*4, height*0.15);
    textSize(12);
    popStyle();
  }

  //for endscreen
  void display2()
  {
    convert(timeTaken);
    pushStyle();
    textFont(font[1]);
    textSize(55);
    textAlign(CENTER, CENTER);
    fill(250, 250, 0);
    text(minutes + ":" + seconds, width/2, height*0.7);
    popStyle();
  }

  void update() //to update the current time constantly
  {
    passedTime = millis()-startTime;
    timeLeft = timerLength-passedTime-penalty;
    if (millis()>reduceTimeSound+10)
      bombExploded = false;
  }

  void convert(int time)
  {
    min = time/1000/60;
    if (min>=0 && min <=9)
      minutes = ("0" + min + "");
    else minutes = (min + "");
    sec = (time/1000)%60;
    if (sec>=0 && sec <=9)
      seconds = ("0" + sec);
    else seconds = ("" + sec);
  }

  void reduce(int time)
  {
    sounds[0].stop();
    sounds[1].stop();
    sounds[2].stop();
    sounds[2].play();
    penalty+=time; //reduce the time when a wrong input is given
    reduceTimeSound = millis(); //record the time when bomb went off
    //bombExploded = true; //to make arduino buzzer sound for 1 sec
  }
}
