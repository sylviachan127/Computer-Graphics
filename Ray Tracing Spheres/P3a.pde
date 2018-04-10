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
      whyA = get_float(token[1]);
      whyB =get_float(token[2]);
      whyC =get_float(token[3]);
      cdr =get_float(token[1]);
      cdg =get_float(token[2]);
      cdb =get_float(token[3]);
      float Car =get_float(token[4]);
      float Cag =get_float(token[5]);
      float Cab =get_float(token[6]);
      float Csr =get_float(token[7]);
      float Csg =get_float(token[8]);
      float Csb =get_float(token[9]);
      float P =get_float(token[10]);
      float K =get_float(token[11]);
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

    }
    else if (token[0].equals("vertex")) {
      float x =get_float(token[1]);
      float y =get_float(token[2]);
      float z =get_float(token[3]);
    }
    else if (token[0].equals("end")) {

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

// This is where you should put your code for creating
// eye rays and tracing them.
void draw_scene() {
  
  float k = (float)Math.tan(Math.toRadians(fov/2.0));
  
  //For each pixel
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      boolean hitYet = false;
      // Convert from screen coordinate -> view plane coordinate
      float newX = ((x-(width/2))*((2*k)/width));
      float newY = ((y-(height/2))*((2*k)/height));
      // 1. create and cast an eye ray
      Vector origin = new Vector(0,0,0);
      // (x', y', -1) = p 
      // p = pt on View Plane
      Ray eyeRay = new Ray(new Vector(newX, newY, -1), origin); 
      // 2. find 1st object hit by ray and surface normal n
      Object hitObject = null;
      Vector p = null;
      for(Object o: objectArray){
        Vector hit = o.hit(eyeRay);
        if(hit!=null){
          if(p==null || hit.distance(origin) < p.distance(origin)){
          //Color diffuse = new Color(cdr, cdg, cdb);
          hitYet = true;
          hitObject = o;
          //hitObject.diffuse = diffuse;
          p = hit;
          }
        }
      }
      
      // 3. set pixel color to value computed from hit point, light, and n
      if(!hitYet){
        fillPixel(background_r, background_g, background_b,x,height-y);
      }
      else{
        float sumR = 0;
        float sumG = 0;
        float sumB = 0;
        //Color pixelC = new Color
        for(Light l: lightArray){
          Color cc = new Color(hitObject.whyaa, hitObject.whybb, hitObject.whycc);
          Color c = l.pixelColor(cc, hitObject.sphereNormal(p), p);
          sumR+=c.r;
          sumG+=c.g;
          sumB+=c.b;
        }
        fillPixel(sumR,sumG,sumB,x,height-y);
      }
    }
  }
}

void draw() {
  // nothing should be placed here for this project
}

ArrayList<Object> objectArray;
ArrayList<Light> lightArray;
float cdr, cdg, cdb;
float fov, background_r, background_g, background_b;
float whyA, whyB, whyC;

class Sphere extends Object{
  float r,x,y,z;
  Vector c;
  Color diffuse;
  float cdrr,cdgg,cdbb;
  Sphere(float r, float x, float y, float z){
    this.r = r;
    this.x = x;
    this.y = y;
    this.z = z;
    this.c = new Vector(x,y,z);
    diffuse = new Color(cdr, cdg, cdb);
    cdrr = cdr;
    cdgg = cdg;
    cdbb = cdb;
    whyaa = whyA;
    whybb = whyB;
    whycc = whyC;
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
  
  Vector sphereNormal(Vector p){
    return (p.subVector(c)).dividVectorF((p.subVector(c)).mangitute());
  }
}