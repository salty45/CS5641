/**
 This class has the information to make the fire using Flame particles.
 The flame changes radius and opacity based on its location,
 and changes colour based on location and temperature.
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */

public class Flame {

  final float R = 30;
  final float Q = 15;

  float homeX;
  float homeZ;
  float x;
  float y;
  float z;
  color colour = color(255, 255, 0); // colour
  color c = color(125, 0, 225);
  float vx;
  float vy;
  float vz;
  float minY;
  float maxY;
  float temp;
  float fireTemp;
  float radius;
  PVector velocity;

  public Flame(float x, float y, float z, float minY, float maxY) {
    this.y = y;
    this.x = x;
    this.z = z;
    homeX = x;
    homeZ = z;
    this.minY = minY;
    this.maxY = maxY;
    temp = T - ((maxY - y) * 12);
    radius = R * random(0.75, 1) - (0.05 * (maxY - y));

    vx = randomGaussian() * 5;
    vy = random(-2 * Q, -0.5 * Q);

    updateColour();
  }

  void setMotionZX() {
    vx = randomGaussian() * 5;
  }

  /**
   updates the colour of the flame based on temp and height
   */
  void updateColour() {
    int opacity = (int)((y - minY) / (maxY - minY) * 255);
    color flame = color(255, 255, 0, opacity);
    if (temp < 525) {
      flame = color(255, 255, 0, opacity);
    } else if (temp < 800) {
      flame = color(180, 50, 0, opacity);
    } else if (temp < 1000) {
      float r = (1 - (1000-temp)/1000) * 255;
      float g = (1000-temp)/1000 * 50;
      flame = color(r, g, 0, opacity);
    } else if (temp < 1300) {
      flame = color(255, 180, 0, opacity);
    } else if (temp < 1500) {
      flame = color(255, opacity);
    } else {
      flame = color(150, 180, 255, opacity);
    }
    colour = flame;
  }

  void updateLocation() {
    y += vy;

    if (y < minY) {
      float h = minY - y;
      y = maxY - h;
      x = homeX;
      z = homeZ;
      temp = fireTemp;
      radius = R * random(0.75, 1);
    }


    x += vx;
    z += vz;
    if (radius > 5 && (y - minY)/(maxY - minY) < 0.95) // fun effect if you comment out the if statement
      radius -= 0.05 * Q * 0.76;
  }




  void display(float tempC) {
    //if ((y - minY)/(maxY - minY) > 0.7) {
    //  temp = tempC - (maxY - y) * log(100 *(y - minY)/(maxY - minY)) ;
    //}

    if (tempC > T) {
      if (minY > 0)
        minY -= (maxY - minY) * 0.1;// - (tempC - 1500)/4;
    } else {
      minY = 100;
    }

    if (temp > 1500) {
      temp -= 5 * Q;
    } else if (temp > 1300) {
      temp -= 5 * Q;
    } else if (temp > 1000) {
      temp -= 10 * Q;
    } else if (temp > 525) {
      temp -= 15 * Q;
    }

    // Fire temperature ranges chosen based on information found  
    // at https://www.target-fire.co.uk/resource-centre/what-is-the-temperature-of-fire/#:~:text=Orange%20flames%20range%20from%20around,C%20to%203000%C2%B0C.

    fireTemp = tempC;
    updateLocation();
    setMotionZX();
    updateColour();

    pushMatrix();
    translate(x, y, z);
    pushStyle();
    noStroke();
    fill(colour);
    sphere(radius);
    popStyle();
    popMatrix();
  }
}
