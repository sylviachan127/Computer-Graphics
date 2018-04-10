class Shape{
 int num_vertices;
 ArrayList<Vertex> v;
 ArrayList<Vertex> verticeList;
 ArrayList<Integer>[] cornerLookup;
 int[] c;
 int[] oc;
  
 Shape(ArrayList<Vertex> vertexs, ArrayList<Vertex> verticeList, int[] corners, int num_vertices){
   this.v = vertexs;
   this.verticeList = verticeList;
   this.c = corners;
   cornerLookup = (ArrayList<Integer>[])new ArrayList[num_vertices];
   for(int a = 0; a<num_vertices; a++){
     cornerLookup[a] = new ArrayList<Integer>();
   }
   oc = new int[c.length];
   oc = oppositeCorner();
   cornerLookup = adjList();
 }
  
 int getCornerfromVertex(int v_index){
   for(int i = 0; i<c.length; i++){
     if (c[i]==v_index){
       return i;
     }
   }
   return 0;
 }
 int getTriangle(int corner){
   return (corner/3);
 }
  
 Vertex getVertexfromCorner(int corner){
   return v.get(c[corner]);
 }
 
 int getFacefromCorner(int corner){
   return corner/3;
 }
 
 // Return the corner index, not vertices itself.
 int nextCorner(int corner){
   return((3*getTriangle(corner))+(corner+1)%3);
 }
  
 int prevCorner(int corner){
   int c_n = nextCorner(corner);
   return nextCorner(c_n);
 }
  
 int[] oppositeCorner(){
   for(int a = 0; a<c.length;a++){
     for(int b =0; b<c.length; b++){
       if(getVertexfromCorner(nextCorner(a)) == getVertexfromCorner(prevCorner(b))){
         if(getVertexfromCorner(prevCorner(a)) == getVertexfromCorner(nextCorner(b))){
           oc[a] = b;
           oc[b] = a;
         }
       }
     }
   }
   return oc;
 }

 int cornerRight(int corner){
   int c_n = nextCorner(corner);
   return oc[c_n];
 }
  
 int cornerLeft(int corner){
   int c_p = prevCorner(corner);
   return oc[c_p];
 }
  
  int conerSwing(int corner){
    return nextCorner(cornerRight(corner));
  }
  
  ArrayList<Integer>[] adjList(){
   for(int a = 0; a<c.length; a++){
     int verticeNum = c[a];  
     cornerLookup[verticeNum].add(a);
   }
   return cornerLookup;
 }
 
 Face verticeOfFace(int faceNum){
   int v1 = c[faceNum];    // return vertex num
   int v2 = c[faceNum+1];
   int v3 = c[faceNum+2];
   Vertex A = v.get(v1);
   Vertex B = v.get(v2);
   Vertex C = v.get(v3);
   return new Face(A,B,C);
 }
}