import processing.serial.*;
Serial myPort;
 
void setup(){
  size(960,720);
  String portname=Serial.list()[1];
  myPort = new Serial(this,portname,9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}
 
void draw(){

}
 
void serialEvent(Serial myPort){

}
