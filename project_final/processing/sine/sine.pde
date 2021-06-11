import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  fullScreen();
  noStroke();
  background(#BFC65A);
  frameRate(25);
  oscP5 = new OscP5(this,9999); //same port as in max
  myRemoteLocation = new NetAddress("192.168.100.3",9999);//ip address of host pc for max
}

void draw() {
 if(mousePressed) {
   fill(#BF4B4B);
 } else {
   fill(#4BBFBC);
 }
 ellipse(mouseX, mouseY, 100, 100);
}

void mouseDragged() {
  OscMessage myMessage = new OscMessage("/mouseXY");
  if(mousePressed){
  myMessage.add(mouseX);
  myMessage.add(mouseY);
  oscP5.send(myMessage, myRemoteLocation);
  }
}

void keyPressed() {
  OscMessage m1,m2;
  switch(key) {
    case('c'):
      m1 = new OscMessage("/cletter");
      oscP5.send(m1,myRemoteLocation);
      break;
    case('d'):
      m2 = new OscMessage("/dletter");
      oscP5.send(m2,myRemoteLocation);
      break;

  }
}

void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
