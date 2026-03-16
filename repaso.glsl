precision mediump float;

uniform vec2 u_resolution;
#define PI 3.14159265359

float plot(vec2 st,float value){
    return smoothstep(value-.02,value,st.y)-smoothstep(value,value+.01,st.y);
}

void main(){
    vec2 st=gl_FragCoord.xy;
    st/=u_resolution.xy;
    
    float redPCT=smoothstep(1.1,0.,pow(st.x-.8,4.)*2.+.4)-smoothstep(.7,-.2,st.y);
    float greenPCT=st.x*.3;
    float bluePCT=smoothstep(.7,.0,st.x)-smoothstep(.1,3.,st.y)+smoothstep(-.2,2.,st.x);
    
    vec3 color=vec3(redPCT,greenPCT,bluePCT);
    
    // color=mix(color,vec3(1,0,0), plot(st,redPCT));
    // color=mix(color,vec3(0,1,0), plot(st,greenPCT));
    // color=mix(color,vec3(0,0,1), plot(st,bluePCT));
    
    vec3 water=vec3(.1176,.1529,.4235);
    
    // float waterPCT= smoothstep(0.7,0.,st.y);
    // color=mix(color,water, waterPCT);
    
    vec3 sun=vec3(.9922,.9804,.5882);
    float sunPCT=smoothstep(.2,.0,length(st-vec2(.8,.8)));
    
    color=mix(color,sun,sunPCT);
    
    gl_FragColor=vec4(color,1);
}