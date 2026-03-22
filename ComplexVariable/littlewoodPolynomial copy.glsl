#version 300 es
precision mediump float; 

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;
const int dim=4;


out vec4 fragColor;

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
float getCoeff(int index, int k){
    int bit = (index >> k) & 1;
    return bit == 1 ? 1.0 : -1.0;
}
// float evalPolynomial(){}


void main(){
    float res=10.0;
    vec2 z=res* (gl_FragCoord.xy/u_resolution-0.5);

    
    // coords.x-=1000.0;
    // // // coords+= u_mouse;
    vec2 zpowers[dim];
    zpowers[0]=z;
    for(int i=0 ; i<dim-1;i++){
       zpowers[i+1]=cMul(z,zpowers[i]);
    }

    // int polynomials=int(pow(2.,float(dim+1)));
    // vec2 ffg[1];
    vec2 minP=vec2(0.0);
    vec2 auxPol=vec2(0.0);
    for(int i=0; i<16; i++){
        
        for(int n=1; n<=dim; n++){
            auxPol+=zpowers[n];
        }

    }

    // vec2 inv=oneOverZ(minP);



    // int bit= 10>>10;

    
    // vec3 color = 


    fragColor=vec4(minP,0.0,1.0);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 
