/**
 Shapes with textures applied.
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */
void rectangle_tube(float w, float h, float d, PImage img, boolean wrap) {
  if (wrap) {
    rectangle_tube1(w, h, d, img);
  } else {
    rectangle_tube2(w, h, d, img);
  }
}

void rectangle_tube1(float w, float h, float d, PImage img) {
  beginShape(QUAD_STRIP);
  texture(img);
  vertex(0, 0, 0, 0, img.height);
  vertex(0, -h, 0, 0, 0);
  vertex(w, 0, 0, img.width/4, img.height);
  vertex(w, -h, 0, img.width/4, 0);
  vertex(w, 0, d, img.width/2, img.height);
  vertex(w, -h, d, img.width/2, 0);
  vertex(0, 0, d, img.width/4 * 3, img.height);
  vertex(0, -h, d, img.width/4 * 3, 0);
  vertex(0, 0, 0, img.width, img.height);
  vertex(0, -h, 0, img.width, 0);
  endShape(CLOSE);
}

void rectangle_tube2(float w, float h, float d, PImage img) {
  // left side
  beginShape();
  texture(img);
  vertex(0, 0, 0, 0, img.height); // back bottom corner
  vertex(0, -h, 0, 0, 0);
  vertex(0, -h, d, img.width, 0);
  vertex(0, 0, d, img.width, img.height);
  endShape(CLOSE);

  // back
  beginShape();
  texture(img);
  vertex(0, 0, 0, 0, img.height); // back bottom corner
  vertex(0, -h, 0, 0, 0);
  vertex(w, -h, 0, img.width, 0);
  vertex(w, 0, 0, img.width, img.height);
  endShape(CLOSE);

  // right side
  beginShape();
  texture(img);
  vertex(w, 0, 0, 0, img.height); // back bottom corner
  vertex(w, -h, 0, 0, 0);
  vertex(w, -h, d, img.width, 0);
  vertex(w, 0, d, img.width, img.height);
  endShape(CLOSE);

  // front
  beginShape();
  texture(img);
  vertex(0, 0, d, 0, img.height); // back bottom corner
  vertex(0, -h, d, 0, 0);
  vertex(w, -h, d, img.width, 0);
  vertex(w, 0, d, img.width, img.height);
  endShape(CLOSE);
}

void box2(float w, float h, float d, PImage img, boolean b) { // TODO: remove b
  rectangle_tube2(w, h, d, img);
  
  hplane(w, -h, d, img);
  hplane(w, 0, d, img);
  
}

void hplane(float w, float h, float d, PImage img) {
  beginShape();
  texture(img);
  vertex(0, h, 0, 0, 0);
  vertex(w, h, 0, img.width, 0); // back bottom corner
  vertex(w, h, d, img.width, img.height);
  vertex(0, h, d, 0, img.height); 
  endShape(CLOSE);
}

void rect_prism(float w, float h, float d, PImage img) {

  // top
  beginShape();
  texture(img);
  vertex(0, -h, 0, 0, 0);
  vertex(w, -h, 0, img.width, 0);
  vertex(w, -h, d, img.width, img.height);
  vertex(0, -h, d, 0, img.height);
  endShape(CLOSE);


  // bottom
  beginShape();
  texture(img);
  vertex(0, 0, 0, 0, 0);
  vertex(w, 0, 0, img.width, 0);
  vertex(w, 0, d, img.width, img.height);
  vertex(0, 0, d, 0, img.height);
  endShape(CLOSE);

  rectangle_tube2(w, h, d, img);
}

/**
 * Creates a plane with the given texture.
 * Two of w, h, and d should be positive numbers, the other should be 0
 * Note: 0, 0, 0 will be top left corner
 */
//void texture_plane(float w, float h, float d, PImage img) {
//  beginShape();
//  texture(img);
//  if (w == 0) {
//    vertex(0, 0, 0);

//  } else if (h == 0) {

//  } else if (d == 0) {

//  }
//  endShape(CLOSE);
//}




  
