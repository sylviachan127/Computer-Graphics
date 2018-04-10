//card1.frag: fragment shader for the swiss cheese card.

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() { 
  vec4 diffuse_color = vec4 (0.0, 1.0, 1.0, 1.0);
  float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);
  gl_FragColor = vec4(diffuse * diffuse_color.rgb, 0.8);

    float gap = .16;
    
    for(float x = 0; x < 3; x++)	{
        for(float y = 0; y < 3; y++)	{
            float centerX = 2.1*gap*x + gap;
            float centerY = 2.1*gap*y + gap;
            float distanceX = centerX - vertTexCoord.x;
            float distanceY = centerY - vertTexCoord.y;
            float totalDistance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
            
            if(totalDistance < .11)	{
                gl_FragColor = vec4(diffuse * diffuse_color.rgb, 0);
            }
        }
    }
}
