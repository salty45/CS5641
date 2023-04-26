/**
 This is what is left of the main class for the smithy scene.  It takes care of running the fireplace
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */

/* Fireplace from assorted Oxygen */
final float T = 1650;
final float Y = 900;
float temp = T;
float h = 900;
float hi = 1;

Flame f;

Flame [] fireplace = new Flame[500];


void setupSmithy() {
  // lesson learned:  download a smaller size if you can
  // also go with jpg to jpeg conversion: https://jpg2jpeg.com/
  // and save the .png files for when you need transparency.
  // VERY small .jpg files appear to work, too!

  workTableBlacksmith = new Table1(wood1);
  bellows = new Bellows(leather);

  f = new Flame(width/2, 900, -150, 100, 900);
  // initialize the flames in the fireplace
  for (int i = 0; i < fireplace.length; i++) {
    fireplace[i] = new Flame(random(width/4, width/4 * 3), random(400, 1200), random(-width/4, -width/4 * 3), 400, 1200);
  }
}

float ang = 0;


void drawSmithy() {
  translate(width/3, height/3 * 2, 250);
  
  // Build the building
  draw_left_interior_wall();
  draw_back_interior_wall();
  draw_right_interior_wall();
  draw_fireplace_kneewall();
  drawRoof();
  
  // Table
  pushMatrix();
  workTableBlacksmith.setLocation(0, 0, FT*6);
  workTableBlacksmith.show();
  popMatrix();
  
  // Bellows
  pushMatrix();
  translate(FT * 3, 0, 0);
  bellows.show();
  popMatrix();
 
  // anvil
  pushStyle();
  fill(180, 180, 180);
  pushMatrix();
  anvil_base();
  popMatrix();
  popStyle();

  ang = ang + PI/90;

// Fire
  pushMatrix();
  scale(0.15, 0.15, 0.15);
  translate(1350, -1800, 850);
  for (Flame f : fireplace) {
    f.display(temp);
  }
  popMatrix();
  
  // Decrease the temperature at two different rates of speed
  if (temp > T) {
    temp -= 0.25;
  } else {
    temp -= 1;
  }
}




void draw_left_interior_wall() {
  beginShape();
  texture(brick);
  // go clockwise
  vertex(0, -30 * 8, brick.width, 0);
  vertex(0, 0, 0, brick.width, brick.height); // bottom of back left corner
  vertex(0, 0, 30 * 12, 0, brick.height);
  vertex(0, -30 * 8, 30 * 12, 0, 0);
  endShape(CLOSE);
}

void drawRoof() {
  pushMatrix();
  pushStyle();
  translate(0, -30*8, 0);
  tint(120, 100, 50);
  box2(30 * 14, FT * 1, 30 * 12, brick, false);
  popStyle();
  popMatrix();
  pushMatrix();
  box2(30 * 14, IN * 2, 30 * 12, brick, false);
  popMatrix();
}

void draw_back_interior_wall() {
  beginShape();
  texture(brick);
  // go clockwise
  vertex(0, -30 * 8, 0, 0);
  vertex(30 * 14, -30 * 8, 0, brick.width, 0);
  vertex(30 * 14, 0, 0, brick.width, brick.height);
  vertex(0, 0, 0, 0, brick.height);
  //vertex(0, 0, 0, brick.width, brick.height); // bottom of back left corner
  endShape(CLOSE);
}

void draw_right_interior_wall() {
  beginShape();
  texture(brick);
  vertex(30 * 14, -30 * 8, 0, 0, 0);
  vertex(30 * 14, -30 * 8, 30 * 12, brick.width, 0);
  vertex(30 * 14, 0, 30 * 12, brick.width, brick.height);
  vertex(30 * 14, 0, 0, 0, brick.height);

  beginContour(); // include "dummy" texture coordinates to avoid error message.
  // Note: dummy coordinates created an error with stretchy visuals.  It is necessary to calculate the actual texture coordinates
  // for these points!
  vertex(30 * 14, -30 * 6, 30 * 7.5, 7.5/12 *brick.width, 0.25 * brick.height);
  vertex(30 * 14, -30 * 4, 30 * 7.5, 7.5/12 *brick.width, 0.5 * brick.height);
  vertex(30 * 14, -30 * 4, 30 * 10.5, 10.5/ 12 *brick.width, 0.5 * brick.height);
  vertex(30 * 14, -30 * 6, 30 * 10.5, 10.5/ 12 *brick.width, 0.25 * brick.height);
  endContour();
  endShape(CLOSE);
}

