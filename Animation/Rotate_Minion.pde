float angle = 0;

void left_minion(){
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
}

void up_minion(){
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
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      zoom += .03;
    } else if (keyCode == DOWN) {
      zoom -= .03;
    } else if (keyCode == RIGHT) {
      this.angle += PI/4;
    } else if (keyCode == LEFT) {
      this.angle -= PI/4;
      println("i press left");
    }
  }
}