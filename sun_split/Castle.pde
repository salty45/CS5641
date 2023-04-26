/**
 This class has the information on building the castle.
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */

/* Outside castle walls */
void castleWalls() {
  // castle center will be back left corner
  pushMatrix();
  // left wall
  rotateY(PI/2);
  translate(-120 * FT, 0, 0);
  castleWall();
  popMatrix();
  pushMatrix();

  // right wall
  translate(FT * 120, 0, 0);
  rotateY(-PI/2);
  castleWall();
  popMatrix();

  // back wall
  pushMatrix();
  //rectangle_tube(FT * 120, FT * 15, FT * 8, grayStone, false);
  castleWall();
  popMatrix();

  // front wall
  pushMatrix();
  translate(0, 0, FT * 120 - FT * 8);
  frontOuterWall();
  //rectangle_tube(FT * 120, FT * 15, FT * 8, grayStone, false); // old placeholder
  popMatrix();


  // keep -- old placeholder
  //pushMatrix();
  //translate(FT * 28, 0, FT * 28);
  //rectangle_tube(FT * 30, FT * 35, FT * 30, grayStone, false);
  //popMatrix();
}

void frontOuterWall() {
  pushStyle();
  noStroke();
  pushMatrix();
  for (int i = 0; i < 15; i++) {
    pushMatrix();
    translate(i * FT * 8, 0, 0);
    if (i < 6 || i >= 9) {
      box2(FT * 8, FT * 8, FT * 8, grayStone, false);
    }
    popMatrix();
  }
  popMatrix();

  // Watch tower / gatehouse
  pushMatrix();
  translate(6 * FT * 8, 0, -FT * 10);
  box2(FT * 8, FT * 10, FT * 24, grayStone, false);
  popMatrix();

  pushMatrix();
  translate(8 * FT * 8, 0, -FT * 10);
  box2(FT * 8, FT * 10, FT * 24, grayStone, false);
  popMatrix();

  pushMatrix();
  translate(6 * FT * 8 + 2 * FT, -FT * 10, -FT * 9);
  box2(FT * 20, FT * 1, FT * 20, grayStone, false);
  popMatrix();

  pushMatrix();
  translate(6 * FT * 8 + 2 * FT, -FT * 17, -FT * 9);
  box2(FT * 20, FT * 1, FT * 20, grayStone, false);
  popMatrix();

  pushMatrix();
  translate(6 * FT * 8, -FT * 10, -FT * 10);
  for (int i = 0; i < 24/2; i++) {
    for (int j = 0; j < 24/2; j++) {
      if (i == 0 || i == 24/2 - 1 || j == 0 || j == 24/2 - 1) {

        // Doors from 2nd floor of gatehouse onto lower wall section
        if (j != 6 && j != 5) {
          pushMatrix();
          translate(i * FT * 2, 0, j * FT * 2);
          box2(FT * 2, FT * 4, FT * 2, grayStone, false);
          popMatrix();
        }


        // Gatehouse windows
        if (i != 4 && j != 6 && j != 5 && i != 6) {
          pushMatrix();
          translate(i * FT * 2, -FT * 3, j * FT * 2);
          box2(FT * 2, FT * 4, FT * 2, grayStone, false);
          popMatrix();
        }
        pushMatrix();
        translate(i * FT * 2, -FT * 7, j * FT * 2);
        box2(FT * 2, FT * 4, FT * 2, grayStone, false);
        popMatrix();
      }
    }
  }


  popMatrix();

  // gate
  pushMatrix();
  translate(8 * FT * 7, gateY, FT * 10);
  box2(FT*8, FT * 10, FT * 1, wood1, false);
  popMatrix();

  // wall either side of the gatehouse
  pushMatrix();
  for (int i = 0; i < 15; i++) {
    pushMatrix();
    translate(i * FT * 8, -8 * FT, 4 * FT);
    if (i < 6 || i >= 9) {
      box2(FT * 8, FT * 11, FT * 4, grayStone, false);
    }
    popMatrix();
  }
  popMatrix();

  // Wall topper
  pushMatrix();
  translate(0, -19 * FT, FT * 4);
  box2(FT * 6, FT * 4, FT * 3, grayStone, false);

  // 6 ft + 6 ft + 3 ft gap + 4 ft width
  for (int i = 0; i < 15; i++) {
    pushMatrix();
    translate(FT * i * 7 + FT * 3 + FT * 6, 0, 0);
    box2(FT * 4, FT * 4, FT * 4, grayStone, false);
    popMatrix();
  }
  translate(FT * (120 - 6), 0, 0);
  box2(FT * 6, FT * 4, FT * 3, grayStone, false);
  popMatrix();
}

