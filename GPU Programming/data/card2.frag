//card2.frag: fragment shader for the mandelbrot card
//Yuen Han Chan

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
    vec4 diffuse_color = vec4 (1.0, 0.0, 0.0, 1.0);
    float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);
    
    vec2 zz = vec2(0,0);
    vec2 newZ = vec2(0,0);
    vec2 c = vec2(((vertTexCoord.x * 3.0) - 2.1),((vertTexCoord.y * 3.0) - 1.5));
    
    int x = 0;
    while(x<20){
        
        zz = newZ;
        
        newZ.x = (zz.x * zz.x) - (zz.y * zz.y) + c.x;
        newZ.y = 2 * zz.x * zz.y + c.y;
        
        if(((newZ.x*newZ.x)+(newZ.y*newZ.y)) > 4)	{
            gl_FragColor = vec4(diffuse * diffuse_color.rgb, 1.0);
            return;
        }
        x++;
    }
    vec4 diffuse_color2 = vec4 (3.0, 3.0, 10.0, 1.0);
    gl_FragColor = vec4(diffuse * diffuse_color2.rgb, 1.0);
}