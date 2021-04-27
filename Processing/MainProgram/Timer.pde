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

  Timer(int stime)
  {
    startTime = stime;
    passedTime = 0;
    timerLength = 1000*60*5+1000;
    timeLeft = timerLength/1000;
  }


  void display()
  {
    convert(timeLeft);
    pushStyle();
    //for the box
    rectMode(CENTER);
    fill(0,0,0);
    strokeWeight(3);
    stroke(155,0,0);
    rect(width/25*2+distMeterW*4, height*0.15, distMeterW*4, distMeterW*1.5);
    //for the time
    textFont(font);
    textSize(75);
    textAlign(CENTER, CENTER);
    fill(250,0,0);
    //text(timeLeft, width/4, height/5);
    //text(int((timeLeft/1000)/60) + " : " + (timeLeft/1000)%60, width/4, height/10);
    text(minutes + ":" + seconds, width/25*2+distMeterW*4, height*0.15);
    textSize(12);
    popStyle();
  }

  void update() //to update the current time constantly
  {
    passedTime = millis()-startTime;
    timeLeft = timerLength-passedTime-penalty;
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
    penalty+=time; //reduce the time when a wrong input is given
  }
}
