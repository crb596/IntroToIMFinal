//Pins
const int blueLedPin = 9;
const int redLedPin = 8;
const int greenLedPin = 7;
const int yellowLedPin = 6;

const int potentiometerPin = A0;

const int blueButtonPin = 5;
const int redButtonPin = 4;
const int greenButtonPin = 3;
const int yellowButtonPin = 2;

const int echoPin = 10; // Echo Pin of Ultrasonic Sensor
const int pingPin = 11; // Trigger Pin of Ultrasonic Sensor
const int buzzerPin = 12;


//On or off values for led
int blue = 0;
int red = 0;
int green = 0;
int yellow = 0;

//Has the bomb gone off
int alarm = 0;

//Is the bomb defused
int defused = 0;

//Are the buttons being pushed
int blueButton = 0;
int redButton = 0;
int greenButton = 0;
int yellowButton = 0;

//Timer for flashing when bomb goes off
long timer = 0;
int timerLength = 500;
bool onOff = false;

void setup() {
  //Setup serial communication
  Serial.begin(9600);
  Serial.println("0,0");
  pinMode(blueLedPin, OUTPUT);
  pinMode(redLedPin, OUTPUT);
  pinMode(greenLedPin, OUTPUT);
  pinMode(yellowLedPin, OUTPUT);
  pinMode(blueButtonPin, INPUT);
  pinMode(redButtonPin, INPUT);
  pinMode(greenButtonPin, INPUT);
  pinMode(yellowButtonPin, INPUT);
  pinMode(pingPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop() {
  while (Serial.available()) {
    //Read in input values in form "yellowLed,greenLed,redLed,blueLed,alarm"
    yellow = Serial.parseInt();
    green = Serial.parseInt();
    red = Serial.parseInt();
    blue = Serial.parseInt();
    alarm = Serial.parseInt();
    defused = Serial.parseInt();

    long duration;
    int cm;
    digitalWrite(pingPin, LOW); //Send a ping out with sensor
    delayMicroseconds(2);
    digitalWrite(pingPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(pingPin, LOW); //Ping sent
    duration = pulseIn(echoPin, HIGH);  //Wait for return on echo Pin
    cm = duration / 29 / 2; //Convert to cm

    if (cm > 35) {
      cm = 35;
    }
    else if (cm < 5) {
      cm = 5;
    }

    if (Serial.read() == '\n') {
      //If the bomb has not gone off
      if(!alarm && !defused){
        //Turn lights on from read in values
        digitalWrite(yellowLedPin, yellow);
        digitalWrite(greenLedPin, green);
        digitalWrite(redLedPin, red);
        digitalWrite(blueLedPin, blue);
      }
      //If bomb has gone off
      else if (alarm){
        //Flash red light and set buzzer off  
        if (millis()>timer){
          onOff = !onOff;
          digitalWrite(redLedPin, onOff);
          digitalWrite(yellowLedPin, LOW);
          digitalWrite(greenLedPin, LOW);
          digitalWrite(blueLedPin, LOW);
          timer = millis() + timerLength;
        }
        tone(buzzerPin, 622, 1000);  //Play buxxer
      }
      else if(defused){
          digitalWrite(redLedPin, LOW);
          digitalWrite(yellowLedPin, LOW);
          digitalWrite(greenLedPin, HIGH);
          digitalWrite(blueLedPin, LOW);
      }

      //Read in potentiometer value and the distance meter value, convert to centimeters
      int meter = analogRead(A0);
      delay(1);

      //Write to processsing in following form "potentiometer,distanceincm(0-35),yellowbutton,greenbutton,redbutton,bluebutton"
      //Button pressed meaning if that button was just pressed and the value is now changing write 1
      Serial.print(meter);
      Serial.print(',');
      Serial.print(cm);
      Serial.print(',');
      Serial.print(digitalRead(yellowButtonPin));
      Serial.print(',');
      Serial.print(digitalRead(greenButtonPin));
      Serial.print(',');
      Serial.print(digitalRead(redButtonPin));
      Serial.print(',');
      Serial.println(digitalRead(blueButtonPin));
    }
  }
}
