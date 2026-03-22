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
vec2 complexMultiplication(vec2 a, vec2 b){
    return vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec3 p = abs(fract(c.xxx + vec3(0,2,4)/3.)*6.-3.);
    return c.z * mix(vec3(1.), clamp(p-1.,0.,1.), c.y);
}

void main(){
    float res=5.0;
    vec2 coords= gl_FragCoord.xy;
    // coords.x-=1000.0;
    // coords+= u_mouse;
    vec2 p= (coords)/u_resolution*res-res/2.;
    
    //First polynomial
    vec2 p1= p;
    for (int i=0; i<2; i++){
        p1= complexMultiplication(p, p1);
    }
    
    //Second polynomial
    vec2 root2= p-vec2(0.0, 0.0);
    vec2 p2= root2;
    for (int i=0; i<9; i++){
        p2= complexMultiplication(root2, p2);
    }

    //coeffcients
    float r=3.1;
    vec2 a= vec2(6.0, 1.0);
    vec2 b =  vec2(1.0, 0.0);
    
    p1= complexMultiplication(a, p1);
    p2= complexMultiplication(b, p2);
    vec2 polynomial= p1+p2+3.0*u_mouse/u_resolution*res-res/2.;
    polynomial= oneOverZ(polynomial);
    polynomial= complexMultiplication(p1, polynomial);

    float phase = atan(polynomial.y, polynomial.x);
    float len= length(polynomial);

    vec3 color= hsv2rgb(vec3(phase/(2.0*3.14159)+0.5, 1.0, 1.0-exp(-len)));
    


    gl_FragColor=vec4(polynomial.x, polynomial.y, log(len), 1.0);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 