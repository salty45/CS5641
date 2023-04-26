/* This file contains the shapes which make up the anvil
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */

void anvil_base() {
  pushMatrix();
  pushStyle();
  //tint(#22220088);
  translate(7 * FT, 0, 8 * FT);
  rect_prism(3 * FT, 2 * FT, 1.5 * FT, brick);
  translate(0, -1.5 * FT, 0);
  pushMatrix();
  translate(1.5 * FT, -1.5 * FT, FT * 1);
  scale(0.5);
  anvil_box(2.5 * FT, 1.5 * FT, 1 * FT);
  popMatrix();
  translate(1.5 * FT, -2 * FT, FT);
  anvil_horn_cone(6, 0.25*FT, 0.25 * FT, 1.5 * FT);
  popStyle();
  popMatrix();
}

// the shape for the anvil horn
void anvil_horn_cone(float sides, float r1, float r2, float h) {
  pushMatrix();
  pushStyle();

  specular(180, 180, 0);
  shininess(25.0);
  rotateZ(PI/2);
  float theta = 2 * PI / sides;

  beginShape(TRIANGLE_STRIP);
  for (float i = 0; i <= sides; i++) {
    float x = r1 * cos(theta * i);
    float z = r2 * sin(theta * i);
    vertex(x, 0, z);
    vertex(0, -h, -r2);
  }
  endShape(CLOSE);
  popMatrix();
}

void anvil_box(float w, float h, float d) {
  pushMatrix();
  translate(-w/2, -h/2, -d/2);
  box(w, h, d);

  pushMatrix();
  translate(0, h/2, 0);
  rotateZ(PI);
  cone_section1(w/2 * 0.8, w/2 * 0.7, d/2*0.8, d/2 * 0.7, h*0.2, 20);
  popMatrix();
  pushMatrix();
  translate(0, 0.7 * h, 0);
  rotateZ(PI);
  cone_section1(w/2 * 0.7, w/2 * 0.6, d/2*0.7, d/2 * 0.6, h*0.3, 20);
  popMatrix();

  pushMatrix();
  translate(0, (1.3 + 0.2) * h, 0);
  // rotateZ(PI);
  cone_section1(w/2 * 0.6, w/2 * 0.6, d/2*0.6, d/2 * 0.6, h*0.5, 20);
  popMatrix();

  pushMatrix();
  translate(0, (1.3 + 0.5) * h, 0);
  // rotateZ(PI);
  cone_section1(w/2 * 0.7, w/2 * 0.6, d/2*0.7, d/2 * 0.6, h*0.3, 20);
  popMatrix();

  pushMatrix();
  translate(0, 2 * h, 0);
  //rotateZ(PI);
  cone_section1(w/2 * 0.8, w/2 * 0.7, d/2*0.8, d/2 * 0.7, h*0.2, 20);
  popMatrix();


  popMatrix();
}

// from shorthaired muscle file
void cone_section1(float w1, float w2, float d1, float d2, float h, float s) {
  pushMatrix();
  float theta = 2 * PI / s;
  for (float i = 0; i < s; i++) {
    float x1 = w1 * cos(theta * i);
    float x2 = w2 * cos(theta * i);
    float z1 = d1 * sin(theta * i);
    float z2 = d2 * sin(theta * i);

    float x3 = w1 * cos(theta * (i + 1));
    float x4 = w2 * cos(theta * (i + 1));
    float z3 = d1 * sin(theta * (i + 1));
    float z4 = d2 * sin(theta * (i + 1));

    beginShape();
    vertex(x1, 0, z1);
    vertex(x2, -h, z2);
    vertex(x4, -h, z4);
    vertex(x3, 0, z3);
    endShape(CLOSE);
  }
  popMatrix();
}
