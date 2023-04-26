/**
 Some shapes that are occasionally useful.
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */
void cylinder(float r, float h, float sides) {
  pushStyle();
  noStroke();
  beginShape(QUAD_STRIP);
  float theta = 2 * PI / sides;
  for (float i = 0; i <= sides; i++) {
    float x = r * cos(i * theta);
    float z = r * sin(i * theta);

    vertex(x, 0, z);
    vertex(x, -h, z);
  }

  endShape(CLOSE);
  popStyle();
  stroke(1);
}

void cylinder(float r, float r2, float h, float sides) {
  pushStyle();
  noStroke();
  beginShape(QUAD_STRIP);
  float theta = 2 * PI / sides;
  for (float i = 0; i <= sides; i++) {
    float x = r * cos(i * theta);
    float z = r2 * sin(i * theta);

    vertex(x, 0, z);
    vertex(x, -h, z);
  }

  endShape(CLOSE);
  popStyle();
  stroke(1);
}
