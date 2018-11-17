/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

String remoteIP = "192.168.3.172";
int remotePort = 12001;

int playerID = 2; //
float distance = 2.0f; // in meters
float alignment = 0.5f; // angle to the target [-1f, 1f]

class oscManager {
  
  oscManager() {
    setup();
  }

  void setup() {
    /* start oscP5, listening for incoming messages at port 12000 */
    oscP5 = new OscP5(this,remotePort);
    
    /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
     * an ip address and a port number. myRemoteLocation is used as parameter in
     * oscP5.send() when sending osc packets to another computer, device, 
     * application. usage see below. for testing purposes the listening port
     * and the port of the remote location address are the same, hence you will
     * send messages back to this sketch.
     */
    myRemoteLocation = new NetAddress(remoteIP,remotePort);
  }
  
  void update() {
    distance = mouseX/100.0;
  }
  
  void sendTestMessage() {
    /* in the following different ways of creating osc messages are shown by example */
    OscMessage myMessage = new OscMessage("/playerInfo");
    
    myMessage.add(playerID); /* add an int to the osc message */
    myMessage.add(distance); 
    myMessage.add(alignment); 
  
    /* send the message */
    oscP5.send(myMessage, myRemoteLocation); 
  }

}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
