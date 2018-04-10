class Vertex{
  float x, y, z;
  
  Vertex(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  Vertex subV(Vertex b){
    return new Vertex(this.x-b.x,this.y-b.y,this.z-b.z);
  }
  
  Vertex crossProduct(Vertex b){
    return new Vertex(this.y*b.z-this.z*b.y, this.z*b.x-this.x*b.z, this.x*b.y -this.y*b.x);
  }
  
  Vertex normalizeV(){
    float u = unitV();
    return new Vertex(this.x/u, this.y/u, this.z/u);
  }
  
  float unitV(){
    return (this.x*this.x + this.y*this.y + this.z*this.z);
  }
  
  Vertex addV(Vertex b){
    return new Vertex(this.x+b.x, this.y+b.y, this.z+b.z);
  }
  
  Vertex dividV(float b){
    return new Vertex(this.x/b, this.y/b, this.z/b);
  }
  
  Vertex getV(){
    return new Vertex(x,y,z);
  }
  
  boolean isSame(Vertex b){
    float difference = 0.001;
    boolean xx_same = ((this.x+difference)>b.x)&&(b.x>(this.x-difference));
    boolean yy_same = ((this.y+difference)>b.y)&&(b.y>(this.y-difference));
    boolean zz_same = ((this.z+difference)>b.z)&&(b.z>(this.z-difference));
    return xx_same&&yy_same&&zz_same;
  }
  
}

class Face{
  int x, y, z;
  Vertex a,b,c;
  
  Face(int x, int y, int z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  Face(Vertex a, Vertex b, Vertex c){
    this.a = a;
    this.b = b;
    this.c = c;
  }
  
  Vertex center(){
    return new Vertex(((a.x+b.x+c.x)/3), ((a.y+b.y+c.y)/3) , ((a.z+b.z+c.z)/3));
  }
  
  Vertex normalFace(){
    Vertex V = this.b.subV(this.a);
    Vertex W = this.c.subV(this.a);
    Vertex temp = V.crossProduct(W);
    return temp;
    //float Nx = (V.y*W.z)-(V.z*W.y);
    //float Ny = (V.z*W.x)-(V.x*W.z);
    //float Nz = (V.x*W.y)-(V.y*W.x);
    //return new Vertex(Nx,Ny,Nz);
    //float sum = Math.abs(Nx)+Math.abs(Ny)+Math.abs(Nz);
    //float NewX = Nx/sum;
    //float NewY = Ny/sum;
    //float NewZ = Nz/sum;
    //return new Vertex(NewX,NewY,NewZ);
  }
}