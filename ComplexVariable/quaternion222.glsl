precision mediump float; 

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;


vec4 complexToQuaternion(vec2 z){

    float r = length(z);
    float theta = atan(z.y, z.x);

    float w = cos(r);
    float x = sin(r)*cos(theta);
    float y = sin(r)*sin(theta);
    float k = sin(2.0*r);

    return vec4(w,x,y,k);
}

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
vec2 complexMultiplication(vec2 a, vec2 b){
    return vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec3 p = abs(fract(c.xxx + vec3(0,2,4)/3.)*6.-3.);
    return c.z * mix(vec3(1.), clamp(p-1.,0.,1.), c.y);
}
vec3 quatColor(vec4 q){

    float phase = atan(q.y, q.x);
    float mag = length(q.yzw);

    float hue = phase/(2.0*3.14159)+0.5;
    float val = 1.0-exp(-mag);

    return hsv2rgb(vec3(hue,1.0,val));
}
vec4 qMul(vec4 a, vec4 b){
    float w = a.x*b.x - a.y*b.y - a.z*b.z - a.w*b.w;
    float x = a.x*b.y + a.y*b.x + a.z*b.w - a.w*b.z;
    float y = a.x*b.z - a.y*b.w + a.z*b.x + a.w*b.y;
    float z = a.x*b.w + a.y*b.z - a.z*b.y + a.w*b.x;
    return vec4(w,x,y,z);
}

vec4 quaternionSquare(vec4 q){
    return qMul(q, q);
}
vec4 quaternionCube(vec4 q){
    return qMul(quaternionSquare(q), q);
}
vec4 quaternionFourth(vec4 q){
    return qMul(quaternionCube(q), q);
}
vec4 quaternionFifth(vec4 q){
    return qMul(quaternionFourth(q), q);
}
vec4 oneOverQuaternion(vec4 q){
    float len = length(q);
    return vec4(q.x/len/len, -q.y/len/len, -q.z/len/len, -q.w/len/len);
}


void main(){
    //change resolution
    float res=2.9;
    vec2 coords= gl_FragCoord.xy;
    // coords.x-=1000.0;
    // coords+= u_mouse;
    // vec2 z0= u_mouse/u_resolution*res-res/2.;
    vec2 p= (coords)/u_resolution*res-res/2.;

  

    //change from complex to quaternion coords
    vec4 q= vec4(p,complexMultiplication(u_mouse/u_resolution*res-res/2., p));

    vec4 q0= vec4(u_mouse/u_resolution*res-res/2., p);
    vec4 numerator;
    vec4 denominator;

    // quaternioninc coefficients for polynomial
    float r=2.1;


    vec4 a= vec4(r*cos(u_mouse.x*0.01), r*sin(u_mouse.y*0.01), 0.0, 0.0);
    vec4 b =  vec4(r*cos(u_time*0.1+1.57+u_mouse.x*0.01), r*sin(u_time*0.1+1.57+u_mouse.y*0.01), p);
    vec4 c= vec4(r*cos(u_time*0.1+3.14+u_mouse.x*0.01), r*sin(u_time*0.1+3.14+u_mouse.y*0.01), 0.0, 0.0);
    vec4 d= vec4(r*cos(u_time*0.1+4.71+u_mouse.x*0.01), r*sin(u_time*0.1+4.71+u_mouse.y*0.01), 0.0, 0.0);
    vec4 e = complexToQuaternion(vec2(r*cos(u_time*0.1+5.71+u_mouse.x*0.01), r*sin(u_time*0.1+5.71+u_mouse.y*0.01)));

    
    //quaternioninc julia set iteration
    for(int i=0; i<9; i++){

        vec4 q1=q;
        vec4 q2= quaternionSquare(q);
        vec4 q3= quaternionCube(q);
        vec4 q4= quaternionFourth(q);
        vec4 q5= quaternionFifth(q);
        
        numerator= qMul(q3, c)+qMul(q2, d)+qMul(q, a)+q0;
        denominator= oneOverQuaternion(q5+qMul(q4, e)+qMul(q3, c)+qMul(q2, d)+qMul(q, a)+q0);
        q= qMul(numerator, denominator);
      
        
    }
    


    vec3 color= quatColor(q);


    gl_FragColor=vec4(color, 1.0);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 