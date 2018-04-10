// 3D Minion
// Sylvia Chan

import processing.opengl.*;

float time = 0;  // keep track of passing of time

void setup() {
  size(800, 800, P3D);  // must use 3D here !!!
  noStroke();           // do not draw the edges of polygons
}

void rotate_up(){
  pushMatrix();
  translate (-30, 0, 0);
  rotate (time, 1.0, 0.0, 0.0);      // rotate based on "time"
  translate (0.0, -10.0, 0.0);
}

void rotate_left(){
  pushMatrix();
  translate (30, 0, 0);
  rotate (time, 0.0, 1.0, 0.0);      // rotate based on "time"
  translate (0.0, -10.0, 0.0);
}

// Draw a scene with a cylinder, a sphere and a box
void draw() {
  
  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(0);  // clear the screen to black
  
  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);
  
  // place the camera in the scene (just like gluLookAt())
  camera (0.0, 0.0, 80.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
    
  // create an ambient light source
  ambientLight (102, 102, 102);
  
  // create two directional light sources
  lightSpecular (204, 204, 204);
  directionalLight (102, 102, 102, -0.7, -0.7, -1);
  directionalLight (152, 152, 152, 0, 0, -1);
  
  // Draw a Minion rotate up down
  
  rotate_up();
  minion_body();
  popMatrix();
  
  rotate_up();
  minion_hand();
  popMatrix();
  
  rotate_up();
  translate(0,3.8,0);
  rotate(PI/4);
  minion_hand();
  popMatrix();

  rotate_up();
  translate(-7.5,0,0);
  rotateY(PI/1.5);
  rotateZ(PI/1.5);
  minion_finger();
  popMatrix();
  
  rotate_up();
  translate(13,3,0);
  //rotate(-PI/4);
  minion_hand();
  popMatrix();
  
  rotate_up();
  translate(15,8.8,0);
  rotate(PI/4);
  minion_hand();
  popMatrix();
  
  rotate_up();
  rotateZ(PI/2);
  translate(4.8,-7.5,0);
  rotateX(PI/2);
  minion_finger();
  popMatrix();
  
  // Draw Minion at the center
  pushMatrix();
  minion_body();
  popMatrix();
  
  pushMatrix();
  minion_hand();
  popMatrix();
  
  pushMatrix();
  translate(0,3.8,0);
  rotate(PI/4);
  minion_hand();
  popMatrix();

  pushMatrix();
  translate(-7.5,0,0);
  rotateY(PI/1.5);
  rotateZ(PI/1.5);
  minion_finger();
  popMatrix();
  
  pushMatrix();
  translate(13,3,0);
  //rotate(-PI/4);
  minion_hand();
  popMatrix();
  
  pushMatrix();
  translate(15,8.8,0);
  rotate(PI/4);
  minion_hand();
  popMatrix();
  
  pushMatrix();
  rotateZ(PI/2);
  translate(4.8,-7.5,0);
  rotateX(PI/2);
  minion_finger();
  popMatrix();

  // Draw a Minion rotate right left
  rotate_left();
  minion_body();
  popMatrix();
  
  rotate_left();
  minion_hand();
  popMatrix();
  
  rotate_left();
  translate(0,3.8,0);
  rotate(PI/4);
  minion_hand();
  popMatrix();

  rotate_left();
  translate(-7.5,0,0);
  rotateY(PI/1.5);
  rotateZ(PI/1.5);
  minion_finger();
  popMatrix();
  
  rotate_left();
  translate(13,3,0);
  //rotate(-PI/4);
  minion_hand();
  popMatrix();
  
  rotate_left();
  translate(15,8.8,0);
  rotate(PI/4);
  minion_hand();
  popMatrix();
  
  rotate_left();
  rotateZ(PI/2);
  translate(4.8,-7.5,0);
  rotateX(PI/2);
  minion_finger();
  popMatrix();
  
  // Draw a sphere
  
  pushMatrix();
  fill (100, 200, 100);
  ambient (50, 50, 50);
  specular (155, 155, 155);
  shininess (15.0);
  
  sphereDetail (40);
  //sphere (13);
  popMatrix();
 
  // Draw a box
  
  pushMatrix();

  fill (100, 100, 200);
  ambient (100, 100, 200);
  specular (0, 0, 0);
  shininess (1.0);
  
  translate (30, 0, 0);
  rotate (-time, 1.0, 0.0, 0.0);      // rotate based on "time"
  //box (20);
  
  popMatrix();
 
  this.time +=0.02;
}

void minion_body(){
  fill(255,255,51);              // Yellow
  sphere(6);  // Minion Head
  cylinder (6.0, 15.0, 32,0);    // Minion Main Body
  fill(155,114,31);          // Brown
  cylinder (6.2, 3.0, 32,0);    // minion Eyes Band
  fill(255,255,255);
  translate(0,1.8,5);
  sphere(3);
  translate(0,0.3,0.5);
  fill(155,114,31);            // Brown
  rotateX(PI/2);
  cylinder (3.5, 1.0, 32,0);
  translate(0,1.8,0);      // Begin Drawing black Eyes
  fill(0,0,0);            // Black
  sphere(1); 
 
  fill(95,121,212);          // Blue
  rotateX(-PI/2);
  translate(0,6.8,-7.2);
  cylinder (6.3, 1.5, 32,0);    // minion blue belt
  
  fill(255,255,255);          // White
  translate(0,1.5,0.0);
  cylinder (6.3, 7.5, 32,sin(10));    // minion white Dress
  
  fill(232,79,79);          // Red
  translate(0,-4,6);
  sphere(0.5);
  //stroke(255, 102, 0);        // smile?
  //translate(8,-9.0,7);
  //rotateZ(PI/2);
  //curve(0, 0, 5, 5, 5, 15, 5, 25);
  
  // Minion Left Feet
  translate(-2.5,12,-3);
  rotateX(-PI/2);
  minion_feet();

  // Minion Right Feet
  translate(5,0,0);
  minion_feet();
  
  fill(0,0,255);  // Blue
  translate(-2.3, -3,-9);  // Belt center
  box(2);
  
  rotateY(PI/2);    // Make Left Belt Vertical facing
  //rotate(0,4,4,4);
  //rotateZ(PI/6);
  rotateY(2.9);
  translate(2.5,0,0);  // Left Belt
  scale(1,0.5,0.2);
  box(4);
  //scale(1,0.5,0.8);
  //translate(2.5,0,0);  // Right Belt
  //rotateZ(30);
  //rotate(10,10,10,0);
  //rotateY(20);
  //scale(1,0.5,0.2);
  //box(40);
}

void minion_feet(){
  fill(255,255,51);              // Yellow
  cylinder (1, 3, 32,0);
}

void minion_hand(){
  fill(255,255,51);              // Yellow
  translate(-5.5,5,0);
  rotateZ(PI/4);
  rotateZ(PI/2);
  cylinder (0.8, 3, 32,0);
}

void minion_finger(){
  fill(117,77,36);          // brown
  sphere(1);
  translate(-0.8,0,0);
  rotateX(PI/2);
  rotateZ(PI/2);
  cylinder(0.5, 1,32,0);
  rotate(PI/3);
  cylinder(0.5, 1.3,32,0);
  rotate(-PI/3);
  rotate(-PI/3);
  cylinder(0.5, 1.3,32,0);
}

// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides, float wave) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
   ii = (i+1) % sides;
   beginShape(TRIANGLES);
   vertex (c[ii] * radius, height, s[ii] * radius);
   vertex (c[i] * radius, height, s[i] * radius);
   vertex (0.0, height, 0.0);
   endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], wave, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}