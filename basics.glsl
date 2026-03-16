precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
#define PI 3.14159265359

float plot(vec2 st, float value){
    return smoothstep(value-0.02, value, st.y)-smoothstep(value, value+0.01, st.y);
}

void main(){
    
    vec2 st= gl_FragCoord.xy/u_resolution.xy;

    float value= cos(st.x*10.+u_time)*0.5+0.5;
    
    float pct= plot(st, value);


    
    vec3 color= vec3(value);
    color= color*(1.-pct)+pct*vec3(0.2392, 0.7059, 0.2784);

    gl_FragColor=vec4(color,1);
}