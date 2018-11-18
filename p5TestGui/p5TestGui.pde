import oscP5.*;
import netP5.*;
import controlP5.*;
import java.util.*;

ControlP5 cp5;

OscP5 osc;
NetAddress supercollider;

float distance0;
float alignment0;
float distance1;
float alignment1;
float distance2;
float alignment2;

void setup() {  
  size(600, 600);
  background(0);
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 12001);
  cp5 = new ControlP5(this);

  cp5.addSlider("distance0")
    .setPosition(100, 50)
    .setValue(10)
    .setRange(0, 10);
  cp5.addSlider("alignment0")
    .setPosition(100, 70)
    .setValue(0)
    .setRange(-1, 1);
  cp5.addSlider("distance1")
    .setPosition(100, 150)
    .setValue(10)
    .setRange(0, 10);
  cp5.addSlider("alignment1")
    .setPosition(100, 170)
    .setValue(0)
    .setRange(-1, 1);
  cp5.addSlider("distance2")
    .setPosition(100, 250)
    .setValue(10)
    .setRange(0, 10);
  cp5.addSlider("alignment2")
    .setPosition(100, 270)
    .setValue(0)
    .setRange(-1, 1);
}

void draw() {
  if (frameCount % 6 == 0) {
    {
      OscMessage msg = new OscMessage("/playerInfo");
      msg.add(0);
      msg.add(distance0);
      msg.add(alignment0);  
      osc.send(msg, supercollider);
    }
    {
      OscMessage msg = new OscMessage("/playerInfo");
      msg.add(1);
      msg.add(distance1);
      msg.add(alignment1);  
      osc.send(msg, supercollider);
    }
    {
      OscMessage msg = new OscMessage("/playerInfo");
      msg.add(2);
      msg.add(distance2);
      msg.add(alignment2);  
      osc.send(msg, supercollider);
    }
  }
}
