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
  

//// Coefccicents

    vec2 a= vec2(r*cos(u_mouse.x*0.01), r*sin(u_mouse.y*0.01));
    vec2 b= vec2(r*cos(u_time*0.5+1.57+u_mouse.x*0.01), r*sin(u_time*0.5+1.57+u_mouse.y*0.01));
    vec2 c= vec2(r*cos(u_time*0.5+3.14+u_mouse.x*0.01), r*sin(u_time*0.5+3.14+u_mouse.y*0.01));
    vec2 d= vec2(r*cos(u_time*0.5+4.71+u_mouse.x*0.01), r*sin(u_time*0.5+4.71+u_mouse.y*0.01));
    vec2 g= vec2(r*cos(u_time*0.5+4.71+u_mouse.x*0.01), r*sin(u_time*0.5+4.71+u_mouse.y*0.01));
    vec2 e= vec2(r*cos(u_time*0.5+6.28+u_mouse.x*0.01), r*sin(u_time*0.5+6.28+u_mouse.y*0.01));
    vec2 f= vec2(r*cos(u_time*0.5+7.85+u_mouse.x*0.01), r*sin(u_time*0.5+7.85+u_mouse.y*0.01));

    vec2 polynomial2= complexMultiplication(a,zetSquare(zetCube(p)))+complexMultiplication(b,zetSquare(zetSquare(p)))+complexMultiplication(c,zetCube(p))+complexMultiplication(d,zetSquare(p))+complexMultiplication(e,p)+f;
    // float c= sqrt(b*d*4.);

    //lo invertimos para que las raices salgan, prueba tomar la linea comentada de abajo
    // vec2 q= polynomial2;
    vec2 q= oneOverZ(polynomial2);
    
   
    // float len= min(length(zi), .6);
    


    gl_FragColor=vec4(q.x,q.y,log(length(q), 1.0);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 