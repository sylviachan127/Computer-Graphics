// Sample code for starting the meshes project
// Yuen Han Chan

import processing.opengl.*;
int num_vertices,num_faces;
ArrayList<Vertex> vertices;
ArrayList<Vertex> faces;
ArrayList<Vertex> faceNormal;
ArrayList<Vertex> vertexNormal;
int[] verticesCount;
Shape shape;
ArrayList<Integer>[] cornerLookup;

int seedCount = 1;

boolean smoothShade = false;
boolean smoothCalc = false;
boolean white = false;
boolean randomC = false;

float time = 0;  // keep track of passing of time (for automatic rotation)
boolean rotate_flag = true;       // automatic rotation of model?

// initialize stuff
void setup() {
  size(400, 400, OPENGL);  // must use OPENGL here !!!
  noStroke();     // do not draw the edges of polygons
}

// Draw the scene
void draw() {
  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(0);  // clear the screen to black
  
  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);
  
  // place the camera in the scene (just like gluLookAt())
  camera (0.0, 0.0, 5.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  
  scale (1.0, -1.0, 1.0);  // change to right-handed coordinate system
  
  // create an ambient light source
  ambientLight(102, 102, 102);
  
  // create two directional light sources
  lightSpecular(204, 204, 204);
  directionalLight(102, 102, 102, -0.7, -0.7, -1);
  directionalLight(152, 152, 152, 0, 0, -1);
  
  pushMatrix();

  fill(50, 50, 200);            // set polygon color to blue
  if(white){
    fill(255, 255, 255);
  }
  ambient (200, 200, 200);
  specular(0, 0, 0);
  shininess(1.0);
  
  rotate (time, 1.0, 0.0, 0.0);
  
  // THIS IS WHERE YOU SHOULD DRAW THE MESH
  randomSeed(seedCount);
  if((faces!=null) && (vertices!=null)){
    for(int i=0;i<faces.size();i++){
        if(randomC){
          fill(random(0,255),random(0,255),random(0,255));
        }
        int face1 = (int)faces.get(i).x;
        int face2 = (int)faces.get(i).y;
        int face3 = (int)faces.get(i).z;
        Vertex A = new Vertex(vertices.get(face1).x,vertices.get(face1).y,vertices.get(face1).z);
        Vertex B = new Vertex(vertices.get(face2).x,vertices.get(face2).y,vertices.get(face2).z);
        Vertex C = new Vertex(vertices.get(face3).x,vertices.get(face3).y,vertices.get(face3).z);
        // Calculate Smooth Shad
        Vertex N = ((B.subV(A)).crossProduct(C.subV(A)));
        Vertex normalizeN = N.normalizeV();
        if(!smoothShade){
          smoothCalc = false;
          beginShape();
            //normal(faceNormal.get(i).x, faceNormal.get(i).y, faceNormal.get(i).z);
            vertex(A.x,A.y,A.z);
            vertex(B.x,B.y,B.z);
            vertex(C.x,C.y,C.z);
          endShape(CLOSE);
        }
        if(smoothShade){
          beginShape();
            normal(vertexNormal.get(face1).x,vertexNormal.get(face1).y,vertexNormal.get(face1).z);
            vertex(A.x,A.y,A.z);
            normal(vertexNormal.get(face2).x,vertexNormal.get(face2).y,vertexNormal.get(face2).z);
            vertex(B.x,B.y,B.z);
            normal(vertexNormal.get(face3).x,vertexNormal.get(face3).y,vertexNormal.get(face3).z);
            vertex(C.x,C.y,C.z);
          endShape(CLOSE);
        }
    }
  }
  //endShape(CLOSE);
  popMatrix();
  
  // maybe step forward in time (for object rotation)
  if (rotate_flag )
    time += 0.02;
}

// Read polygon mesh from .ply file
//
// You should modify this routine to store all of the mesh data
// into a mesh data structure instead of printing it to the screen.

