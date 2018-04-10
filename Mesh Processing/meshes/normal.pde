void normalCal(){
  faceNormal = new ArrayList<Vertex>();
  vertexNormal = new ArrayList<Vertex>();
  ArrayList<Vertex> currentV = shape.v;
  ArrayList<Vertex> currentF = shape.verticeList;
  ArrayList<Vertex> normalOfFace;
  for(int i = 0 ; i<currentF.size(); i++){
    int cornerX = (int)currentF.get(i).x;
    int cornerY = (int)currentF.get(i).y;
    int cornerZ = (int)currentF.get(i).z;
    Face newF = new Face(shape.getVertexfromCorner(cornerX), shape.getVertexfromCorner(cornerY), shape.getVertexfromCorner(cornerZ));
    faceNormal.add(newF.normalFace());
  }
  for(int x = 0; x<currentV.size(); x++){
    normalOfFace = new ArrayList<Vertex>();
    int cornerNumber = shape.getCornerfromVertex(x);
    int startCN = cornerNumber;
    int startFace = startCN/3;
    int faceNumber = startFace;
    do{
      normalOfFace.add(faceNormal.get(faceNumber));
      cornerNumber = shape.conerSwing(cornerNumber);
      faceNumber = cornerNumber/3;
      
      //Vertex currentCornerVertex = shape.getVertexfromCorner(cornerNumber); // vertex of corner 9
      //Vertex c_n = shape.getVertexfromCorner(shape.nextCorner(cornerNumber));
      //Vertex c_n_n = shape.getVertexfromCorner(shape.prevCorner(cornerNumber));  
      //  Face currentFace = new Face(currentCornerVertex, c_n, c_n_n);
      //  centerOfFace.add(currentFace.center());
      //  cornerNumber = shape.conerSwing(cornerNumber);
    }while(faceNumber!=startFace);
    vertexNormal.add(centerOfFaces(normalOfFace));
  }
}