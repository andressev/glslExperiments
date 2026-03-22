precision mediump float; 

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;


//funciones complejas
vec2 zetSquare(vec2 z){
    return vec2(z.x*z.x-z.y*z.y, 2.0*z.x*z.y);
}

vec2 oneOverZ(vec2 z){
    float len= length(z);
    return vec2(z.x/len/len, -z.y/len/len);
}
vec2 cMul(vec2 a, vec2 b){
    return vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x);
}


void main(){
    vec2 p=  (2.0*gl_FragCoord.xy - u_resolution) / min(u_resolution.x, u_resolution.y);
    
    //normalized mouse
    vec2 mouse= (2.0*u_mouse - u_mouse) / min(u_resolution.x, u_resolution.y);
    
    


    gl_FragColor=vec4(p,mouse.x,1.0);
}

