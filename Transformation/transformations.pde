// CS 3451
// main program file

// Current test case being displayed
TestCase currentTest;
boolean animate = false;
float animTime = 0f;
float timeInState = 0f;

void setup() {
  //setup the screen size, color mode and default background color
  size(300, 300);
  colorMode(RGB, 255);
  background(0, 0, 0);
}

void draw() {
  gtClear(0, 0, 0);
  
  keepTrackOfTime();
  
  // Render the current test-case.
  if (currentTest != null) {
    renderTestCase();
  }
}

void renderTestCase() {
  currentTest.show();
    
  // Show help text.
  textAlign(CENTER);
  if (currentTest.animates) {
    text("press spacebar to toggle animation", width/2, height-10 + max(0, 100 - 80*timeInState));
  } 
  String name = currentTest.key + ". " + currentTest.name;
  fill(#000000);
  for (int i = -1; i <= 1; i++)
    for (int j = -1; j <= 1; j++)
      text(name, width/2+i*2, 15+j*2);
  fill(#FFFFFF);
  text(name, width/2, 15);
}

long lastMillis = millis();
void keepTrackOfTime() {
  long now = millis();
  float delta = (now - lastMillis)/1000f;
  lastMillis = now;
  
  if (animate)
    animTime += delta;
  else
    animTime = 0f;
    
  timeInState += delta;
}

void keyPressed() {
  // Test cases correspond to key presses 1 - 9 (inclusive).
  TestCase[] cases = { 
    lineTest,         // '1'
    orthoTest,        // '2'
    orthoTestScale,   // '3' 
    orthoTestRotate,  // '4'
    faceTest,         // '5'
    facesTest,        // '6'
    orthoCubeTest,    // '7'
    orthoCubeTest2,   // '8'
    perspCubeTest,    // '9'
    perspCubeTest3    // '0'
  };
  
  if (key >= '0' && key <= '9' || key == 'o' || key == 'p') {
    if (key == 'o') currentTest = axesOrtho;
    else if (key == 'p') currentTest = axesPersp;
    else {
      int i = key - '1';
      if (key == '0')
        i += 10;
      currentTest = cases[i]; 
    }
    currentTest.key = key;
    timeInState = 0f;
  }
  
  if (key == ' ') {
    animate = !animate; 
  }
    
  //println("k="+key+" kc="+keyCode);
}

void mousePressed() {
  if (mouseButton == LEFT) { println("you left clicked pixel ("+mouseX+", "+mouseY+")"); }
}


/* the test cases are below */

// TestCase definitions (don't worry about this, just look at the methods).
TestCase lineTest        = new TestCase("Random Lines") { void show() { line_test(); } },
         orthoTest       = new TestCase("Ortho") { void show() { ortho_test(); } },
         orthoTestScale  = new TestCase("Ortho Scaling") { void show() { ortho_test_scale(); } },
         orthoTestRotate = new TestCase("Ortho Rotating") { void show() { ortho_test_rotate(); } },
         faceTest        = new TestCase("Face") { void show() { face_test(); } },
         facesTest       = new TestCase("Faces", true) { void show() { faces(); } },
         orthoCubeTest   = new TestCase("Ortho - Cube 1") { void show() { ortho_cube(); } },
         orthoCubeTest2  = new TestCase("Ortho - Cube 2", true) { void show() { ortho_cube2(); } },
         perspCubeTest3  = new TestCase("Perspective - Cube 3", true) { void show() { persp_cube3(); } },
         perspCubeTest   = new TestCase("Perspective - Cube 2", true) { void show() { persp_cube(); } },
         axesOrtho       = new TestCase("Orthographic Axes", true) { void show() { ortho_axes(); } },
         axesPersp       = new TestCase("Perspective Axes", true) { void show() { persp_axes(); } };


/******************************************************************************
Draw some random lines.
******************************************************************************/

abstract class TestCase {
  boolean animates = false;
  String name = "";
  char key = '?';
  TestCase(boolean animates) { this.animates = animates; }
  TestCase() { this(false); }
  TestCase(String name) { this.name = name; }
  TestCase(String name, boolean animates) { this.name = name; this.animates = animates; }
  abstract void show();
}

void line_test()
{
  int i;
  float x0,y0,x1,y1;

  gtInitialize();
  
  /* draw a bunch of random lines */
  
  randomSeed(3451);

  for (i = 0; i < 200; i++) {
    x0 = random(-120, 480);
    y0 = random(-120, 480);
    x1 = random(-120, 480);
    y1 = random(-120, 480);
/*    x0 = random(0, 360);
    y0 = random(0, 360);
    x1 = random(0, 360);
    y1 = random(0, 360);*/
    draw_line (x0, y0, x1, y1);
  }
}


/******************************************************************************
Test the orthographic projection routine.
******************************************************************************/

void ortho_test()
{

  gtInitialize();

  gtOrtho (-100.0, 100.0, -100.0, 100.0);

  square();
}

void ortho_test_scale()
{
   gtInitialize();

   gtOrtho (-100.0, 100.0, -100.0, 100.0);

   gtPushMatrix();
   
   gtScale(1,0.5,1);

   square();
   
   gtPopMatrix();
}

void ortho_test_rotate()
{
   gtInitialize();

   gtOrtho (-100.0, 100.0, -100.0, 100.0);

   gtPushMatrix();
   
   gtRotate('z', 20);

   square();
   
   gtPopMatrix();
}

void square(){
  gtBeginShape ();

  /* a square */

  gtVertex (-50.0, -50.0, 7.0);
  gtVertex (-50.0, 50.0, 20.0);

  gtVertex (-50.0, 50.0, 7.0);
  gtVertex (50.0, 50.0, 20.0);

  gtVertex (50.0, 50.0, 7.0);
  gtVertex (50.0, -50.0, 20.0);

  gtVertex (50.0, -50.0, 7.0);
  gtVertex (-50.0, -50.0, 20.0);

  gtEndShape();
}


/******************************************************************************
Draw a cube.
******************************************************************************/

void cube()
{
  gtBeginShape ();

  /* top square */

  gtVertex (-1.0, -1.0,  1.0);
  gtVertex (-1.0,  1.0,  1.0);

  gtVertex (-1.0,  1.0,  1.0);
  gtVertex ( 1.0,  1.0,  1.0);

  gtVertex ( 1.0,  1.0,  1.0);
  gtVertex ( 1.0, -1.0,  1.0);

  gtVertex ( 1.0, -1.0,  1.0);
  gtVertex (-1.0, -1.0,  1.0);

  /* bottom square */

  gtVertex (-1.0, -1.0, -1.0);
  gtVertex (-1.0,  1.0, -1.0);

  gtVertex (-1.0,  1.0, -1.0);
  gtVertex ( 1.0,  1.0, -1.0);

  gtVertex ( 1.0,  1.0, -1.0);
  gtVertex ( 1.0, -1.0, -1.0);

  gtVertex ( 1.0, -1.0, -1.0);
  gtVertex (-1.0, -1.0, -1.0);

  /* connect top to bottom */

  gtVertex (-1.0, -1.0, -1.0);
  gtVertex (-1.0, -1.0,  1.0);

  gtVertex (-1.0,  1.0, -1.0);
  gtVertex (-1.0,  1.0,  1.0);

  gtVertex ( 1.0,  1.0, -1.0);
  gtVertex ( 1.0,  1.0,  1.0);

  gtVertex ( 1.0, -1.0, -1.0);
  gtVertex ( 1.0, -1.0,  1.0);

  gtEndShape();
}


/******************************************************************************
Orthographic cube 1.
******************************************************************************/

void ortho_cube()
{
  gtInitialize();
    
  gtOrtho (-2.0, 2.0, -2.0, 2.0);

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -4.0);
  gtRotate('y', 17);
  cube();
  gtPopMatrix();
}

/******************************************************************************
Orthographic cube 2. Same as above but with different order of rotations.
******************************************************************************/

void ortho_cube2()
{
  gtInitialize();
    
  gtOrtho (-2.0, 2.0, -2.0, 2.0);

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -4.0);
  gtRotate('z', 30 * cos(animTime));
  gtRotate('x', 30 * cos(animTime));
  gtRotate('y', 45 * cos(animTime));
  cube();
  gtPopMatrix();
}

