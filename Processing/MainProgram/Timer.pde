class Timer
{
  int passedTime; //milisec
  int startTime; //milisec
  int timerLength; //milisec
  int timeLeft; //milisec
  String minutes;
  int min;
  String seconds;
  int sec;

  Timer(int stime)
  {
    startTime = stime;
    passedTime = 0;
    timerLength = 1000*60*2+1000;
    timeLeft = timerLength/1000;
  }


  void display()
  {
    convert(timeLeft);
    pushStyle();
    textFont(font);
    textSize(75);
    textAlign(CENTER);
    //text(timeLeft, width/4, height/5);
    //text(int((timeLeft/1000)/60) + " : " + (timeLeft/1000)%60, width/4, height/10);
    text(minutes + ":" + seconds, width/25*2+distMeterW*4, height*0.2);
    textSize(12);
    popStyle();
  }

  void update() //to update the current time constantly
  {
    passedTime = millis()-startTime;
    timeLeft = timerLength-passedTime;
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
    timeLeft-=time; //reduce the time when a wrong input is given
  }
}