void castleWall() {
  pushStyle();
  noStroke();
  pushMatrix();
  for (int i = 0; i < 15; i++) {
    pushMatrix();
    translate(i * FT * 8, 0, 0);
    box2(FT * 8, FT * 8, FT * 8, grayStone, false);
    popMatrix();
  }

  pushMatrix();
  translate(0, -FT * 8, 0);
  for (int i = 0; i < 15; i++) {
    pushMatrix();
    translate(i * FT * 8, 0, 0);
    box2(FT * 8, FT * 8, FT * 8, grayStone, false);
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  for (int i = 0; i < 40; i++) {
    pushMatrix();
    translate(i * FT * 3, -FT * 16, 0);
    box2(FT * 3, FT * 3, FT * 3, grayStone, false);
    popMatrix();
  }

  popMatrix();


  pushMatrix();
  translate(0, -19 * FT, 0);
  box2(FT * 6, FT * 4, FT * 3, grayStone, false);

  // 6 ft + 6 ft + 3 ft gap + 4 ft width
  for (int i = 0; i < 15; i++) {
    pushMatrix();
    translate(FT * i * 7 + FT * 3 + FT * 6, 0, 0);
    box2(FT * 4, FT * 4, FT * 4, grayStone, false);
    popMatrix();
  }
  translate(FT * (120 - 6), 0, 0);
  box2(FT * 6, FT * 4, FT * 3, grayStone, false);
  popMatrix();



  popMatrix();
  popStyle();
}


void keep() {
  pushMatrix();

  // back wall of the keep
  pushStyle();
  noStroke();
  frontWall(7);
  //fullWall();
  pushMatrix();
  rotateY(PI/2);
  fullWall(6);
  popMatrix();
  pushMatrix();
  rotateY(PI/2);
  translate(0, 0, FT * 24);
  fullWall(6);
  popMatrix();

  // Loom and room and tapestry
  pushMatrix();
  translate(FT * 0, -FT * 10, -FT * 18);
  float w = 15 * FT;
  pushMatrix();
  translate(FT * 15, -FT * 2, -FT*2);
  pushStyle();
  //tint(255, 0, 0);
  box2(IN * 6, FT * 10, FT * 16, grayStone, false);
  popStyle();
  popMatrix();
  beginShape();
  texture(unicorn1);
  vertex(w - 1, -FT * 9, FT * 3, 0, 0);
  vertex(w - 1, -FT * 9, FT * 9, unicorn1.width, 0);
  vertex(w - 1, -FT * 3, FT * 9, unicorn1.width, unicorn1.height);
  vertex(w - 1, -FT * 3, FT * 3, 0, unicorn1.height);
  endShape(CLOSE);
  // loom
  pushMatrix();
  translate(FT * 6, -FT * 2.5, 0);
  pushStyle();
  loom();
  weft();
  needle.drawNeedle(1.5 * FT, 0, IN * 4);
  popStyle();
  popMatrix();
  popMatrix();


  pushMatrix();
  translate(0, 0, -FT * 24);
  fullWall(7);
  popMatrix();

  translate(FT* 0, 0, -FT * 24);
  pushMatrix();
  translate(0, FT, 0);
  ceiling();
  translate(0, -12 * FT, 0);
  ceiling();
  translate(0, -12 * FT, 0);
  ceiling();
  translate(0, -12 * FT - FT, 0);
  ceiling();
  popMatrix();


  pushMatrix();
  translate(0, -37 * FT, 0);
  topper();
  popMatrix();
  pushMatrix();
  translate(0, -37 * FT, 26 * FT);
  topper();
  popMatrix();
  pushMatrix();
  translate(0, -37 * FT, 0);
  rotateY(PI/2);
  translate(-28 * FT, 0, 26 * FT);
  topper();
  popMatrix();

  pushMatrix();
  translate(0, -37 * FT, 0);
  rotateY(PI/2);
  //translate(0, 0, 26 * FT);
  translate(-28 * FT, 0, 0);
  topper();
  popMatrix();

  popStyle();
  popMatrix();
}

// ceiling / floor of keep
void ceiling() {
  for (int i = 0; i < 14; i++) {
    for (int j = 0; j < 14; j++) {
      pushMatrix();
      translate(i * FT * 2, 0, j * FT * 2);
      box2(FT * 2, FT * 1, FT * 2, grayStone, false);
      popMatrix();
    }
  }
}

// top of wall with battlements
void topper() {
  for (int i = 0; i < 14; i++) {
    pushMatrix();
    translate(FT * 2 * i, 0, 0);
    box2(FT * 2, FT * 2, FT * 2, grayStone, false);
    popMatrix();
  }
  pushMatrix();
  translate(0, -FT * 2, 0);
  box2(FT * 3, FT * 3, FT * 2, grayStone, false);
  for (int i = 1; i < 11; i+= 2) {
    pushMatrix();
    translate(i * 2 * FT + FT * 3, 0, 0);
    box2(FT * 2, FT * 3, FT * 2, grayStone, false);
    popMatrix();
  }
  translate(FT * 2 * 12 + FT, 0, 0);
  box2(FT * 3, FT * 3, FT * 2, grayStone, false);
  popMatrix();
}



void fullWall(int n) {
  pushMatrix();
  keepWall(n);
  pushMatrix();
  translate(0, -12 * FT, 0);
  keepWall(n);
  popMatrix();
  pushMatrix();
  translate(0, -24 * FT, 0);
  keepWall(n);
  popMatrix();
  popMatrix();
}

// Front wall of keep with door on 1st floor
void frontWall(int n) {
  pushMatrix();
  for (int i = 0; i < n; i++) {
    pushMatrix();
    if (i != 3) {
      translate(4 * FT * i, 0, 0);
      box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    }
    popMatrix();
  }
  pushMatrix();
  translate(0, -3 * FT, 0);
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(4 * FT * i, 0, 0);
    if (i != 3) {
      box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    }
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  translate(0, -6 * FT, 0);
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(4 * FT * i, 0, 0);
    //if (i != 2 && i != 4) {
    box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    //}
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  translate(0, -9 * FT, 0);
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(4 * FT * i, 0, 0);

    box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  translate(0, -12 * FT, 0);
  keepWall(n);
  popMatrix();
  pushMatrix();
  translate(0, -24 * FT, 0);
  keepWall(n);
  popMatrix();
  popMatrix();
}

void keepWall(int n) {
  pushMatrix();
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(4 * FT * i, 0, 0);
    box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    popMatrix();
  }
  //popMatrix();
  pushMatrix();
  translate(0, -3 * FT, 0);
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(4 * FT * i, 0, 0);
    if (i != 2 && i != 4) {
      box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    }
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  translate(0, -6 * FT, 0);
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(4 * FT * i, 0, 0);
    if (i != 2 && i != 4) {
      box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    }
    popMatrix();
  }
  popMatrix();

  pushMatrix();
  translate(0, -9 * FT, 0);
  for (int i = 0; i < n; i++) {
    pushMatrix();
    translate(4 * FT * i, 0, 0);
    //if (i != 2 && i != 4) {
    box2(4 * FT, 3 * FT, 4 * FT, grayStone, false);
    //}
    popMatrix();
  }
  popMatrix();
  popMatrix();
}