void draw_fireplace_kneewall() {
  // outer wall  The extra curly brackets are here just because I'm not feeling
  // creative with variable naming and want different variable scopes.
  {
    beginShape(QUAD_STRIP);
    texture(brick);
    float radius = 30 * 6;
    float x = 30 * 14;
    float z = 0;
    float h = -30 * 3;
    float theta = 2 * PI/20;
    for (float i = 5; i <= 10; i++) {
      float x1 = x + radius * cos(theta * i);
      float z1 = z + radius * sin(theta * i);
      vertex(x1, h, z1, i * brick.width/20, 0);
      vertex(x1, 0, z1, i * brick.width/20, brick.height);
    }
    endShape();
  }

  // inner wall  The extra curly brackets are here just because I'm not feeling
  // creative with variable naming and want different variable scopes.
  {
    beginShape(QUAD_STRIP);
    texture(brick);
    float radius = 30 * 5;
    float x = 30 * 14;
    float z = 0;
    float h = -30 * 3;
    float theta = 2 * PI/20;
    for (float i = 5; i <= 10; i++) {
      float x1 = x + radius * cos(theta * i);
      float z1 = z + radius * sin(theta * i);
      vertex(x1, h, z1, i * brick.width/20, 0);
      vertex(x1, 0, z1, i * brick.width/20, brick.height);
    }
    endShape();
  }

  // top of the wall.  The extra curly brackets are here just because I'm not feeling
  // creative with variable naming and want different variable scopes.
  {
    beginShape(QUAD_STRIP);
    texture(brick);
    float r1 = 30 * 5;
    float r2 = 30 * 6;
    float x = 30 * 14;
    float z = 0;
    float h = -30 * 3;
    float theta = 2 * PI/20;
    for (float i = 5; i <= 10; i++) {
      float x1 = x + r1 * cos(theta * i);
      float z1 = z + r1 * sin(theta * i);
      float x2 = x + r2 * cos(theta * i);
      float z2 = z + r2 * sin(theta * i);
      vertex(x1, h, z1, i * brick.width/20, 0);
      vertex(x2, h, z2, i * brick.width/20, brick.height);
    }
    endShape();
  }
}


void draw_table() {
  pushStyle();
  // table top
  beginShape();
  tint(#888800);
  texture(brick); // TODO: switch to wood
  vertex(0, -30 * 3, 30 * 6.5, 0, 0);
  vertex(30 * 3, -30 * 3, 30 * 6.5, brick.width, 0);
  vertex(30 * 3, -30 * 3, 30 * 11.5, brick.width, brick.height);
  vertex(0, -30 * 3, 30 * 11.5, 0, brick.height);
  endShape(CLOSE);

  // underside of table top
  beginShape();
  tint(#888800);
  texture(brick); // TODO: switch to wood
  vertex(0, -30 * 3 + 30 * 2.0/12, 30 * 6.5, 0, 0);
  vertex(30 * 3, -30 * 3 + 30 * 2.0/12, 30 * 6.5, brick.width, 0);
  vertex(30 * 3, -30 * 3 + 30 * 2.0/12, 30 * 11.5, brick.width, brick.height);
  vertex(0, -30 * 3 + 30 * 2.0/12, 30 * 11.5, 0, brick.height);
  endShape(CLOSE);

  // table legs
  pushMatrix();
  translate(30.0 * 2.0/12, 0, 30 * 6.5 + 30.0 * 2.0/12);
  rectangle_tube2(30 * 1/3.0, 30 * 2.75, 30 * 1/3.0, brick);
  popMatrix();

  popStyle();
}
