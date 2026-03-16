precision mediump float; 

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;



vec2 zetSquare(vec2 z){
    return vec2(z.x*z.x-z.y*z.y, 2.0*z.x*z.y);
}
vec2 oneOverZ(vec2 z){
    float len= length(z);
    return vec2(z.x/len/len, -z.y/len/len);
}


void main(){
    float res=3.7;
    vec2 coords= gl_FragCoord.xy;
    coords.x-=100.;
    // coords+= u_mouse;
    vec2 p= (coords)/u_resolution*res-res/2.;

    // vec2 z0=p;
    vec2 z0=u_mouse/u_resolution*res-res/2.;

    vec2 zi=p;

    for(int i=0; i<1000; i++){
        
        zi= zetSquare(zi)+z0;
        if(length(zi)>20.){
            break;
        }
    }

    float len= min(length(zi), .4);
    vec3 color= vec3(len);

    gl_FragColor=vec4(zi.x,zi.y,len, 1.);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 