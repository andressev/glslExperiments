precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
#define PI 3.14159265359

float plot(vec2 st, float dist){
    return smoothstep(dist-0.6, dist, st.y)-smoothstep(dist, dist+1.9, st.y);
}

void main(){
    
    vec2 st= gl_FragCoord.xy/u_resolution.xy;
   
    float x= sin(u_time*st.x*st.x)*.1;
    // float a= 50.0*PI;
    float c= 0.5;
    float b= sin(length(st-vec2(c))*100.)*PI;

    float pt=plot(st,cos(st.x*a + st.y*b + c));
    float ft = plot(st,exp(st.x));
    float xt= plot(st, exp(-st.y*a));
    
    
    

    
    vec3 color=vec3(pt,0.1,.1);

    gl_FragColor=vec4(color,1);}