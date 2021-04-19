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

//Are the buttons being pushed
int blueButton = 0;
int redButton = 0;
int greenButton = 0;
int yellowButton = 0;

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
}

void loop() {
  while (Serial.available()) {
    //Read in input values in form "yellowLed,greenLed,redLed,blueLed,alarm"
    yellow = Serial.parseInt();
    green = Serial.parseInt();
    red = Serial.parseInt();
    blue = Serial.parseInt();
    alarm = Serial.parseInt();
    
    if (Serial.read() == '\n') {
      //Turn lights on from read in values
      digitalWrite(yellowLedPin, yellow);
      digitalWrite(greenLedPin, green);
      digitalWrite(redLedPin, red);
      digitalWrite(blueLedPin, blue);

      //Read in potentiometer value and the distance meter value, convert to centimeters
      int meter = analogRead(A0);
      delay(1);
      long duration;
      int cm;
      digitalWrite(pingPin, LOW); //Send a ping out with sensor
      delayMicroseconds(2);
      digitalWrite(pingPin, HIGH);
      delayMicroseconds(10);
      digitalWrite(pingPin, LOW); //Ping sent
      duration = pulseIn(echoPin, HIGH);  //Wait for return on echo Pin
      cm = duration / 29 / 2; //Convert to cm

      
      //Write to processsing in following form "potentiometer,distanceincm,yellowbuttonpressed,yellowbutton,greenbuttonpressed,greenbutton,redbuttonpressed,redbutton,bluebuttonpressed,bluebutton"
      //Button pressed meaning if that button was just pressed and the value is now changing write 1
      Serial.print(sensor);
      Serial.print(',');
      Serial.print(cm);
      Serial.print(',');
      int yellowButtonRead = digitalRead(yellowButtonPin)
      if(yellowButtonRead == 1 && yellowButton == 0){
        Serial.print(1);
      }
      else{
        Serial.print(0);
      }
      yellowButton = yellowButtonRead;
      Serial.print(',');
      Serial.print(digitalRead(yellowButtonRead));
      Serial.print(',');
      int greenButtonRead = digitalRead(greenButtonPin)
      if(greenButtonRead == 1 && greenButton == 0){
        Serial.print(1);
      }
      else{
        Serial.print(0);
      }
      greenButton = greenButtonRead;
      Serial.print(',');
      Serial.print(digitalRead(greenButtonRead));
      Serial.print(',');
      int redButtonRead = digitalRead(redButtonPin)
      if(redButtonRead == 1 && redButton == 0){
        Serial.print(1);
      }
      else{
        Serial.print(0);
      }
      redButton = redButtonRead;
      Serial.print(',');
      Serial.print(digitalRead(redButtonRead));
      Serial.print(',');
      int blueButtonRead = digitalRead(blueButtonPin)
      if(blueButtonRead == 1 && blueButton == 0){
        Serial.print(1);
      }
      else{
        Serial.print(0);
      }
      blueButton = blueButtonRead;
      Serial.print(',');
      Serial.println(digitalRead(blueButtonRead));
    }
  }
}
