precision mediump float;

uniform vec2 u_resolution;
#define PI 3.14159265359

float plot(vec2 st, float value){
    return smoothstep(value-0.02, value, st.y)-smoothstep(value, value+0.01, st.y);
}
vec3 purple= vec3(0.2431, 0.0, 0.5059);
vec3 darkBlue= vec3(0.0, 0.051, 0.7451);
vec3 lightBlue= vec3(0.0588, 0.6, 0.7608);
vec3 green= vec3(0.1059, 0.7608, 0.0588);
vec3 yellow= vec3(1, 1.0, 0.);
vec3 orange= vec3(0.7608, 0.2941, 0.0588);
vec3 red= vec3(1., 0., 0.);




void main(){
    


    vec2 st= gl_FragCoord.xy/u_resolution.xy;
    st.x-=0.5;
    st.y-=0.5;
    
    float exponent=2.;
    float curve=1.3;

    float purplePCT= -pow(st.x,exponent)*curve;
    float darkBluePCT= -pow(st.x,exponent)*curve+0.02;
    float lightBluePCT= -pow(st.x,exponent)*curve+0.04;
    float greenPCT= -pow(st.x,exponent)*curve+0.06;
    float yellowPCT= -pow(st.x,exponent)*curve+0.08;
    float orangePCT= -pow(st.x,exponent)*curve+0.1;
    float redPCT= -pow(st.x,exponent)*curve+0.12;

    
    float pct= plot(st, purplePCT);
    vec3 color=vec3(1.);

    

    color= mix(color, purple, plot(st, purplePCT));
    color= mix(color, darkBlue, plot(st, darkBluePCT));
    color= mix(color, lightBlue, plot(st, lightBluePCT));
    color= mix(color, green, plot(st, greenPCT));
    color= mix(color, yellow, plot(st, yellowPCT));
    color= mix(color, orange, plot(st, orangePCT));
    color= mix(color, red, plot(st, redPCT));
    gl_FragColor=vec4(color,1);
}