// Same as cube2 but in perspective
void persp_cube() {
  gtInitialize();
    
  gtPerspective(60f);

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -4.0);
  gtRotate('z', 30 * cos(animTime));
  gtRotate('x', 30 * cos(animTime));
  gtRotate('y', 45 * cos(animTime));
  cube();
  gtPopMatrix();
}

void persp_cube3()
{
  gtInitialize();
    
  gtPerspective(60f);

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -4.0);
  gtRotate(animTime*10f, 0, 1, 1);
  cube();
  gtPopMatrix();
}


/******************************************************************************
Draw X, Y, Z axes.
******************************************************************************/

void axes()
{
  /* x, y, and z axes */

  gtBeginShape ();

  gtVertex (0.0, 0.0, 0.0);
  gtVertex (50.0, 0.0, 0.0);

  gtVertex (0.0, 0.0, 0.0);
  gtVertex (0.0, 50.0, 0.0);

  gtVertex (0.0, 0.0, 0.0);
  gtVertex (0.0, 0.0, 50.0);

  gtEndShape();

  /* the letter X */

  gtPushMatrix();

  gtTranslate (60.0, 0.0, 0.0);
  gtScale (5.0, 5.0, 5.0);

  gtBeginShape ();
  gtVertex (1.0, 1.0, 0.0);
  gtVertex (-1.0, -1.0, 0.0);
  gtVertex (1.0, -1.0, 0.0);
  gtVertex (-1.0, 1.0, 0.0);
  gtEndShape();

  gtPopMatrix();

  /* the letter Y */

  gtPushMatrix();

  gtTranslate (0.0, 60.0, 0.0);
  gtScale (5.0, 5.0, 5.0);

  gtBeginShape ();
  gtVertex (1.0, 1.0, 0.0);
  gtVertex (0.0, 0.0, 0.0);
  gtVertex (-1.0, 1.0, 0.0);
  gtVertex (0.0, 0.0, 0.0);
  gtVertex (0.0, 0.0, 0.0);
  gtVertex (0.0, -1.0, 0.0);
  gtEndShape();

  gtPopMatrix();

  /* the letter Z */

  gtPushMatrix();

  gtTranslate (0.0, 0.0, 60.0);
  gtScale (5.0, 5.0, 5.0);

  gtBeginShape ();
  gtVertex (1.0, 1.0, 0.0);
  gtVertex (-1.0, -1.0, 0.0);
  gtVertex (-1.0, 1.0, 0.0);
  gtVertex (1.0, 1.0, 0.0);
  gtVertex (-1.0, -1.0, 0.0);
  gtVertex (1.0, -1.0, 0.0);
  gtEndShape();

  gtPopMatrix();

  /* three cubes along the -z axis */

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -100.0);
  gtScale (10.0, 10.0, 10.0);
  cube();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -200.0);
  gtScale (10.0, 10.0, 10.0);
  cube();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate (0.0, 0.0, -400.0);
  gtScale (10.0, 10.0, 10.0);
  cube();
  gtPopMatrix();
}


