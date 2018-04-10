// 3D Minion
// Sylvia Chan
// Magic Prymaid

import processing.opengl.*;

float time = 0;  // keep track of passing of time
float zoom =  80;  // default 80, completely zoom out 580
float eyeX = 0;
float eyeY = 0;
float center_x = 0;
float center_y = 0;
float center_z = -1;
float startZ_minion = -30;
float startY_minion = -10;
float eyeball_height = 2;
float eyeball_z = 8;
float rotation = 0;
boolean ladder = false;
boolean ladder_over = false;
boolean testing = false;
boolean move = true;
boolean sand = false;
boolean ladder_over_write = false;
boolean finish_ladder_write = false;
boolean at_base = true;  // default true
boolean reach_top = false;

float base_z=0;
float rope_height=0;
float distance = 75;
boolean rope_appear = false;
boolean at_top = false;    // default false;
float rope_height_limit = 150;
float speed = 1;
float top_count_down = 100;
float left_top_move = -100;
boolean top_zoom_finish = false;
float top_minion_x_move = 0;
float top_minion_y_move = 0;
float top_minion_z_move = 0;
float top_minion_rotate_counter = 0;
float top_minion_rotate_counter_limit = 100;
float rotate_minion = 0;
float frame_count = 0;
boolean top_rotate_finish = false;
boolean top_zoom_rotate_finish = false;
float top_rotate_finish_count = 0;
float top_translate_x = 0;
boolean in_prymaid = false;
float red_ball = 255;
float green_ball = 0;
float blue_ball = 0;
boolean ball_change_count_reach = false;
float ball_change_count = 0;
boolean dont_move_minion = true;
boolean in_prymaid_finish = false;
float testingCounter = 0;
float minion_counter=0;

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

void translate_start_minion(){
  translate(0,startY_minion,startZ_minion);
}

void climb(){
  if(!testing && this.startY_minion>-50){
    this.startY_minion-=0.1;
  }
}

// Draw a scene with a cylinder, a sphere and a box
void draw() {
  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(92,213,250);  // turn background into sky color
  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);
  
  if(at_base){
    this.center_y = 180;
    this.eyeY=170;
    this.eyeX = -100;
    zoom+=speed;
  }
  if(at_top && top_count_down>=0){
    this.center_y =0;
    this.eyeY=-10;
    this.eyeX = -100;
    zoom = 280;
    top_count_down--;
  }
  if(!top_rotate_finish && top_count_down<=0){
    this.eyeX=left_top_move;
    if(left_top_move>=-120){
      left_top_move--;
    }
    if(zoom>=100){
      zoom--;
      top_zoom_finish = true;
      //top_rotate_finish = true;
    }
  }
  
  if(top_rotate_finish){
    //println("i am here");
    top_rotate_finish_count++;
  }
  
  if(top_rotate_finish && top_rotate_finish_count>=50){   // zoom back out later on at the top once zoom minion in
    //println("reach here");
    if(zoom<=250){
      //println("zooming");
      zoom++;
    }
    if(zoom>=250){
      top_zoom_rotate_finish = true;
    }
  }
  this.rotation++;
  
  camera (this.eyeX, this.eyeY, zoom, this.center_x+this.eyeX, this.center_y, this.center_z, 0.0, 1.0, 0.0);
    
  // create an ambient light source
  ambientLight (102, 102, 102);
  
  // create two directional light sources
  lightSpecular (204, 204, 204);
  //directionalLight (102, 102, 102, -0.7, -0.7, -1); // light shine from right
  directionalLight (152, 152, 152, 0, 1, 0); // light shine at upward
 
  pushMatrix();    // Draw sand
  sand();
  popMatrix();
  
  pushMatrix();    // Draw Pyrmaid
  scale(.5,.5, .5);
  translate(0,-50,0);
  pyramid(0);
  popMatrix();
  
  pushMatrix();  // Draw spinning ball
  translate(0,-90,0);
  if(in_prymaid && !ball_change_count_reach){    // Change ball color when minion in prymaid
    red_ball = random(0,255);
    green_ball = random(0,255);
    blue_ball = random(0,255);
    ball_change_count++;
  }
  if(ball_change_count>=200){
    ball_change_count_reach = true;
  }
  
  prize(this.time, red_ball, green_ball, blue_ball);
  popMatrix();
  
  pushMatrix();
  translate(-100,180,0);
  base_cube();
  popMatrix();
  
  pushMatrix();    // Draw Minion at the base
  if(top_zoom_finish && top_minion_rotate_counter<=top_minion_rotate_counter_limit){
    top_minion_y_move = 1;
    top_minion_rotate_counter++;
  }
  if(top_zoom_finish && top_minion_rotate_counter>=top_minion_rotate_counter_limit){
    top_minion_y_move = 0;
    rotate_minion=PI/2;
    top_rotate_finish = true;
  }
  if(top_zoom_rotate_finish && top_translate_x<=120){
    top_translate_x++;
    //zoom = 380;
    if(top_translate_x>=120){
      in_prymaid = true;
    }
  }
  if(ball_change_count_reach && dont_move_minion && !in_prymaid_finish){
    top_translate_x=60;    // Should be 60;
    rotate_minion=-PI/2;
    in_prymaid_finish = true;
    println("am i still here");
  }
  
  if(in_prymaid_finish){
    top_translate_x=60-testingCounter;
    rotate_minion=-PI/2;
    println(top_translate_x);
    if(testingCounter<=150){
      testingCounter++;
    }
    minion_counter++;
  }
  translate(-100+top_translate_x,166-rope_height,base_z);
  rotateY(rotate_minion);
  center_minion(this.time,top_minion_x_move,top_minion_y_move,top_minion_z_move);
  popMatrix();
  
  if(minion_counter>=100){  
    pushMatrix();
      translate(-100+top_translate_x+20,166-rope_height,base_z);
      rotateY(rotate_minion);
      // object instancing another minion after power
      center_minion(this.time,top_minion_x_move,top_minion_y_move,top_minion_z_move);
    popMatrix();
  }
  
  if(minion_counter>=110){  
    pushMatrix();
      translate(-100+top_translate_x+40,166-rope_height,base_z);
      rotateY(rotate_minion);
      // object instancing another minion after power
      center_minion(this.time,top_minion_x_move,top_minion_y_move,top_minion_z_move);
    popMatrix();
  }
  
  if(minion_counter>=120){  
    pushMatrix();
      translate(-100+top_translate_x+60,166-rope_height,base_z);
      rotateY(rotate_minion);
      // object instancing another minion after power
      center_minion(this.time,top_minion_x_move,top_minion_y_move,top_minion_z_move);
    popMatrix();
  }
  if(at_base && base_z<40){  // Control minion movment at base
    base_z+=1;
  }
  if(at_base && base_z>=40){
    rope_appear = true;
  }
  
  if(rope_appear){    // Move Rope onec it appear
    pushMatrix();
    translate(-107.5,56-rope_height,10);
    rope();
    popMatrix();
  }
  
  if(rope_appear && rope_height<rope_height_limit){
    rope_height+=speed;
  }
  
  if(rope_height>=rope_height_limit){
    at_base=false;
    at_top=true;
    rope_appear=false;
  }
  
  this.time +=0.02;
  this.frame_count++;
  println(frame_count);
}