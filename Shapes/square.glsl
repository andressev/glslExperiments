precision mediump float;

uniform vec2 u_resolution;
#define PI 3.14159265359

float plot(vec2 st, float value){
    return smoothstep(value-0.02, value, st.y)-smoothstep(value, value+0.01, st.y);
}
float square(float corner, vec2 st){
    vec2 bottomLeft= step(vec2(corner), st);
    vec2 topRight= step(vec2(corner), 1.0-st);
    float pct=bottomLeft.x*bottomLeft.y*topRight.x*topRight.y;
    return pct;
}

void main(){
    
    vec2 st= gl_FragCoord.xy/u_resolution.xy;
    st*=2.0;
    // st.x/=u_resolution.x*u_resolution.y;

    
    float pct=square(0.1, st);
    vec3 color= vec3(pct);

    float pct1=square(0.1, vec2(st.x-.9, st.y));
    color+= vec3(pct1);

    //Second square
    float pct2=square(0.25,st-.9);
    color+=vec3(pct2, pct2, 0.);

    
    float pct3=square(0.25, vec2(st.x+0.2, st.y-.9));
    color+=vec3(pct3, 0., 0.);

    float pct4=square(0.25, vec2(st.x-0.35, st.y-.9));
    color+=vec3(pct4, 0.,0.);


    gl_FragColor=vec4(color,1);
}