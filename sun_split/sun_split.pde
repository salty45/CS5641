/**
 Castle and interactions.  The castle is comprised of walls, a gatehouse and gate, a keep, and a blacksmith forge.
 The interactions available include raising and lowering the gate ('g' and 't' keys),
 increasing the temperature of the fire by holding down the UP key (the fire temperature will decrease as a function
 of time based on number of frames displayed).
 There is also a weaving loom and weaving interaction ('b' key) located on the second floor of the castle keep.
 
 Controls to navigate are as follows:
 W:  Forward
 A:  Left
 S:  Backwards
 D:  Right
 R:  Up
 F:  Down
 Q or LEFT:  Turn left
 E or RIGHT:  Turn right
 
 The mouse will allow scrolling forwards and backwards or
 can be clicked and dragged with the right mouse button to pan left, right, up, or down.
 
 This main file does the setup and starts things running
 
 
 Author:  Sarah Larkin
 CS5641, Spring 2023
 
 Date Last Modified:  April 26, 2023
 */

// Scale
final float FT = 30;  // 1 foot
final float IN = 30.0 / 12;  // 1 inch


float gateY = 0;
boolean metaKey = false;
Needle needle;
Table1 workTableBlacksmith;
Bellows bellows;

void setup() {
  size(1800, 1200, P3D);
  // Initialize where you are looking
  eyeX = 0;
  eyeY = FT * 10;
  eyeZ = (FT * 15);
  camX = eyeX + width * cos(camTheta);
  camZ = eyeZ + width * sin(camTheta);
  camY = eyeY;

  // Do some extra initialization of objects
  loadImages();
  initLoom();
  needle = new Needle();
  setupSmithy();
}


void draw() {
  background(225);
  camera(eyeX, eyeY, eyeZ, camX, camY, camZ, 0, 1, 0);
  // set the camera up right after the background and before any drawing.


  float fx = -FT * 50;
  float fy = FT * 15;
  float fz = -FT * 80;
  pushMatrix();

  // Place the blacksmith shop
  pushMatrix();
  translate(FT * 5, -FT * 11.5, -FT * 20);
  pushMatrix();
  rotateY(-PI/2);
  translate(-FT * 10, 0, -FT * 30);
  drawSmithy();
  popMatrix();
  popMatrix();


  // Move everything else downward
  translate(fx, fy, fz);
  castleWalls();
  //castleWall();

  /*
 If everything else after the camera is commented out and just the loom, weft,
   and needle are uncommented with no translation before them, clicking and
   dragging on the needle will move it.
   */
  //pushMatrix();
  //loom();
  //weft();
  //needle.drawNeedle(1.5 * FT, 0, IN * 4);
  //popMatrix();

  // Place the keep
  pushMatrix();
  translate(FT * 28, 0, FT * 28 * 2);
  keep();
  popMatrix();

  // ground
  pushMatrix();
  fill(100, 255, 125);
  translate(-200 * FT, 3 * IN, 200 * FT);
  box(6000 * FT, 3 * IN, 6000 * FT);
  popMatrix();

  popMatrix();

  // This needs to be called in order to get the key response to work with holding down the keys.
  // It's an oddity of Processing 3.5 and later.
  if (keyPressed) {
    keyPressed();
  }

  mouseDragged();
}

void keyPressed() {
  // I never ended up using the metaKey much at the end,
  // but had initially been going to use it for more mouse controls
  if (keyCode == CONTROL) {
    metaKey = true;
  }

  // Weave with the loom
  if (key == 'b' || key == 'B') {

    if (strung >= 0) {
      loomBox *= -1;
      strings[strung--] = true;
      needle.ny -= IN;
      if (loomBox > 0) {
        needle.nx -= 7 * FT;
      } else {
        needle.nx += 7 * FT;
      }
      // this is so you have to individually press the key to weave,
      // rather than accidentally weaving multiple rows because of the keyboard sensitivity
      delay(100);
    }
  }

  // I used this to reposition the needle while testing the loom
  //if (key == 'v' || key == 'V') {
  //  needle.nx = -FT;
  //  needle.ny = -FT * 4;
  //  needle.nz = IN * 2;
  //}

  // increase the temperature of the fire
  if (keyCode == UP) {
    temp += 10;
  }

  // raise or lower the gate
  if (key == 'g' || key == 'G') {
    if (gateY > -FT * 10) {
      gateY -= IN * 6;
    }
  }
  if (key == 't' || key == 'T') {
    if (gateY < 0) {
      gateY += IN * 6;
    }
  }

  // do keyboard stuff with the camera controls
  camKeys();
}


void keyReleased() {
  if (keyCode == CONTROL) {
    metaKey = false;
  }
}

void mouseDragged() {
  if (mouseButton == RIGHT && !metaKey) {
    // Pan based on mouse movement
    float dx = pmouseX - mouseX;
    float dy = pmouseY - mouseY;
    float step = dx;
    eyeZ += step * cos(camTheta);  // increase to move right  // perpendicular axis
    eyeX -= step * sin(camTheta);  //  axis along which travel occurs
    camX = eyeX + width * cos(camTheta);
    camZ = eyeZ + width * sin(camTheta);
    camY += dy;
    eyeY += dy;
  } else if (mouseButton == LEFT) {
    // move the needle to weave if only the loom is present.  This was a bit buggy, so it
    // was replaced with the keyboard control for weaving instead
    float px = screenX(needle.left, needle.top, needle.nz);
    float pxp = screenX(needle.right, needle.top, needle.nz);
    println(px + ", " + pxp);
    float py = screenY(needle.nx, needle.top, needle.nz);
    float pyp = screenY(needle.nx, needle.bottom, needle.nz);
    println(py + ", " + pyp);
    println(mouseX + ", " + mouseY);

    boolean xs = mouseX  > px && mouseX < pxp;
    boolean ys = mouseY > py && mouseY < pyp;
    if (xs && ys) {
      println("hit the box!!");
      needle.nx -= (pmouseX - mouseX);
      needle.nd -= (pmouseY - mouseY);
    }
  }
}

void mouseWheel(MouseEvent event) {
  // scroll the mouse wheel to go in and out
  println(event);
  float e = event.getCount();
  println(e);
  float dz = e * FT * -1;
  float step = dz;
  eyeZ += step * sin(camTheta);
  eyeX += step * cos(camTheta);
  camX = eyeX + width * cos(camTheta);
  camZ = eyeZ + width * sin(camTheta);
}
