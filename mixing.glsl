precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
#define PI 3.14159265359

float plot(vec2 st, float value){
    return smoothstep(value-0.02, value, st.y)-smoothstep(value, value+0.01, st.y);
}
// mat2 rot2d()

void main(){
    
    vec2 st= gl_FragCoord.xy/u_resolution.xy;
    st*=1.;

    vec3 value;


    //we assign a function of the screen coordinates for each color
    value.r= smoothstep(-0.1,.7,st.x)-smoothstep(0.5,0., st.y+0.1);
    value.g=-pow(st.x,7.)+0.3+smoothstep(0.7,1.,st.x);
    value.b= smoothstep(0.9,0.3,st.x);
    
    value.r=mix(0.,value.r, sin(u_time*0.3)*0.3+0.9);
    //Mixing with sun values
    vec3 colorA= value;
    vec3 colorB= vec3(0.9843, 1.0, 0.0)*sin(u_time*0.3)+2.;
    
    float distToSun=smoothstep(0.15,.0,length(st-vec2(0.9,sin(u_time*0.3)*0.3+0.5)));



    vec3 color;
    color= mix(colorA, colorB, distToSun);
    
    
    //mixing patterns thorugh the screen for rgb
    // color= mix(color, vec3(1.0,0.,0.), plot(st, value.r));
    // color = mix(color,vec3(0.0,1.0,0.0),plot(st,value.g));
    // color = mix(color,vec3(0.3647, 0.3647, 0.7255),plot(st,value.b));

    // color= mix(colorA, colorB, 1.0-pct);
    // color= color*(1.-pct)+pct*vec3(0.2392, 0.7059, 0.2784);
    


    gl_FragColor=vec4(color,1);
}