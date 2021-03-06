// Yuen Han Chan

class Ray{
  Vector direction, origin;
  
  Ray(Vector d, Vector o){
    this.direction = d;
    this.origin = o;
  }
  
  Vector getPoint(float t){
    float x = origin.x + (direction.x*t);
    float y = origin.y + (direction.y*t);
    float z = origin.z + (direction.z*t);
    Vector pt = new Vector(x,y,z);
    return pt;
  }
}

class Vector{
  float x,y,z;
  
  Vector(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  Vector normalizeVector(){
    float x = this.x/this.mangitute();
    float y = this.y/this.mangitute();
    float z = this.z/this.mangitute();
    return new Vector(x,y,z);
  }
  
  Vector muliptly(float f){
    float x = this.x*f;
    float y = this.y*f;
    float z = this.z*f;
    return new Vector(x,y,z);
  }
  
  Vector multiplyV(Vector v2){
    float x = this.x*v2.x;
    float y = this.y*v2.y;
    float z = this.z*v2.z;
    return new Vector(x,y,z);
  }
  
  Vector addVector(Vector v1, Vector v2){
    float x = v1.x + v2.x;
    float y = v1.y + v2.y;
    float z = v1.z + v2.z;
    return new Vector(x,y,z);
  }
  
  Vector subVector(Vector v2){
    float x = this.x - v2.x;
    float y = this.y - v2.y;
    float z = this.z - v2.z;
    return new Vector(x,y,z);
  }

  Vector dividVectorF(float v2){
    float x = this.x / v2;
    float y = this.y / v2;
    float z = this.z / v2;
    return new Vector(x,y,z);
  }
  
  float distance(Vector v){
    return (float)Math.sqrt( (v.x - x)*(v.x - x) + (v.y - y)*(v.y - y) + (v.z - z)*(v.z - z) );
  }
  
  float dotProduct(Vector v1){
    float x = v1.x * this.x;
    float y = v1.y * this.y;
    float z = v1.z * this.z;
    return x+y+z;
  }
  Vector subfloat(Vector v, float f){
    float x = v.x-f;
    float y = v.y-f;
    float z = v.z-f;
    return new Vector(x,y,z);
  }
  float mangitute(){
    return (float)Math.sqrt(Math.abs(this.x*this.x)+Math.abs(this.y*this.y)+Math.abs(this.z*this.z));
  }
}

abstract class Object{
    abstract Vector hit(Ray r);
    abstract Vector sphereNormal(Vector p);
    Color diffuse;
    float cdrr, cdgg, cdbb;
    float whyaa,whybb,whycc;
}



void fillPixel(float r, float g, float b, float x, float y){
  fill(r,g,b);
  rect(x,y,1,1);
}

class Light{
  Vector position;
  float r, g, b;
  Color lightColor;
  Light(float x, float y, float z, float r, float g, float b){
    this.position = new Vector(x,y,z);
    this.lightColor = new Color(r,g,b);
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  // kD is the diffuse coeffiient
  Color pixelColor(Color kD, Vector n, Vector p){
    Ray l = new Ray(position.subVector(p),p);
    Vector normL = l.direction.normalizeVector();
    Vector origin = new Vector(0,0,0);
    Ray v = new Ray(origin.subVector(p),p);
    float maxValue = Math.max(0,n.dotProduct(normL));  // max(0,N dot Li)
    Vector colorNkD = new Vector(kD.r, kD.g, kD.b);
    Vector colorLight = new Vector(lightColor.r, lightColor.g, lightColor.b);
    Vector lightColor = colorNkD.multiplyV(colorLight).muliptly(maxValue);
    return new Color(lightColor.x, lightColor.y, lightColor.z);
  }
}

class Color{
  float r, g, b; 
  Color(float r, float g, float b){
    this.r = r;
    this.g = g;
    this.b = b;  
  }
}