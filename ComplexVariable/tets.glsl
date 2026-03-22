precision mediump float; 

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;



vec2 zetSquare(vec2 z){
    return vec2(z.x*z.x-z.y*z.y, 2.0*z.x*z.y);
}
vec2 zetCube(vec2 z){
    return vec2(z.x*z.x*z.x-3.0*z.x*z.y*z.y, 3.0*z.x*z.x*z.y- z.y*z.y*z.y);
}
vec2 oneOverZ(vec2 z){
    float len= length(z);
    return vec2(z.x/len/len, -z.y/len/len);
}
vec2 cMul(vec2 a, vec2 b){
    return vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x);
}


void main(){
    float res=3.0;
    vec2 coords= gl_FragCoord.xy;
    // coords.x-=1000.0;
    // coords+= u_mouse;
    vec2 p= (coords)/u_resolution*res-res/2.;
    
    float x= p.x*p.x;
    float y= p.y;


    
    vec2 w= cMul(p,p);

    vec2 zi= vec2(0.0);
    vec2 z0= p-vec2(0.1,1.1);
    float iter=0.0;
    for (int i=0; i<100; i++){
        iter= float(i);
        zi= cMul(zi,zi)+ p;
        if(dot(zi,zi)>10.){
            break;
        }
    }   


    float fade= iter/100.;
    float len=length(zi)*fade;






    gl_FragColor=vec4(fade,fade,fade,1.0);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 