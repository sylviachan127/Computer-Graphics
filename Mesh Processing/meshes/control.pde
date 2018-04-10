// handle keyboard input
void keyPressed() {
  if (key == '1') {
    read_mesh ("tetra.ply");
  }
  else if (key == '2') {
    read_mesh ("octa.ply");
  }
  else if (key == '3') {
    read_mesh ("icos.ply");
  }
  else if (key == '4') {
    read_mesh ("star.ply");
  }
  else if (key == '5') {
    read_mesh ("torus.ply");
  }
  else if (key == '6') {
    read_mesh ("try.ply");
  }  
  else if (key == ' ') {
    rotate_flag = !rotate_flag;          // rotate the model?
  }else if (key == 'n') {
    smoothShade = !smoothShade;
  }else if (key == 'r') {
    randomC = true;
    seedCount++;
  }else if (key == 'w') {
    white = !white;
    randomC = false;
    //color faces white
  }else if (key == 'd') {
    dual();
  }else if (key == 'q' || key == 'Q') {
    exit();                               // quit the program
  }
}