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
    textSize(40);
    //text(timeLeft, width/4, height/5);
    //text(int((timeLeft/1000)/60) + " : " + (timeLeft/1000)%60, width/4, height/10);
    text(minutes + ":" + seconds, width/4, height/10);
    textSize(12);
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
      minutes = ("0" + min + " ");
    else minutes = (min + " ");
    sec = (time/1000)%60;
    if (sec>=0 && sec <=9)
      seconds = (" 0" + sec);
    else seconds = (" " + sec);
  }

  void reduce()
  {
  }
}