/******************************************************************************
Draw a circle of unit radius.
******************************************************************************/

void circle()
{
  int i;
  float theta;
  float x0,y0,x1,y1;
  float steps = 50;

  gtBeginShape ();

  x0 = 1.0;
  y0 = 0.0;
  for (i = 0; i <= steps; i++) {
    theta = 2 * 3.1415926535 * i / steps;
    x1 = cos (theta);
    y1 = sin (theta);
    gtVertex (x0, y0, 0.0);
    gtVertex (x1, y1, 0.0);
    x0 = x1;
    y0 = y1;
  }

  gtEndShape();
}


/******************************************************************************
Draw a face.
******************************************************************************/

void face()
{
  /* head */

  gtPushMatrix();
  gtTranslate (0.5, 0.5, 0.0);
  gtScale (0.4, 0.4, 1.0);
  circle();
  gtPopMatrix();

  /* right eye */

  gtPushMatrix();
  gtTranslate (0.7, 0.7, 0.0);
  gtScale (0.1, 0.1, 1.0);
  circle();
  gtPopMatrix();

  /* left eye */

  gtPushMatrix();
  gtTranslate (0.3, 0.7, 0.0);
  gtScale (0.1, 0.1, 1.0);
  circle();
  gtPopMatrix();

  /* nose */

  gtPushMatrix();
  gtTranslate (0.5, 0.5, 0.0);
  gtScale (0.07, 0.07, 1.0);
  circle();
  gtPopMatrix();

  /* mouth */

  gtPushMatrix();
  gtTranslate (0.5, 0.25, 0.0);
  gtScale (0.2, 0.1, 1.0);
  circle();
  gtPopMatrix();
}


/******************************************************************************
Test the matrix stack by drawing a face.
******************************************************************************/

void face_test()
{
  gtInitialize ();

  gtOrtho (0.0, 1.0, 0.0, 1.0);

  face();
}


/******************************************************************************
Draw four faces.
******************************************************************************/

void faces()
{
  gtInitialize ();

  gtOrtho (0.0, 1.0, 0.0, 1.0);

  gtPushMatrix();
  gtTranslate (0.75, 0.25, 0.0);
  gtScale (0.5, 0.5, 1.0);
  gtTranslate (-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate (0.25, 0.25, 0.0);
  gtScale (0.5, 0.5, 1.0);
  gtTranslate (-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate (0.75, 0.75, 0.0);
  gtScale (0.5, 0.5, 1.0);
  gtTranslate (-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();

  gtPushMatrix();
  gtTranslate (0.25, 0.75, 0.0);
  gtScale (0.5, 0.5, 1.0);
  gtRotate(animTime*100, 1,1,0);
  gtRotate ('z', 30);
  gtTranslate (-0.5, -0.5, 0.0);
  face();
  gtPopMatrix();
}

void ortho_axes()
{
  gtInitialize();
  gtOrtho (-100.0, 100.0, -100.0, 100.0);

  gtPushMatrix();
  gtRotate (45.0, 1.0, -1.0, 0.0);
  gtTranslate (-100.0, -100.0, -150.0);
  gtRotate(animTime*30f, 0, 1, 0);
  axes();
  gtPopMatrix();
}


/******************************************************************************
Draw axes in perspective.
******************************************************************************/

void persp_axes()
{
  gtInitialize();
  gtPerspective (60.0);

  gtPushMatrix();
  gtRotate (45.0, 1.0, -1.0, 0.0);
  gtTranslate (-100.0, -100.0, -150.0);
  gtRotate(animTime*30f, 0, 1, 0);
  axes();
  gtPopMatrix();
}