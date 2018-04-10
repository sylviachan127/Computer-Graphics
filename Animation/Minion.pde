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
  // want movable eyeball, throw away
  translate(0,1.8,0);      // Begin Drawing black Eyes
  fill(0,0,0);            // Black
  sphere(1); 
  //translate(0,1.8,0);      // Begin Drawing black Eyes
 
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

void minion_eyeball(){
  //fill(255,255,255);  //white, for testing purpose
  fill(0,0,0);  // blacks
  sphere(1);
}

void center_minion(float time, float movex, float movey, float movez){
  pushMatrix();
  translate_start_minion();
  rotate(time, movex, movey, movez);
  minion_body();
  popMatrix();
  
  //pushMatrix();
  //translate_start_minion();
  //translate(0,this.eyeball_height,this.eyeball_z);
  //minion_eyeball();
  //popMatrix(); 
  
  pushMatrix();
  translate_start_minion();
  rotate(time, movex, movey, movez);
  minion_hand();
  popMatrix();
  
  pushMatrix();
  translate_start_minion();
  rotate(time, movex, movey, movez);
  translate(0,3.8,0);
  rotate(PI/4);
  minion_hand();
  translate(0,3.2,0);
  rotate(-PI/2);
  rotateX(PI/2);
  minion_finger();
  popMatrix();
  
  pushMatrix();
  translate_start_minion();
  rotate(time, movex, movey, movez);
  translate(13,3,0);
  minion_hand();
  popMatrix();
  
  pushMatrix();
  translate_start_minion();
  rotate(time, movex, movey, movez);
  translate(15,8.8,0);
  rotate(PI/4);
  minion_hand();
  popMatrix();
  
  pushMatrix();
  translate_start_minion();
  rotate(time, movex, movey, movez);
  rotateZ(PI/2);
  translate(4.8,-7.5,0);
  rotateX(PI/2);
  minion_finger();
  popMatrix();

}