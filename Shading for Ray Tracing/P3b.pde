// Yuen Han Chan
// This is the starter code for the CS 3451 Ray Tracing project.
// The most important part of this code is the interpreter, which will
// help you parse the scene description (.cli) files.

// A global variable for holding current active file name.
// By default, the program reads in i0.cli, which draws a rectangle.
String gCurrentFile = new String("i0.cli");

void setup() {
  size(500, 500);  
  noStroke();
  colorMode(RGB, 1.0);
  background(0, 0, 0);
  interpreter();
}

void reset_scene() {
  //reset global scene variables
  objectArray = new ArrayList<Object>();
  lightArray = new ArrayList<Light>();
  background_r = 0;
  background_b = 0;
  background_g = 0;
  beginV = false;
  endV = false;
  tri = null;
}

void keyPressed() {
  reset_scene();
  switch(key) {
    case '1':  gCurrentFile = new String("i1.cli"); interpreter(); break;
    case '2':  gCurrentFile = new String("i2.cli"); interpreter(); break;
    case '3':  gCurrentFile = new String("i3.cli"); interpreter(); break;
    case '4':  gCurrentFile = new String("i4.cli"); interpreter(); break;
    case '5':  gCurrentFile = new String("i5.cli"); interpreter(); break;
    case '6':  gCurrentFile = new String("i6.cli"); interpreter(); break;
    case '7':  gCurrentFile = new String("i7.cli"); interpreter(); break;
    case '8':  gCurrentFile = new String("i8.cli"); interpreter(); break;
    case '9':  gCurrentFile = new String("i9.cli"); interpreter(); break;
    case '0':  gCurrentFile = new String("i10.cli"); interpreter(); break;
  }
}

float get_float(String str) { return float(str); }

// this routine helps parse the text in a scene description file
void interpreter() {
  println("Parsing '" + gCurrentFile + "'");
  String str[] = loadStrings(gCurrentFile);
  if (str == null) println("Error! Failed to read the file.");
  for (int i=0; i<str.length; i++) {
    
    String[] token = splitTokens(str[i], " "); // Get a line and parse tokens.
    if (token.length == 0) continue; // Skip blank line.
    
    if (token[0].equals("fov")) {
      this.fov = get_float(token[1]);
    }
    else if (token[0].equals("background")) {
      this.background_r =get_float(token[1]);
      this.background_g =get_float(token[2]);
      this.background_b =get_float(token[3]);
    }
    else if (token[0].equals("light")) {
      lightR =get_float(token[4]);
      lightG =get_float(token[5]);
      lightB =get_float(token[6]);
      float x =get_float(token[1]);
      float y =get_float(token[2]);
      float z =get_float(token[3]);
      float r =get_float(token[4]);
      float g =get_float(token[5]);
      float b =get_float(token[6]);
      Light l = new Light(x,y,z,r,g,b);
      lightArray.add(l);
    }
    else if (token[0].equals("surface")) {
      diffuseR = get_float(token[1]);
      diffuseG =get_float(token[2]);
      diffuseB =get_float(token[3]);
      ambientR =get_float(token[4]);
      ambientG =get_float(token[5]);
      ambientR =get_float(token[6]);
      specularR =get_float(token[7]);
      specularG =get_float(token[8]);
      specularB =get_float(token[9]);
      specularPower =get_float(token[10]); // how shiny
      reflectK =get_float(token[11]); // 0=no reflect, 1=mirror
    }    
    else if (token[0].equals("sphere")) {
      float r =get_float(token[1]);
      float x =get_float(token[2]);
      float y =get_float(token[3]);
      float z =get_float(token[4]);
      Sphere sphere = new Sphere(r,x,y,z);
      objectArray.add(sphere);
    }
    else if (token[0].equals("begin")) {
      beginV = true;
      tri = new Triangle(null,null,null);
    }
    else if (token[0].equals("vertex")) {
      float x =get_float(token[1]);
      float y =get_float(token[2]);
      float z =get_float(token[3]);
      Vector triangle = new Vector(x,y,z);
      if(tri.a==null){
        tri.a = triangle;
      }
      else if(tri.b==null){
        tri.b = triangle;
      }
      else if(tri.c==null){
        tri.c = triangle;
        objectArray.add(tri);
      }
      //if (beginV = true){
        
      //}
    }
    else if (token[0].equals("end")) {
      tri = new Triangle(null,null,null);
    }
    else if (token[0].equals("rect")) {   // this command demonstrates how the parser works
      float x =get_float(token[1]);       // and is not really part of the ray tracer
      float y =get_float(token[2]);
      float w =get_float(token[3]);
      float h =get_float(token[4]);
      fill (255, 255, 255);  // make the fill color white
      rect (x, y, w, h);     // draw a rectangle on the screne
    }
    else if (token[0].equals("write")) {
      draw_scene();   // this is where you actually perform the ray tracing
      println("Saving image to '" + token[1]+"'");
      save(token[1]); // this saves your ray traced scene to a PNG file
    }
  }
}

