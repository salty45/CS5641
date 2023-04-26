/* 
This class keeps track of a bunch of camera information
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
*/


float camX = 0;
float camY = 0;
float camZ = 0;
float eyeX = 0;
float eyeY = 0;
float eyeZ = 0;
float rx = 0;
float ry = 0;
float rz = 0;
float camTheta = -PI/2;
float step = IN * 9; // modify this as needed to step more or less distance by replacing 9 with the desired number of inches

// Camera starts by looking at global 0, 0, 0
// and is at 0, 0, 10 FT

void camKeys() {
  if (key == 'a' || key == 'A') {
    eyeZ -= step * cos(camTheta);  // This is the part where I had to play with trigonometry for a very long time!
    eyeX += step * sin(camTheta);
  } else if (key == 'd' || key == 'D') {
    eyeZ += step * cos(camTheta);  // increase to move right  // perpendicular axis
    eyeX -= step * sin(camTheta);  //  axis along which travel occurs
  } else if (key == 'w' || key == 'W') {
    eyeZ += step * sin(camTheta);   
    eyeX += step * cos(camTheta);
  } else if (key == 's' || key == 'S') {
    eyeZ -= step * sin(camTheta);   
    eyeX -= step * cos(camTheta);
  } else if (key == 'r' || key == 'R') {
    camY -= step;
    eyeY -= step;
  } else if (key == 'f' || key == 'F') {
    camY += step;
    eyeY += step;
  } else if (keyCode == RIGHT || key == 'e' || key == 'E') {
    camTheta += PI/180;
  } else if (keyCode == LEFT || key == 'q' || key == 'Q') {
    camTheta -= PI/180;
  }
  camX = eyeX + width * cos(camTheta);
  camZ = eyeZ + width * sin(camTheta);
}
