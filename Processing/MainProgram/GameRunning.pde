class GameStage {

  //Manage flow of game
  int gameStage; //Which instruction set is the player on?
  boolean pass; //Has the user passed the stage?
  boolean failed; //Has the bomb been set off

  //Timers used for flashing
  long timerStart;
  int flashLength;

  //Which stages have been set up 
  boolean stageOneSetup = false;
  boolean stageTwoSetup = false;
  boolean stageThreeSetup = false;
  boolean stageFourSetup = false;

  //Stage 1 variables
  int buttonCol = -1; //0 for green, 1 for blue, -1 for none
  int countLights = 0;
  int sum = 0;

  //Stage 2 variables
  int numberOfLights;
  boolean flashing[] = {false, false, false, false};
  boolean onOff;

  //Stage 3 variables
  int order[] = {-1, -1, -1, -1};  //Order LEDs flash
  boolean buttonsPressed[] = {false, false, false, false};
  int orderIndex;  //Which button should be pressed (on 0th button, 1st, 2nd, or 3rd)
  boolean buttonUsed = false; //Used to determine if a button is being pressed

  //Stage 4 variables
  int randomIndex;

  //Default constructor
  GameStage() {
    gameStage = 1;
  }

  //=======================================================================
  //MEMBER FUNCTIONS

  int runGame() {
    if (gameStage == 1) {
      return stageOne();
    }
    if (gameStage == 2) {
      return stageTwo();
    }
    if (gameStage == 3) {
      return stageThree();
    }
    if (gameStage == 4) {
      return stageFour();
    }

    //If submit button is pressed some other time than expected stage, decrease the time
    //if (submitButton) {
      //check for game stage
      //if (!(gameStage == 2 || (gameStage == 1 && PButton[1] == true)))
      //{
      //  timer.reduce(10000); //reduce 10 secs
      //  submitButton = false;
      //}
    //}

    return -1;
  }

  //===============================================================================================================
  //Stage 1

  int stageOne()
  {
    //If first time on stage
    if (!stageOneSetup) 
    {
      //println("hello");
      //intialize variables again
      countLights = 0;
      sum = 0;

      //set up either green or blue on
      buttonCol = int(random(2)); //records the button that was first on
      PButton[buttonCol] = true; //start with the button number picked
      
      //println(PButton[buttonCol] + "\n");

      //make all lights off first from previous round
      for (int i=0; i<4; i++)
        lights[i] = false;

      //Set which LEDs light up
      while (lights[0]==false && lights[1]==false && lights[2]==false && lights[3]==false) //so that all leds are not off
      {
        for (int i = 0; i < 4; i++) 
        {
          int randomState = int(random(2));  //Set random lights to blink
          if (randomState == 1)
          {
            lights[i] = true; //this led is lit up
            sum+=(i+1); //add its sum to the score for distMeter
            countLights++;
            //println(sum);
          }
        }
      }
      //println("count:" + countLights);
      stageOneSetup = true;
    }

    //now check if blue or green light is on
    if (PButton[0] == true) //i.e. green light is on
    {
      //Look for user input
      //Look to see if no buttons are being pressed
      if (buttonUsed) {
        boolean tempNotUsed = true;
        for (int i = 0; i< 4; i++) {
          if (buttonDown[i] == 1) {
            tempNotUsed = false;
          }
        }
        if (tempNotUsed) {
          buttonUsed = false;
        }
      }

      if (!buttonUsed) 
      {
        //Yellow button pressed
        if (buttonDown[0] == 1) 
        {
          buttonUsed = true; 
          //Check to see if the button input is correct according to no. of leds
          if (countLights == 3) 
          { //correct input
            PButton[0] = false;
            if (buttonCol == 0)
              PButton[1]=true; //so if green was the first color, make blue glow next
            else
            {
              gameStage++; //if green was the second color, go to next stage
              stageOneSetup = false;
            }
          }
          //Wrong button pressed according to the number
          else {
            fail = true;
            stageOneSetup = false;
            PButton[0] = false;
            PButton[1] = false;
          }
        }
        //Green button pressed
        else if (buttonDown[1] == 1) 
        {
          buttonUsed = true;
          //Check to see if the button input is correct according to no. of leds
          if (countLights == 2) { 
            PButton[0] = false;
            if (buttonCol == 0)
              PButton[1]=true; 
            else
            {
              gameStage++;
              stageOneSetup = false;
            }
          }
          //Wrong button pressed according to the number
          else {
            fail = true;
            stageOneSetup = false;
            PButton[0] = false;
            PButton[1] = false;
          }
        }
        //Red button pressed
        else if (buttonDown[2] == 1) 
        {
          buttonUsed = true;
          //Check to see if the button input is correct according to no. of leds
          if (countLights == 4) { 
            PButton[0] = false;
            if (buttonCol == 0)
              PButton[1]=true; 
            else
            {
              gameStage++;
              stageOneSetup = false;
            }
          }
          //Wrong button pressed according to the number
          else {
            fail = true;
            stageOneSetup = false;
            PButton[0] = false;
            PButton[1] = false;
          }
        }
        //Blue button pressed
        else if (buttonDown[3] == 1) 
        {
          buttonUsed = true;
          //Check to see if the button input is correct according to no. of leds
          if (countLights == 1) 
          { 
            PButton[0] = false;
            if (buttonCol == 0)
              PButton[1]=true; 
            else
            {
              gameStage++;
              stageOneSetup = false;
            }
          }
          //Wrong button pressed according to the number
          else {
            fail = true;
            stageOneSetup = false;
            PButton[0] = false;
            PButton[1] = false;
          }
        }
      }
    }

    if (PButton[1] == true) //i.e. the blue button is on
    {
      float distReading = (distMeterMax-distMeterMin)/distDiv;
      if (submitButton)
      {
        if (distance >= distMeterMax-sum*distReading && distance <= distMeterMax-(sum-1)*distReading) //i.e. correct distance
        { 
          PButton[1] = false;
          if (buttonCol == 1) //if this was the first light
            PButton[0]=true; //turn on the next light
          else
          {
            gameStage++; //else move to the next stage
            stageOneSetup = false;
          }
        } else //submit button pressed at wrong time --> fail
        {
          fail = true;
          stageOneSetup = false;
          PButton[0] = false;
          PButton[1] = false;
        }
        submitButton = false;
      }
    }

    return gameStage;
  }

  //===============================================================================================================
  //Stage 2

  //Blink lights until the user moves the potentiometer to the right zone
  int stageTwo() {
    //If first time on stage
    if (!stageTwoSetup) {
      for (int i = 0; i < 4; i++) {
        flashing[i] = false;
      }
      numberOfLights = int(random(4)+1);  //Set how many lights are flashing
      timerStart = millis();
      flashLength = 500;
      onOff = false;
      stageTwoSetup = true;

      //Set which lights will flash 
      for (int i = 0; i < numberOfLights; i++) {
        int randomIndex = int(random(4));  //Set random lights to blink
        while (flashing[randomIndex] == true) {
          randomIndex = (randomIndex + 1)%4;  //Advance until there is an index set to false
        }
        flashing[randomIndex] = true;
      }
    }

    //Flash lights if needed
    if (millis() - flashLength > timerStart) {
      onOff = !onOff;
      timerStart = millis();
      for (int i = 0; i < 4; i++) {
        if (onOff) {
          lights[i] = flashing[i];
        } else {
          lights[i] = false;
        }
      }
    }

    //Check for a user input
    if (numberOfLights == 1 && submitButton == true) {
      if (potentiometer >= 512 && potentiometer < 777) {
        //In yellow
        gameStage++;
        submitButton = false;
        stageTwoSetup = false;
      }
      //Not in yellow
      else {
        fail = true;
        submitButton = false;
      }
    } else if (numberOfLights == 2 && submitButton == true) {
      if (potentiometer >= 0 && potentiometer < 256) {
        //In red
        gameStage++;
        stageTwoSetup = false;
        submitButton = false;
      }
      //Not in red
      else {
        fail = true;
        submitButton = false;
      }
    } else if (numberOfLights == 3 && submitButton == true) {
      if (potentiometer >= 256 && potentiometer < 512 && submitButton == true) {
        //In orange
        gameStage++;
        stageTwoSetup = false;
        submitButton = false;
      }
      //not in orange
      else {
        fail = true;
        submitButton = false;
      }
    } else if (numberOfLights == 4 && submitButton == true) {
      if (potentiometer >= 777 && potentiometer < 1024 && submitButton == true) {
        //In green
        gameStage++;
        stageTwoSetup = false;
        submitButton = false;
      }
      //If not in green
      else {
        fail = true;
        submitButton = false;
      }
    }
    return gameStage;
  }

  //===========================================================================================================
  //Stage 3

  //Remeber the LED pattern, push the buttons in the same order
  int stageThree() {
    //Setup stage three
    if (!stageThreeSetup) {
      for (int i = 0; i < 4; i++) {
        buttonsPressed[i] = false;
        order[i] = -1;
      }

      //Choose order of LEDS
      for (int i = 0; i < 4; i++) {
        //Chose random index to put light in order
        int randomIndex = int(random(4));
        while (order[randomIndex] != -1) {
          randomIndex = (randomIndex + 1) % 4;
        }
        order[randomIndex] = i;  //Asign light randomly in order
      }

      //Set timers
      timerStart = millis();
      orderIndex = 0;
      stageThreeSetup = true;
    }

    for (int i = 0; i < 4; i++) {
      print(order[i] + ", " );
    }
    println();
    println(orderIndex);


    //Flash lights in order//If timer if 0 - 199ms
    if (millis() - timerStart < 400) {
      lights[order[0]] = true;
      lights[order[1]] = false;
      lights[order[2]] = false;
      lights[order[3]] = false;
    }
    //If timer is 200-399ms
    else if (millis() - timerStart < 800) {
      lights[order[0]] = false;
      lights[order[1]] = true;
      lights[order[2]] = false;
      lights[order[3]] = false;
    }
    //If timer is 400-599ms
    else if (millis() - timerStart < 1200) {
      lights[order[0]] = false;
      lights[order[1]] = false;
      lights[order[2]] = true;
      lights[order[3]] = false;
    }
    //If timer is 600-799ms
    else if (millis() - timerStart < 1600) {
      lights[order[0]] = false;
      lights[order[1]] = false;
      lights[order[2]] = false;
      lights[order[3]] = true;
    }
    //If timer is below 1200
    else if (millis() - timerStart < 3000) {
      lights[order[0]] = false;
      lights[order[1]] = false;
      lights[order[2]] = false;
      lights[order[3]] = false;
    } else {
      timerStart = millis();
    }

    //Look for user input
    //Look to see if no buttons are being pressed
    if (buttonUsed) {
      boolean tempNotUsed = true;
      for (int i = 0; i< 4; i++) {
        if (buttonDown[i] == 1) {
          tempNotUsed = false;
        }
      }
      if (tempNotUsed) {
        buttonUsed = false;
      }
    }

    //If no buttons are being pressed, look for one to be pressed, otherwise wait for them to be released before being used again
    if (!buttonUsed) {
      //Yellow button pressed
      if (buttonDown[0] == 1) {
        buttonUsed = true;
        //Check to see if the next button in the order is also a 0
        if (order[orderIndex] == 0) {
          orderIndex++;
        }
        //Wrong order
        else {
          println("Not yellow");
          fail = true;
          stageThreeSetup = false;
        }
      }
      //Green button pressed
      else if (buttonDown[1] == 1) {
        buttonUsed = true;
        //Check to see if the next button in the order is also a 1
        if (order[orderIndex] == 1) {
          orderIndex++;
        }
        //Wrong order
        else {
          println("Not green");
          fail = true;
          stageThreeSetup = false;
        }
      }
      //Red button pressed
      else if (buttonDown[2] == 1) {
        buttonUsed = true;
        //Check to see if the next button in the order is also a 2
        if (order[orderIndex] == 2) {
          orderIndex++;
        }
        //Wrong order
        else {
          println("Not red");
          fail = true;
          stageThreeSetup = false;
        }
      }
      //Blue button pressed
      else if (buttonDown[3] == 1) {
        buttonUsed = true;
        //Check to see if the next button in the order is also a 3
        if (order[orderIndex] == 3) {
          orderIndex++;
        }
        //Wrong order
        else {
          println("Not blue");
          fail = true;
          stageThreeSetup = false;
        }
      }

      //Completed
      if (orderIndex == 4) {
        gameStage++;
        stageThreeSetup = false;
      }
    }

    return gameStage;
  }

  //Choose one of the remaining wires and show that LED
  int stageFour() {
    println("fail: ", fail);
    if (!stageFourSetup) {
      //Choose which wire to cut out of the ones left
      randomIndex = int(random(4));//Chose a random number 0-3
      //Make sure wire has not yet been but
      while (wires[randomIndex].state == false) {
        randomIndex = (randomIndex + 1) % 4;
      }
      stageFourSetup = true;
    }

    //Turn the light on
    lights[0] = false;
    lights[1] = false;
    lights[2] = false;
    lights[3] = false;
    lights[randomIndex] = true;

    //Check for use button press
    if (buttonUsed) {
      boolean tempNotUsed = true;
      for (int i = 0; i< 4; i++) {
        if (buttonDown[i] == 1) {
          tempNotUsed = false;
        }
      }
      if (tempNotUsed) {
        buttonUsed = false;
      }
    }

    if (!buttonUsed) {
      //Yellow button pressed
      if (buttonDown[0] == 1) 
      {
        buttonUsed = true;
        //Check to see if the button input is correct according random index
        if (randomIndex == 0) 
        { //correct input
          wires[0].state = false;

          //Check to see if won
          correctRounds++;
          if (correctRounds == 3) {
            //Do nothing
          } 
          else if(correctRounds == 4){
            pass = true;
          }
          else {
            gameStage = 1;
          }
        }
        //Wrong button pressed according to the number
        else {
          fail = true;
        }
        stageFourSetup = false;
      }
      //Green button pressed
      if (buttonDown[1] == 1) 
      {
        buttonUsed = true;
        //Check to see if the button input is correct according random index
        if (randomIndex == 1) { //correct input
          wires[1].state = false;

          //Check to see if won
          correctRounds++;
          if (correctRounds == 3) {
            //Do nothing
          } 
          else if(correctRounds == 4){
            pass = true;
          }
          else {
            gameStage = 1;
          }
        }
        //Wrong button pressed according to the number
        else {
          fail = true;
        }
        stageFourSetup = false;
      }
      //Red button pressed
      if (buttonDown[2] == 1) 
      {
        buttonUsed = true;
        //Check to see if the button input is correct according random index
        if (randomIndex == 2) { //correct input
          wires[2].state = false;

          //Check to see if won
          correctRounds++;
          if (correctRounds == 3) {
            //Do nothing
          } 
          else if(correctRounds == 4){
            pass = true;
          }
          else {
            gameStage = 1;
          }
        }
        //Wrong button pressed according to the number
        else {
          fail = true;
        }
        stageFourSetup = false;
      }
      //Blue button pressed
      if (buttonDown[3] == 1) 
      {
        buttonUsed = true;
        //Check to see if the button input is correct according random index
        if (randomIndex == 3) { //correct input
          wires[3].state = false;

          //Check to see if won
          correctRounds++;
          if (correctRounds == 3) {
            //Do nothing
          }
          else if(correctRounds == 4){
            pass = true;
          }
          else {
            gameStage = 1;
          }
        }
        //Wrong button pressed according to the number
        else {
          fail = true;
        }
        stageFourSetup = false;
      }
    }
    return gameStage;
  }
}
