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


void main(){
    float res=3.0;
    vec2 coords= gl_FragCoord.xy;
    // coords.x-=1000.0;
    // coords+= u_mouse;
    vec2 p= (coords)/u_resolution*res-res/2.;
    
    // float a= 4.*cos(u_time);
    // float b= 2.*sin(u_time*0.3);
    // float c= 2.*cos(u_time*0.7);
   
    float r=1.1;
    vec2 root1= vec2(r*cos(u_time), r*sin(u_time));
    vec2 root2= vec2(r*cos(u_time*-0.3), r*sin(u_time*0.3));
    vec2 root3= vec2(r*cos(u_time*0.7), r*sin(u_time*-0.7));
    vec2 root4= vec2(r*cos(u_time*0.5+1.34), r*sin(u_time*0.5));
    vec2 root5= vec2(r*cos(u_time*0.5+3.14), r*sin(u_time*0.5+3.14));
    vec2 root6= vec2(r*cos(u_time*0.5+3.14+1.34), r*sin(u_time*0.5+3.14+1.34));
    // vec2 polynomyal=a*zetCube(p)+b*zetSquare(p)+c*p+d;
    vec2 factor1= complexMultiplication((p-root1), (p-root2));
    vec2 factor2= complexMultiplication((p-root4), (p-root3));
    vec2 factor3= complexMultiplication((p-root5), (p-root6));
    vec2 factor2times3= complexMultiplication(factor2, factor3);

    vec2 polynomyal=complexMultiplication(factor1, factor2times3);

    // float a= r*cos(u_time*0.5+u_mouse.x*0.01);
    // float b= r*sin(u_time*0.5+u_mouse.y*0.01);
    // float c= r*cos(u_time*0.5+1.57+u_mouse.x*0.01);
    // float d= r*sin(u_time*0.5+1.57+u_mouse.y*0.01);
    // float e= r*cos(u_time*0.5+3.14+u_mouse.x*0.01);
    // float f= r*sin(u_time*0.5+3.14+u_mouse.y*0.01);
    // float g= r*cos(u_time*0.5+4.71+u_mouse.x*0.01);

    vec2 a= vec2(r*cos(u_mouse.x*0.01), r*sin(u_mouse.y*0.01));
    vec2 b= vec2(r*cos(u_time*0.5+1.57+u_mouse.x*0.01), r*sin(u_time*0.5+1.57+u_mouse.y*0.01));
    vec2 c= vec2(r*cos(u_time*0.5+3.14+u_mouse.x*0.01), r*sin(u_time*0.5+3.14+u_mouse.y*0.01));
    vec2 d= vec2(r*cos(u_time*0.5+4.71+u_mouse.x*0.01), r*sin(u_time*0.5+4.71+u_mouse.y*0.01));
    vec2 g= vec2(r*cos(u_time*0.5+4.71+u_mouse.x*0.01), r*sin(u_time*0.5+4.71+u_mouse.y*0.01));
    vec2 e= vec2(r*cos(u_time*0.5+6.28+u_mouse.x*0.01), r*sin(u_time*0.5+6.28+u_mouse.y*0.01));
    vec2 f= vec2(r*cos(u_time*0.5+7.85+u_mouse.x*0.01), r*sin(u_time*0.5+7.85+u_mouse.y*0.01));

    // vec2 a= u_mouse/u_resolution*res-res/2.+vec2(0.0, 1.0);
    // vec2 b= u_mouse/u_resolution*res-res/2.+vec2(1.0, 1.0);
    // vec2 c= u_mouse/u_resolution*res-res/2.+vec2(1.0, 0.0);
    // vec2 d= u_mouse/u_resolution*res-res/2.+vec2(0.0, 0.0);
    // vec2 g= u_mouse/u_resolution*res-res/2.+vec2(0.0, -1.0);
    // vec2 e= u_mouse/u_resolution*res-res/2.+vec2(-1.0, -1.0);
    // vec2 f= u_mouse/u_resolution*res-res/2.+vec2(-1.0, 0.0);


    vec2 polynomyal2= complexMultiplication(a,zetSquare(zetCube(p)))+complexMultiplication(c,zetSquare(zetSquare(p)))+complexMultiplication(d,zetCube(p))+complexMultiplication(e,zetSquare(p))+complexMultiplication(f,p)+g;
    // float c= sqrt(b*d*4.);

    vec2 zi= oneOverZ(complexMultiplication(polynomyal, polynomyal2));
    // vec2 zi = polynomyal2;
    // vec2 zi= complexMultiplication(polynomyal, polynomyal2);

   
    float len= min(length(zi), .6);
    


    gl_FragColor=vec4(zi.x,zi.y,len, 1.0);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 