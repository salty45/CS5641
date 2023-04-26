/**
 This class has the information to make a loom.
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */

boolean [] strings = new boolean[72];
int strung = 30;

void initLoom() {
  for (int i = strung; i < strings.length; i++) {
    strings[i] = true;
  }
}

// Draw a room without the loom in it
void loomRoom() {
  // 15 ft x 20 ft x height: 10 ft
  // 2 windows, 2nd floor
  float h = 10 * FT;
  float w = 15 * FT;
  float d = 12 * FT;

  pushMatrix();
  // 0, 0, 0 is back left bottom corner

  // left wall
  beginShape();
  texture(grayStone);
  vertex(0, -h, 0, grayStone.width, 0);
  vertex(0, 0, 0, grayStone.width, grayStone.height);
  vertex(0, 0, d, 0, grayStone.height);
  vertex(0, -h, d, 0, 0);
  endShape(CLOSE);

  // backWall
  beginShape();
  //fill(200);
  texture(grayStone);
  vertex(0, -h, 0, 0, 0);
  vertex(w, -h, 0, grayStone.width, 0);
  vertex(w, 0, 0, grayStone.width, grayStone.height);
  vertex(0, 0, 0, 0, grayStone.height);
  vertex(0, -h, 0, 0, 0);

  beginContour();
  float w1 = 3 * FT;
  float w2 = 5.5 * FT;
  float h1 = 30 * IN;
  float h2 = 7 * FT;
  float a = w1/w * grayStone.width;
  float b = w2/w * grayStone.width;
  float c = grayStone.height - h1/h * grayStone.height;
  float dd = grayStone.height -  h2/h * grayStone.height;

  vertex(w2, -30 * IN, 0, b, c);
  vertex(w2, -7 * FT, 0, b, dd);
  vertex(w1, -7 * FT, 0, a, dd);
  vertex(w1, -30 * IN, 0, a, c);
  //vertex(6.5 * FT, -30 * IN, 0, b, c);
  endContour();

  beginContour();
  w1 = 9.5 * FT;
  w2 = 12 * FT;
  a = w1/w * grayStone.width;
  b = w2/w * grayStone.width;

  vertex(w2, -30 * IN, 0, b, c);
  vertex(w2, -7 * FT, 0, b, dd);
  vertex(w1, -7 * FT, 0, a, dd);
  vertex(w1, -30 * IN, 0, a, c);
  //vertex(6.5 * FT, -30 * IN, 0, b, c);
  endContour();

  endShape(CLOSE);

  // right wall
  beginShape();
  texture(grayStone);
  vertex(w, -h, 0, grayStone.width, 0);
  vertex(w, 0, 0, grayStone.width, grayStone.height);
  vertex(w, 0, d, 0, grayStone.height);
  vertex(w, -h, d, 0, 0);
  endShape(CLOSE);

  //front wall
  beginShape();
  //fill(200);
  texture(grayStone);
  vertex(0, -h, d, 0, 0);
  vertex(w, -h, d, grayStone.width, 0);
  vertex(w, 0, d, grayStone.width, grayStone.height);
  vertex(0, 0, d, 0, grayStone.height);
  vertex(0, -h, d, 0, 0);

  beginContour();
  w1 = 9 * FT;
  w2 = 12 * FT;
  h1 = 0;
  h2 = 6.5 * FT;
  a = w1/w * grayStone.width;
  b = w2/w * grayStone.width;
  c = grayStone.height - h1/h * grayStone.height;
  dd = grayStone.height -  h2/h * grayStone.height;
  vertex(w1, -h1, d, a, c);
  vertex(w2, -h1, d, b, c);
  vertex(w2, -h2, d, b, dd);
  vertex(w1, -h2, d, a, dd);
  endContour();

  endShape();

  // tapestry for right wall

  beginShape();
  texture(unicorn1);
  vertex(w - 1, -FT * 9, FT * 3, 0, 0);
  vertex(w - 1, -FT * 9, FT * 9, unicorn1.width, 0);
  vertex(w - 1, -FT * 3, FT * 9, unicorn1.width, unicorn1.height);
  vertex(w - 1, -FT * 3, FT * 3, 0, unicorn1.height);
  endShape(CLOSE);

  popMatrix();
}


int loomBox = 1;

// Draw the loom
void loom() {
  pushMatrix();

  /* Loom of wood */

  box2(FT * 6 + 4 * IN, 4 * IN, 4 * IN, wood1, false);

  pushMatrix();
  translate(0, -(FT * 6 + 4 * IN), 0);
  box2(FT * 6 + 4 * IN, 4 * IN, 4 * IN, wood1, false);
  popMatrix();

  pushMatrix();
  translate(-1.5 * IN, -(FT * 3 + 4 * IN), IN * 1.5);
  box2(FT * 6 + 4 * IN, 2 * IN, 1 * IN, wood1, false);
  popMatrix();

  pushMatrix();
  translate(0, -4 * IN, 0);
  box2(2 * IN, 6 * FT, 4 * IN, wood1, false);
  popMatrix();

  pushMatrix();
  translate(6 * FT + 2 * IN, -4 * IN, 0);
  box2(2 * IN, 6 * FT, 4 * IN, wood1, false);
  popMatrix();

  /* Vertical Threads = Warp */
  for (int i = 1; i < 71; i++) {
    float x = 0;
    if (i % 2 == 0) {
      fill(225, 225, 0);
      x = IN * loomBox;
    } else {
      fill(225, 0, 0);
      x = IN * -loomBox;
    }
    pushMatrix();
    translate(IN * 2 + IN * i, -IN * 3, IN * 2 + x);
    cylinder(0.25 * IN, 6 * FT + 2 * IN, 7);
    popMatrix();
  }


  popMatrix();
}

/* Class for a needle.  I know nesting classes isn't the best programming form,
 but I wanted to keep the needle in the same place as the loom, and there isn't a class that
 this is inside.
 */
class Needle {
  float nx = -FT;
  float ny = -FT * 4;
  float nz = IN * 2;
  float nw = 0;
  float nd = 0;

  // bounding box
  float left = 0;
  float right = 0;
  float top = 0;
  float bottom = 0;

  void drawNeedle(float w, float h, float d) {
    nw = w;
    nd = d;

    top = ny - d/2;
    bottom = ny + d/2;

    pushMatrix();
    translate(nx, ny, nz);
    rotateX(-PI/2 * loomBox);
    if (loomBox == 1) {
      rotateZ(PI);
      right = nx;
      left = nx - w;
    } else {
      left = nx;
      right = nx + w;
    }
    beginShape();
    texture(wood1);
    vertex(0, 0, 0, wood1.width/2, wood1.height/2);
    vertex(w/6, 0, -d/2, wood1.width/6, 0);
    vertex(w, 0, -d/2, wood1.width, 0);
    vertex(w, 0, d/2, wood1.width, wood1.height);
    vertex(w/6, 0, d/2, wood1.width/6, wood1.height/2);
    endShape(CLOSE);

    popMatrix();
  }
}

void weft() {
  fill(120, 120, 30);
  for (int i = 0; i < strings.length; i++) {
    if (strings[i]) {
      pushMatrix();
      translate(0, -FT * 3 - 2 * IN, 0);
      translate(2 * IN, -3 * FT + 2 * IN + i * IN, IN * 2);
      rotateZ(PI/2);
      cylinder(IN/2, IN/2, 6 * FT, 9);
      popMatrix();
    }
  }
}
