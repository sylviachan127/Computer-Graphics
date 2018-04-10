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
          hitYet = true;
          hitObject = o;
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
        Color resultC = resultColor(new Color(sumR,sumG,sumB), eyeRay, hitObject, p);
        fillPixel(resultC.r,resultC.g,resultC.b,x,height-y);
      }
      
    }
  }
}