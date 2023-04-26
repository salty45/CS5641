/**
Client rendering in P3D to receive the captured, preprocessed and
compressed video.  


Author:  Sarah Larkin
CS5641, Spring 2023

Date Last Modified:  April 26, 2023
*/

import processing.net.*;


int sq = 20;

color [][] img;
color [][] comp;

Client client;
String input;
boolean canWrite = false; // mutex

boolean initDone = false; // initial checkpoint
int num = 0;

void setup() {
  size(1800, 1200, P3D);
  // Using local host on port 10002
  client = new Client(this, "127.0.0.1", 10002);
  client.write("Start"); // initiate interaction with the server as soon as startup is complete
}

/* Perform busy waiting for the server to send information back */
void initInfo() {
  if (!initDone) {
    if (client.available() > 0) {
      int len = client.read();
      int wid = client.read();
      println("L: " + len + ", w: " + wid);
      comp = new color[len][wid];
      num = len * wid * 3;
      sq = width/wid;
      println("sq: " + sq);
      initDone = true;
      client.write("Next\n");
      canWrite = false;
    }
  }
}

void draw() {
  initInfo();
//  background(225);
 // println(client.available());
  if (client.available() == num && initDone) {
    //println("getting info...");
    // read in the info for the colors
    for (int r = 0; r < comp.length; r++) {
      for (int c = comp[0].length - 1; c >= 0; c--) {
       int red = client.read();
       int green = client.read();
       int blue = client.read();
       comp[r][c] = color(red, green, blue);
       fill(comp[r][c]);
       rect(c * sq, r * sq, sq, sq);
       //println("looping");
      }
    }
    println("sending okay: ");
    client.write("Next\n");
  }
}
