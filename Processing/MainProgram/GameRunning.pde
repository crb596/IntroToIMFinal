class GameStage {

  //Manage flow of game
  int gameStage; //Which instruction set is the player on?
  boolean pass; //Has the user passed the stage?
  boolean failed; //Has the bomb been set off

  //Timers used for flashing
  long timerStart;
  int flashLength;

  //Which stages have been set up 
  boolean stageTwoSetup = false;
  boolean stageThreeSetup = false;

  //Stage 2 variables
  int numberOfLights;
  boolean flashing[] = {false, false, false, false};
  boolean onOff;

  //Stage 3 variables
  int order[] = {-1, -1, -1, -1};  //Order LEDs flash
  boolean buttonsPressed[] = {false, false, false, false};
  int orderIndex;  //Which button should be pressed (on 0th button, 1st, 2nd, or 3rd)
  boolean buttonUsed = false; //Used to determine if a button is being pressed



  //Default constructor
  GameStage() {
    gameStage = 2;
  }

  int runGame() {
    if (gameStage == 2) {
      return stageTwo();
    }
    if (gameStage == 3) {
      return stageThree();
    }
    return -1;
  }

  //Blink lights until the user moves the potentiometer to the right zone
  int stageTwo() {
    //If first time on stage
    if (!stageTwoSetup) {
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
    if (numberOfLights == 1) {
      if (potentiometer >= 512 && potentiometer < 777) {
        //In yellow
        gameStage++;
        stageTwoSetup = false;
      }
    } else if (numberOfLights == 2) {
      if (potentiometer >= 0 && potentiometer < 256) {
        //In red
        gameStage++;
        stageTwoSetup = false;
      }
    } else if (numberOfLights == 3) {
      if (potentiometer >= 256 && potentiometer < 512) {
        //In orange
        gameStage++;
        stageTwoSetup = false;
      }
    } else if (numberOfLights == 4) {
      if (potentiometer >= 777 && potentiometer < 1024) {
        //In green
        gameStage++;
        stageTwoSetup = false;
      }
    }
    return gameStage;
  }

  //Remeber the LED pattern, push the buttons in the same order
  int stageThree() {
    //Setup stage three
    if (!stageThreeSetup) {
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

    //for (int i = 0; i < 4; i++) {
    //  print(buttonPressed[i] + ", " );
    //}
    //println();

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
}
