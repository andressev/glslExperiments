precision mediump float; 

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;


vec2 cMul(vec2 a, vec2 b){
    return vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x);
}
vec2 zetSquare(vec2 z){
    return vec2(z.x*z.x-z.y*z.y, 2.0*z.x*z.y);
}
vec2 oneOverZ(vec2 z){
    float len= length(z);
    return vec2(z.x/len/len, -z.y/len/len);
}
vec2 polynomial1(vec2 z){
    vec2 z0=z;
    for (int i=0; i<3; i++){
        z= cMul(z, z0);
    }
    return z;
}
vec2 polynomial2(vec2 z){
    vec2 z0=z;
    for (int i=0; i<6; i++){
        z= cMul(z, z0);
    }
    return z;
}
vec3 hsv2rgb(vec3 c)
{
    vec3 p = abs(fract(c.xxx + vec3(0,2,4)/3.)*6.-3.);
    return c.z * mix(vec3(1.), clamp(p-1.,0.,1.), c.y);
}
vec2 complexExponential(vec2 z,float w){
    return exp(z.x)*(vec2(cos(z.y*w)+sin(z.y*w)));
}


void main(){
    float res=.1;
    vec2 coords= gl_FragCoord.xy;
    // coords.x-=100.;
    // coords+= u_mouse;
    vec2 p= (coords)/u_resolution*res-res/2.;

    // vec2 z0=p;
    vec2 z0=u_mouse/u_resolution*res-res/2.;

    vec2 zi=p;
    vec2 numerator;
    vec2 denominator;
    vec2 adjustedMouse= u_mouse/u_resolution*res-res/2.;
    //complex coefficents for the polynomials
    float r=.1;
    vec2 a= vec2(r*cos(adjustedMouse.x), r*sin(adjustedMouse.y*1.3));
    vec2 b =  vec2(r*cos(adjustedMouse.x*0.2), r*sin(adjustedMouse.y*1.4));
    vec2 c=vec2(3.0);
    float len=0.0;

    

    float iters=0.1;
    for(int i=0; i<20; i++){
        iters= float(i);

       
        vec2 z1=zi;
        vec2 z2=cMul(z1,zi);
        vec2 z3=cMul(z2,zi);
        vec2 z4=cMul(z3,zi);
        vec2 z5= cMul(z4,zi);

        numerator= cMul(vec2(1.),z4)+z2+z1+z0; 
        denominator= oneOverZ(z5+z0);
        zi= cMul(numerator,denominator);       
        if(length(zi)>100.){
            break;
        }
    }

    
    len=length(zi);
    vec3 color= vec3(len);
    float fade = iters/200.;
  

    gl_FragColor=vec4(color*fade, 1.);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 