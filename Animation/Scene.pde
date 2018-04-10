float ladder_radius = 1;
float ladder_height = 100;
int ladder_sides = 32;
float ladder_waves = 0;
//float rope_height = -110; 

void base_cube(){
  fill(255,0,0);
  scale(1,0.1,1);
  box(80);
}

void rope(){
  fill(255,255,0);
  //translate(-7.5,this.rope_height,30);
  cylinder(this.ladder_radius, this.ladder_height, this.ladder_sides, this.ladder_waves);

}

void ladder(){
  fill(255,255,0);
  translate(-10,rope_height,38);
  cylinder(this.ladder_radius, this.ladder_height, this.ladder_sides, this.ladder_waves);
  translate(20,0,0);
  cylinder(this.ladder_radius, this.ladder_height, this.ladder_sides, this.ladder_waves);
  
  // make cylinder in the middle
  fill(0,0,255);
  rotate(PI/2);
  //rotateY(PI/2);
  //rotateZ(PI/2);
  //translate(-10,50,40);
  translate(170,0,0);
  cylinder(this.ladder_radius, 20, this.ladder_sides, this.ladder_waves);
}

void sand(){
  fill(232,206,144);
  scale(1,0.1,1);
  translate(0,500,0);
  box(500);
  //translate(0,-4250,140);
  //box(90); 
}

void pyramid(float time){
  rotate (time, 0.0, 1.0, 0.0);
  fill(208,217,46);
  noStroke();
  rotateX(PI/2);
  rotateZ(-PI/6);
  beginShape();
  vertex(-100, -100, -100);
  vertex( 100, -100, -100);
  vertex(   0,    0,  100);
  endShape(CLOSE);
  beginShape();
  vertex( 100, -100, -100);
  vertex( 100,  100, -100);
  vertex(   0,    0,  100);
  endShape(CLOSE);
  beginShape();
  vertex( 100, 100, -100);
  vertex(-100, 100, -100);
  vertex(   0,   0,  100);
  endShape(CLOSE);
  beginShape();
  vertex(-100,  100, -100);
  vertex(-100, -100, -100);
  vertex(   0,    0,  100);
  endShape(CLOSE);
  beginShape();
  vertex(-100, -100, -100);
  vertex( 100, -100, -100);
  vertex( 100,  100, -100);
  vertex(-100, 100, -100);
  endShape(CLOSE);
  
}

void prize(float time, float r, float g, float b){
  fill(r,g,b);
  rotate(time,0,1,0);
  sphere(5);
}