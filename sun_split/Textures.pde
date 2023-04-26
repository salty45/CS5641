/**
 Holding file for textures.  There are enough that it's convenient to just group them together
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */
 
// All the following images are in the public domain 
PImage grayStone; // Photo by Ronald Slaton from Pexels: https://www.pexels.com/photo/gray-brick-wall-13884144/
PImage brick;   // Photo by Pixabay from Pexels: https://www.pexels.com/photo/brown-brick-wall-207142/
PImage leather; // Photo by Pixabay from Pexels: https://www.pexels.com/photo/empty-brown-canvas-235985/
PImage wood1;// Photo by FWStudio from Pexels: https://www.pexels.com/photo/brown-wooden-surface-129733/
PImage unicorn1; // public domain
//https://en.wikipedia.org/wiki/The_Hunt_of_the_Unicorn#/media/File:The_Hunt_of_the_Unicorn_Tapestry_1.jpg



void loadImages() {
  grayStone = loadImage("grayStone.png");
  unicorn1 = loadImage("unicorn1.jpg");
  wood1 = loadImage("wood1.jpeg");
  brick = loadImage("brick.jpeg");
  leather = loadImage("leather1.jpeg");
 }