void read_mesh (String filename)
{
  println("\n\n"); // New shape
  vertices = new ArrayList<Vertex>();
  faces = new ArrayList<Vertex>();
  //faceNorm = new ArrayList<Vertex>();
  int i;
  String[] words;
  int[] corners;
  
  String lines[] = loadStrings(filename);
  
  words = split (lines[0], " ");
  num_vertices = int(words[1]);
  println ("number of vertices = " + num_vertices); 
  //vertexNormHelper = new Vertex[num_vertices];
  //vertexNorm = new Vertex[num_vertices];
  verticesCount = new int[num_vertices];
  for(int a=0;a<num_vertices;a++){
    //vertexNorm[a] = new Vertex(0,0,0);
    //vertexNormHelper[a] = new Vertex(0,0,0);
    verticesCount[a] = 0;
  }
  
  words = split (lines[1], " ");
  num_faces = int(words[1]);
  println ("number of faces = " + num_faces);
  corners = new int[num_faces*3];
  //faceNorm = new Vertex[num_faces];
  
  // read in the vertices
  for (i = 0; i < num_vertices; i++) {
    words = split (lines[i+2], " ");
    float x = float(words[0]);
    float y = float(words[1]);
    float z = float(words[2]);
    vertices.add(new Vertex(x,y,z));
    println ("vertex = " + vertices.get(i).x + " " + vertices.get(i).y + " " + vertices.get(i).z);
  }
  
  // read in the faces
  for (i = 0; i < num_faces; i++) {
    
    int j = i + num_vertices + 2;
    words = split (lines[j], " ");
    
    int nverts = int(words[0]);
    if (nverts != 3) {
      println ("error: this face is not a triangle.");
      exit();
    }
    
    int index1 = int(words[1]);
    int index2 = int(words[2]);
    int index3 = int(words[3]);
    faces.add(new Vertex(index1, index2, index3));
    corners[i*3] = index1;
    corners[i*3+1] = index2;
    corners[i*3+2] = index3;
    println ("face = " + faces.get(i).x + " " + faces.get(i).y + " " + faces.get(i).z);
  }
  shape = new Shape(vertices,faces,corners,num_vertices);
  print("corners = [ ");
  for(int ab = 0; ab<shape.c.length; ab++){
    print(shape.c[ab] + " ");
  }
  println("]");
  print("opposite = [ ");
  int[] oc = shape.oppositeCorner();
  for(int ab = 0; ab<oc.length; ab++){
    print(shape.oc[ab] + " ");
  }
  print("]");  
  cornerLookup = shape.cornerLookup;
  vertices = shape.v;
  faces = shape.verticeList;
  normalCal();
}

int vertexIndex(float x, float y, float z, ArrayList<Vertex> vl){
    for (int i = 0; i < vl.size(); i++) {
    Vertex v = vl.get(i);
    if (v.isSame(new Vertex(x,y,z))){
      return i;
    }
  }
  vl.add(new Vertex(x,y,z));
  return vl.size()-1;
}

Vertex centerOfFaces(ArrayList<Vertex> vl){
float xx =0;
float yy =0;
float zz =0;
float size = vl.size();
for(int i=0; i<vl.size(); i++){
  xx+=vl.get(i).x;
  yy+=vl.get(i).y;
  zz+=vl.get(i).z;
}
return new Vertex(xx/size,yy/size,zz/size);
}

void dual(){
ArrayList<Vertex> newVerticeList = new ArrayList<Vertex>();
ArrayList<Vertex> newVertex = new ArrayList<Vertex>();
ArrayList<Integer> newCorners = new ArrayList<Integer>();
Shape current = shape;
//ArrayList<Vertex> verticeList = current.verticeList;
ArrayList<Vertex> v = current.v;
//ArrayList<Integer>[] corner_lookup = cornerLookup;
//Vertex[] fc = new Vertex[verticeList.size()];
//println("total vertex size:: " + v.size());
for(int ii = 0; ii<v.size(); ii++){
  ArrayList<Vertex> centerOfFace = new ArrayList<Vertex>();
  //print("corner number: ");
  int cornerNumber = shape.getCornerfromVertex(ii);
  int startCN = cornerNumber;
  int startFace = startCN/3;
  do{
    Vertex currentCornerVertex = shape.getVertexfromCorner(cornerNumber); // vertex of corner 9
    Vertex c_n = shape.getVertexfromCorner(shape.nextCorner(cornerNumber));
    Vertex c_n_n = shape.getVertexfromCorner(shape.prevCorner(cornerNumber));  
      Face currentFace = new Face(currentCornerVertex, c_n, c_n_n);
      centerOfFace.add(currentFace.center());
      cornerNumber = shape.conerSwing(cornerNumber);
  }while((cornerNumber/3)!=startFace);
  println();
  Vertex facesCenter = centerOfFaces(centerOfFace);  // center of all the faces around a Vertex
  for(int a = 0 ; a<centerOfFace.size();a++){
    int offset = (a+1)%centerOfFace.size();
    newCorners.add(vertexIndex(facesCenter.x, facesCenter.y, facesCenter.z, newVertex));
    newCorners.add(vertexIndex(centerOfFace.get(a).x, centerOfFace.get(a).y, centerOfFace.get(a).z, newVertex));
    newCorners.add(vertexIndex(centerOfFace.get(offset).x, centerOfFace.get(offset).y, centerOfFace.get(offset).z, newVertex));
  }
}
int[] newCornersList = new int[newCorners.size()];
for(int x = 0; x<newCorners.size(); x++){
  newCornersList[x] = newCorners.get(x);
}
for(int i =0; i<newCornersList.length; i+=3){
  int x = newCornersList[i];
  int y = newCornersList[i+1];
  int z = newCornersList[i+2];
  newVerticeList.add(new Vertex(x,y,z));
}
shape = new Shape(newVertex, newVerticeList, newCornersList, newVertex.size());
    
cornerLookup = shape.cornerLookup;
vertices = shape.v;
faces = shape.verticeList;
normalCal();
println("total Vertex number: " + vertices.size());
println("total Vertex Lookup number: " + faces.size());
println("vertice list: ");
 for (int a = 0; a<vertices.size(); a++){
  println(vertices.get(a).x + " " + vertices.get(a).y + " " + vertices.get(a).z);
 }
}