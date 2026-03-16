precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_time;
#define PI 3.14159265359

float plot(vec2 st, float dist){
    return smoothstep(dist-0.02, dist, st.y)-smoothstep(dist, dist+0.01, st.y);
}


void main(){
    
    vec2 st= gl_FragCoord.xy/u_resolution.xy;
    float a= plot(st*st.x*sin(st.x+u_time), 0.1);
    vec3 color=vec3(st.x,a,sin(st.y));
    gl_FragColor=vec4(color,1);
}