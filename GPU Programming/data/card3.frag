//card3.frag fragment shader for the duck card

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

// Set in Processing
uniform sampler2D texture;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;


void main() {
    vec4 diffuse_color = texture2D(texture, vertTexCoord.xy);
    float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);
    
    // Laplacian filter to estimate the "edge-ness" of a pixel.
    // Takes the values of the four surrounding pixels, sums them, and subtracts four times the value of the middle pixel.
    float pixelS = 0.025;
    vec4 up = texture2D(texture, vec2(vertTexCoord.x, vertTexCoord.y - pixelS));
    vec4 down = texture2D(texture, vec2(vertTexCoord.x, vertTexCoord.y + pixelS));
    vec4 left = texture2D(texture, vec2(vertTexCoord.x - pixelS, vertTexCoord.y));
    vec4 right = texture2D(texture, vec2(vertTexCoord.x + pixelS, vertTexCoord.y));
    
    float up_grey = up.r*0.3 + up.g*0.6 + up.b*0.1;
    float down_grey = down.r*0.3 + down.g*0.6 + down.b*0.1;
    float left_grey = left.r*0.3 + left.g*0.6 + left.b*0.1;
    float right_grey = right.r*0.3 + right.g*0.6 + right.b*0.1;
    float center_grey = diffuse_color.r*0.3 + diffuse_color.g*0.6 + diffuse_color.b*0.1;
    
    float lapValue_grey = (up_grey+down_grey+left_grey+right_grey)-(4*center_grey);
    vec4 finalC = vec4(lapValue_grey);
    gl_FragColor = vec4(diffuse * finalC.rgb, 1.0);
}
