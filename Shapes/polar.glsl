precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;
#define PI 3.14159265359

float plot(vec2 st, float dist){
    return smoothstep(dist-0.07, dist, st.y)-smoothstep(dist, dist+0.01, st.y);
}

void main(){
    
    vec2 st= gl_FragCoord.xy/u_resolution.xy;

    st=st*2.-1.;

    float r = length(st);
    float a= atan(st.y,st.x);

    float y= cos(a*4.+0.01*(-u_mouse.x*1.+0.5)*4.1)+u_mouse.x+sin(a*4.-u_time*0.01)*sin(r*8.-u_time);

    vec3 color=vec3(mod(y,0.9));
    color=.02/color;

    vec3 adjustColor=vec3(0.3608, 0.102, 0.5608);
    vec3 colorweird= vec3(adjustColor.x*adjustColor.y*mod(u_time,10.01), cos(adjustColor.x+1./u_time)/10., adjustColor.y*3.);
    color*=colorweird;
    
    // vec3 color=vec3(y);
    gl_FragColor=vec4(color,1);
}