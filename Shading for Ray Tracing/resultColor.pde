Color resultColor(Color c,Ray eyeRay, Object hitObject, Vector p){
  float sumRed = c.r;
  float sumGreen = c.g;
  float sumBlue = c.b;
  Vector normal = hitObject.objectNormal(p);
  float kR = hitObject.krelf;
  if(kR>0){
    Object closet_o = null;
    Vector reflect_p = null;
    Vector normD = eyeRay.direction.normalizeVector();
    Vector reflectDirection = normal.muliptly(2*(normal.dotProduct(normD))).subVector(normD).muliptly(-1);
    Ray reflect = new Ray(reflectDirection,p);
    boolean distanceSmall = false;
    for(Object os: objectArray){
      if(hitObject != os){
        Vector tempP = os.hit(reflect);
        if(tempP != null){
          if(reflect_p == null || (tempP.distance(reflectDirection)<reflect_p.distance(reflectDirection))){
            closet_o = os;
            reflect_p = tempP;
          }
        }
      }
    }
    if(closet_o == null){
      sumRed+=kR*background_r;
      sumGreen+=kR*background_g;
      sumBlue+=kR*background_b;  
    }
    else{
      Color reflectColor = resultColor(new Color(sumRed,sumGreen,sumBlue), reflect, closet_o, reflect_p);
      sumRed+=reflectColor.r*kR;
      sumGreen+=reflectColor.g*kR;
      sumBlue+=reflectColor.b*kR;     
    }
  }

  for(Light l: lightArray){
   Ray l_ray = new Ray(l.position.subVector(p),p);
   Vector normL = l_ray.direction.normalizeVector();
   Vector origin = new Vector(0,0,0);
   Ray v = new Ray(origin.subVector(p),p);
   Vector normV = v.direction.normalizeVector();
   //Vector h = (v.direction).addVector(l.direction);
   Vector h = normV.addVector(normL);
   Vector normH = h.normalizeVector();float maxValueH = Math.max(0,normal.dotProduct(normH));  // max(0,N dot H)
   float maxValue = Math.max(0,normal.dotProduct(normL));  // max(0,N dot Li)
   float maxValueHP = (float)Math.pow(maxValueH,hitObject.power);
   Color kD = new Color(hitObject.diffuseRR, hitObject.diffuseGG, hitObject.diffuseBB);
   Color kS = new Color(hitObject.specularRR, hitObject.specularGG, hitObject.specularBB);
   Vector colorNkD = new Vector(kD.r, kD.g, kD.b);
   Vector colorNSD = new Vector(kS.r, kS.g, kS.b);
   Vector colorLight = new Vector(l.r, l.g, l.b);
   Vector lightColor = colorNkD.multiplyV(colorLight).muliptly(maxValue);
   Vector specColor = colorNSD.multiplyV(colorLight).muliptly(maxValueHP);
   boolean hitShadow = false;
    for(Object o: objectArray){
     Ray shadowRay = new Ray(l.position.subVector(p),p);
       Vector hit = o.hit(shadowRay);
       if(hit!=null){
           if(hit.distance(shadowRay.origin)<p.distance(eyeRay.origin)){
             hitShadow = true;
           }
         }
      }
      if(!hitShadow){
             sumRed+=lightColor.x + specColor.x;
             sumGreen+=lightColor.y + specColor.y;
             sumBlue+=lightColor.z + specColor.z;
      }
  }
  sumRed+=hitObject.ambientRR*lightR;
  sumGreen+=hitObject.ambientGG*lightG;
  sumBlue+=hitObject.ambientBB*lightB;
  
  Color resultColor = new Color(sumRed, sumGreen, sumBlue);
  return resultColor;
}