void draw() {
  // nothing should be placed here for this project
}

ArrayList<Object> objectArray;
ArrayList<Light> lightArray;
float fov, background_r, background_g, background_b;
float diffuseR, diffuseG, diffuseB;
float ambientR, ambientG, ambientB;
float specularR, specularG, specularB;
float specularPower;
float reflectK;
boolean beginV, endV;
float lightR, lightG, lightB;
Triangle tri; 

class Sphere extends Object{
  float r,x,y,z;
  Vector c;
  Color diffuse;
  Sphere(float r, float x, float y, float z){
    this.r = r;
    this.x = x;
    this.y = y;
    this.z = z;
    this.c = new Vector(x,y,z);
    diffuseRR = diffuseR;
    diffuseGG = diffuseG;
    diffuseBB = diffuseB;
    ambientRR = ambientR;
    ambientGG = ambientG;
    ambientBB = ambientB;
    specularRR = specularR;
    specularGG = specularG;
    specularBB = specularB;
    power = specularPower;
    krelf = reflectK;
  }
  
  Vector hit(Ray r){
    Vector d = r.direction;
    Vector e = r.origin;
    float rr = this.r*this.r;
    float aa = d.dotProduct(d);
    float bb = (d.muliptly(2)).dotProduct(e.subVector(this.c));
    float cc = (e.subVector(this.c)).dotProduct(e.subVector(this.c))-rr;
    float insideSqrt = (bb*bb)-(4*aa*cc);
    if(insideSqrt<0){
      return null;
    }
      float sqrtResult = (float)Math.sqrt(insideSqrt);
      float r1 = ((-1*bb)+sqrtResult)/(2*aa);
      float r2 = ((-1*bb)-sqrtResult)/(2*aa);
      float t = Math.min(r1,r2);
      if(t>=0){
        return r.getPoint(t);
      }
      else{
        return null;
      }
  }
  
  Vector objectNormal(Vector p){
    return (p.subVector(c)).dividVectorF((p.subVector(c)).mangitute());
  }
}

class Triangle extends Object{
  Color diffuse;
  Color ambient;
  Color specular;
  float power;
  float krelf;
  
  //float diffuseRR,diffuseGG,diffuseBB;
  //float ambientRR,ambientGG,ambientBB;
  //float specularRR,specularGG,specularBB;
  Vector a, b, c;
  
  Vector hit(Ray r){
    Vector d = r.direction;
    Vector e = r.origin;
    float A = a.x - b.x;
    float B = a.y - b.y;
    float C = a.z - b.z;
    float D = a.x - c.x;
    float E = a.y - c.y;
    float F = a.z - c.z;
    float G = d.x;
    float H = d.y;
    float I = d.z;
    float J = a.x - e.x;
    float K = a.y - e.y;
    float L = a.z - e.z;
    float M = ((A*((E*I)-(H*F)))+(B*((G*F)-(D*I)))+(C*((D*H)-(E*G))));
    float BB = ((J*((E*I)-(H*F)))+(K*((G*F)-(D*I)))+(L*((D*H)-(E*G))))/M;
    float YY = ((I*((A*K)-(J*B)))+(H*((J*C)-(A*L)))+(G*((B*L)-(K*C))))/M;
    float TT = ((-1)*((F*((A*K)-(J*B)))+(E*((J*C)-(A*L)))+(D*((B*L)-(K*C)))))/M;
    if((BB>0)&&(YY>0)&&((BB+YY)<1)){  // we have a hit
      return r.getPoint(TT); 
    }
    return null;
  }
  
  Vector objectNormal(Vector p){
    Vector normal = b.subVector(a).crossVector(c.subVector(a)).normalizeVector();
    Vector v = b.subVector(a);
    Vector w = c.subVector(a);
    float x = (v.y*w.z)-(v.z*w.y);
    float y = (v.z*w.x)-(v.x*w.z);
    float z = (v.x*w.y)-(v.y*w.x);
    return new Vector(x,y,z);
  }
  
  Triangle(Vector a, Vector b, Vector c){
    this.a = a;
    this.b = b;
    this.c = c;
    diffuseRR = diffuseR;
    diffuseGG = diffuseG;
    diffuseBB = diffuseB;
    ambientRR = ambientR;
    ambientGG = ambientG;
    ambientBB = ambientB;
    specularRR = specularR;
    specularGG = specularG;
    specularBB = specularB;
    power = specularPower;
    krelf = reflectK;
  }
}