/**
Video capture and server to send the captured and compressed colours 
to the P3D client.

This server should be the one that sends the info to the client
on startup about how many elements are going to be in the array.

Author:  Sarah Larkin
CS5641, Spring 2023

Date Last Modified:  April 26, 2023
*/

import processing.video.*;
import processing.net.*;

final int iwidth = 1080;
final int iheight = 720;
final int sq = 18; // How big is a square for averaging
final int div = 2; // How much to divide the initial screen size to get a small size video.
// This seemed best for video size to stream via client/server communication.  If it is larger,
// There is a long lag time.

color [][] img;
color [][] comp;

Server s;
Client c;
String input;
boolean canWrite = false;  // mutex

boolean initDone = false;  // initial mutex

Capture video;
// Both images were run through remove.bg to remove their backgrounds before using them
PImage hawk; // Photo by Pixabay from Pexels: https://www.pexels.com/photo/close-up-of-eagle-perching-on-outdoors-326071/
PImage hawk2; // Photo by Frank Cone from Pexels: https://www.pexels.com/photo/bird-flying-3959918/

void setup() {
  size(1080/2, 720/2);
  s = new Server(this, 10002);
  String [] lists = Capture.list();
  video = new Capture(this, iwidth/4, iheight/4, lists[2]);
  video.start();
  
  img = new color[video.height][video.width];
  comp = new color[img.length / sq][img[0].length / sq];
  hawk = loadImage("hawk.png");
  hawk2 = loadImage("flyingHawk.png");
}

/*
Performs some busy waiting until a client connects.
Once a client connects, it sends the height and width 
of the image to the client, completing the intialization step.
*/
void initInfo() {
  if (!initDone) {
    c = s.available();
    if (c != null && c.available() > 0) {
      input = c.readString();
      if (input.equals("Start")) {
        s.write(comp.length);
        s.write(comp[0].length);
      }
      initDone = true;
    }
  }
}

/**
 * Convert the video into the averaged squares
 * @param sq  the number of pixels per square
 */
void modifyImg(int sq) {
  for (int i = 0; i < video.height; i++) {
    for (int j = 0; j < video.width; j++) {
      //https://processing.org/tutorials/pixels
      int loc = j + i * video.width;
      float red = red(video.pixels[loc]);
      float green = green(video.pixels[loc]);
      float blue = blue(video.pixels[loc]);
      //println("Blue: " + blue);
      if (red >= 2*green && red >= blue && blue >= 2 * green && red > 50) {
        video.pixels[loc] = color(0, 255, 0);
       // x = 1;
      }
      img[i][j] = video.pixels[loc];
      //if (red(img[i][j]) != 0) {
      //  println("hola!");
      //}
    }
  }
 
  
}

// ID and turn squares green if they are the right color
void updateImg(boolean gr) {
   for (int i = 0; i < video.height; i++) {
    for (int j = 0; j < video.width; j++) {
      //https://processing.org/tutorials/pixels
      int loc = j + i * video.width;
      float red = red(video.pixels[loc]);
      float green = green(video.pixels[loc]);
      float blue = blue(video.pixels[loc]);
      //println("Blue: " + blue);
      //if (gr) {
      //  if (red >= 2*green && red >= blue && blue >= 2 * green && red > 50) {
      //    video.pixels[loc] = color(0, 255, 0);
      //  }
      //}
      //video.pixels[loc] = track(gr, (int)red, (int)green, (int)blue);
      img[i][j] = video.pixels[loc];  
      //println(red(img[i][j]));
    }
  }
   //image(video, 0, 0, width, height);
}

/* Returns either the given colour or green if the colour is "pink" */
color track(boolean gr, int red, int green, int blue) {
  if (gr) {
     //if (red >= 2*green && red >= blue && blue >= 2 * green && red > 50) {
     //    return color(0, 255, 0);
     //}
     if (red >= 1.5*green && red >= blue && blue >= 1.75 * green && red > 50) {
       return color(0, 255, 0);
     }
  }
  return color(red, green, blue);
}

