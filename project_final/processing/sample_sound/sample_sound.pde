
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PGraphics[] pgs = new PGraphics[4];
color[] colors = new color[4];

void setup() {
  fullScreen();
  noStroke();
  frameRate(25);
  for (int i=0; i<pgs.length; i++) {
    pgs[i] = createGraphics(width, height, JAVA2D);
    colors[i] = color(random(255), random(255), random(255));
    pgs[i].beginDraw();
    pgs[i].noStroke();
    pgs[i].smooth();
    pgs[i].background(colors[i]);
    pgs[i].endDraw();
  }


   oscP5 = new OscP5(this,9999); //same port as in max
  myRemoteLocation = new NetAddress("192.168.100.3",9999);//ip address of host pc for max
}

void draw() {
  noCursor();
  image(pgs[0], 0, 0, width/2, height/2);
  image(pgs[1], width/2, 0, width/2, height/2);
  image(pgs[2], 0, height/2, width/2, height/2);
  image(pgs[3], width/2, height/2, width/2, height/2);

  textSize(60);
  fill(0);
  textAlign(CENTER,CENTER);
  text("SAMPLE1", 0, 0, width/2, height/2);
  text("SAMPLE2", width/2, 0, width/2, height/2);
  text("SAMPLE3", 0, height/2, width/2, height/2);
  text("SAMPLE4", width/2, height/2, width/2, height/2);
}

 void mouseClicked() {
  OscMessage myMessage = new OscMessage("/mouseXY");
  if (mouseY < height/2)
  {
    if(mouseX < width/2)
      {
        myMessage.add(1);
      }
    else
      {
        myMessage.add(2);
      }
  }
  else
  {
    if(mouseX < width/2)
      {
        myMessage.add(3);
      }
    else
      {
        myMessage.add(4);
      }
  }
  oscP5.send(myMessage, myRemoteLocation);
}

void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
