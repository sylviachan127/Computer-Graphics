float[] coord = new float[2];
float[][] coord1 = new float[2][2];
float[][] coord2 = new float[4][2];
float[][] coord3 = new float[8][2];
float[][] coord4 = new float[16][2];
float[][] coord5 = new float[32][2];
float[][] coord6 = new float[64][2];
float[][] coord7 = new float[128][2];
float[][] coord8 = new float[256][2];
float[][] coord9 = new float[512][2];
float[][] coord10 = new float[1024][2];
void setup()
{
  size(500,500);
  coord1[0][0] = 1;
  coord1[0][1] = 0;
  coord1[1][0] = -1;
  coord1[1][1] = 0;
}

void draw(){
  background(216,165,230);
  noStroke();
  fill(252,93,168);
  float convert = (500/6);
  float converty = -(500/6);
  float valueadd = 3.0;
  float a = (mouseX-250)*(3.0/250.0);
  float b = (mouseY-250)*(3.0/250.0)*-1;
  //float a = 0.312;
  //float b = 0.576;
  float radius = 8.0;
  //float a = 0.664;
  //float b = 0.336;
  println(b);
  if(a>0 && b>0){
    fill(171,221,237);
    radius = 5.0;
  }
  if(a<0 && b<0){
    fill(0,0,255);
    radius = 6.0;
  }
  if(a<0 && b>0){
    fill(221,242,189);
    radius = 9.0;
  }
 
 
  //zero
  ellipse((0+valueadd)*convert, (0+valueadd)*convert, radius,radius); 
  
  // first one
  for(int i=0; i<coord1.length; i++){
   ellipse((coord1[i][0]+valueadd)*convert, (coord1[i][1]+valueadd)*convert, radius,radius);
  }
  
  // second one retry 
  coord2 = newCoord(coord1, a, -b);
  for(int i=0; i<coord2.length; i++){
   ellipse((coord2[i][0]+valueadd)*convert, (coord2[i][1]+valueadd)*convert, radius,radius);
  } 
  
  // third one retry
  float[] coord3cal = vMultiple(a,-b,a,-b);
  coord3 = newCoord(coord2, coord3cal[0],coord3cal[1]);
  for(int i=0; i<coord3.length; i++){
   ellipse((coord3[i][0]+valueadd)*convert, (coord3[i][1]+valueadd)*convert, radius,radius);
  }
  
  // forth one retry
  float[] coord4cal = vMultiple(coord3cal[0],coord3cal[1],a,-b);
  coord4 = newCoord(coord3, coord4cal[0], coord4cal[1]);
  for(int i=0; i<coord4.length; i++){
   ellipse((coord4[i][0]+valueadd)*convert, (coord4[i][1]+valueadd)*convert, radius,radius);
  }  
  
  // fifth one
  float[] coord5cal = vMultiple(coord4cal[0],coord4cal[1],a,-b);
  coord5 = newCoord(coord4, coord5cal[0], coord5cal[1]);
  for(int i=0; i<coord5.length; i++){
   ellipse((coord5[i][0]+valueadd)*convert, (coord5[i][1]+valueadd)*convert, radius,radius);
  }    
  
  // sixth one
  float[] coord6cal = vMultiple(coord5cal[0],coord5cal[1],a,-b);
  coord6 = newCoord(coord5, coord6cal[0], coord6cal[1]);
  for(int i=0; i<coord6.length; i++){
   ellipse((coord6[i][0]+valueadd)*convert, (coord6[i][1]+valueadd)*convert, radius,radius);
  }   
  
  // 7th one
  float[] coord7cal = vMultiple(coord6cal[0],coord6cal[1],a,-b);
  coord7 = newCoord(coord6, coord7cal[0], coord7cal[1]);
  for(int i=0; i<coord7.length; i++){
   ellipse((coord7[i][0]+valueadd)*convert, (coord7[i][1]+valueadd)*convert, radius,radius);
  }   

  // 8th one
  float[] coord8cal = vMultiple(coord7cal[0],coord7cal[1],a,-b);
  coord8 = newCoord(coord7, coord8cal[0], coord8cal[1]);
  for(int i=0; i<coord8.length; i++){
   ellipse((coord8[i][0]+valueadd)*convert, (coord8[i][1]+valueadd)*convert, radius,radius);
  }   

  // 9th one
  float[] coord9cal = vMultiple(coord8cal[0],coord8cal[1],a,-b);
  coord5 = newCoord(coord8, coord9cal[0], coord9cal[1]);
  for(int i=0; i<coord9.length; i++){
   ellipse((coord9[i][0]+valueadd)*convert, (coord9[i][1]+valueadd)*convert, radius,radius);
  }   
  
  // 10th one
  float[] coord10cal = vMultiple(coord9cal[0],coord9cal[1],a,-b);
  coord10 = newCoord(coord9, coord10cal[0], coord10cal[1]);
  for(int i=0; i<coord10.length; i++){
   ellipse((coord10[i][0]+valueadd)*convert, (coord10[i][1]+valueadd)*convert, radius,radius);
  }   
  //print(coord2[0][0]);
  //print(coord2cal[0]);
  //println(a);
  
  //ellipse((1+2)*convert, (0+2)*convert, 5.0, 5.0); // second one
  //int power = 2*2*2;
  //int[] result1 = vMultiple(a,b,a,b);
  //println(coord1[0][0]);
  //println(coord1.length);
  //ellipse((result1[0]+2)*convert,(result1[1]+2)*convert, 5.0, 5.0);
  
}

float[] vMultiple(float a, float b, float c, float d){
 coord[0] = ((a*c)-(b*d));
 coord[1] = ((a*d)+(b*c));
 return coord;
}

float[][] newCoord(float[][] oldCoord, float a, float b){
 int oldLength = oldCoord.length;
 int newLength = oldLength*2;
 float[][] returnCoord = new float[newLength][2];
 for(int i=0; i<oldLength; i++){
     returnCoord[i][0] = oldCoord[i][0] + a;
     returnCoord[i+oldLength][0] = oldCoord[i][0] - a;
     returnCoord[i][1] = oldCoord[i][1] + b;
     returnCoord[i+oldLength][1] = oldCoord[i][1] - b;
 }
 return returnCoord;
}