/* Performs compression of the image into an average colour stored in a smaller array */
color [][] compress(int w, int h, boolean avg) {
  //updateImg(false);
  color [][] img2 = new color[img.length / h][img[0].length / w];

   for (int r = 0; r < img2.length; r++) {
    for (int c = 0; c < img2[0].length; c++) {
      color colour = avgColor(c * w, r * h, w, h);
      //println(red(colour) + ", " + green(colour) + ", " + blue(colour));
      img2[r][c] = track(avg, (int)red(colour), (int)green(colour), (int)blue(colour));
    }
   }

  return img2;
}

/**
Averages the colour across a square that is w pixels wide and h pixels tall
*/
color avgColor(int x, int y, int w, int h) {
  color colour = color(0, 0, 0);
  float redSum = 0;
  float greenSum = 0;
  float blueSum = 0;
  int limy = y + h;
  int limx = x + w;
  int tango = w * h;
  //println("limx: " + limx + ", " + limy);
  for (int r = y; r < limy; r++) {
    for (int c = x; c < limx; c++) {
      //if (x > 1200 && y > 1200) {
      //  println("x: " + x + ", y: " + y + " R: " + r + ", C: " + c);
      //}
      int loc = c + r * video.width;
      //if (loc > 194350) {
      //  println(img.length + ", " + img[0].length + ", " + tango);
      //  println("r: " + r + ", c: " + c + ", vw: " + video.width);
      //}
      redSum += red(video.pixels[loc]);
      greenSum += green(video.pixels[loc]);
      blueSum += blue(video.pixels[loc]);
    }
  }
  redSum = redSum / tango;
  greenSum = greenSum / tango;
  blueSum = blueSum / tango;
  colour = color(redSum, greenSum, blueSum);
 // println(redSum + ", " + greenSum + ", " + blueSum + ": " + colour);
  return colour;
}

byte line = 10;
  
/* This is an event listener for the video stream, provided as part of the initial video library tutorial */
void captureEvent(Capture video) {
  video.read();
}
  
/* Mirrors the video to make interactions seem more natural */
void showVideoMirror() {
   noStroke();
  for (int i = 0; i < video.height; i++) {
    for (int j = 0; j < video.width; j++) {
      //https://processing.org/tutorials/pixels shows how to do 
      // this formula to find the location based on width & height
      int loc = (video.width - j - 1) + video.width * i;
      //float red = red(video.pixels[loc]);
      //float green = green(video.pixels[loc]);
      //float blue = blue(video.pixels[loc]);
     
      fill(video.pixels[loc]);
      rect(j*div, i* div, div, div);
    }
  }
}
  
void draw() {
  initInfo();
  //image(video, 0, 0, width, height);
  showVideoMirror();
  //if (canWrite) { // uncomment to run with the client
    println("sending info:");
    comp = compress(sq, sq, true);
    boolean hawkShown = false;
    for (int r = 0; r < comp.length; r++) {
      for (int c = 0; c < comp[0].length; c++) {
        s.write((int)red(comp[r][c]));
        s.write((int)green(comp[r][c]));
        s.write((int)blue(comp[r][c]));
        fill(comp[r][c]);
        if (comp[r][c] == color(0, 255, 0) && !hawkShown) {
          if (c < comp.length / 2) {
            image(hawk, comp.length * sq - c * sq , r * sq, hawk.width/2, hawk.height/2);
          } else {
             image(hawk2, comp.length * sq - c * sq, r * sq, hawk.width/2, hawk.height/2);
          }
          hawkShown = true;
        }
        //rect(c * sq, r * sq, sq, sq);
      }
    }
    canWrite = false;
  //}// uncomment to run with the client
  
  if (!canWrite) {
    c = s.available();
    if (c != null) {
      println("reading: " + c);
    }
    if (c != null && c.available() > 0) {
      input = c.readStringUntil(line);
      println(input);
      canWrite = true;
    } 
  } 
}
  
