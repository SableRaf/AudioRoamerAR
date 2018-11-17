
oscManager osc;

void setup() {
  size(400,400);
  frameRate(25);
  osc = new oscManager();
}

void draw() {
  background(0);
  osc.update();
}

void mousePressed() {
  osc.sendTestMessage();
}
