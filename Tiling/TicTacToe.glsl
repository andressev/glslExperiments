precision mediump float; 

uniform vec2 u_resolution;
uniform float u_time;

float circle(vec2 uv, float r){
    float dist= length(uv-0.5);
    return smoothstep(r,0.2, dist);
}

float lineSegmentSDF(vec2 A, vec2 B, vec2 p){
    float projection=dot(B-A,p-A)/(length(B-A)*length(B-A));
    float h=min(1.,max(projection,0.));
    vec2 Q= B*h+(1.-h)*A;

    return length(p-Q);

}









void main(){
    float res=abs(30.*cos(u_time*0.5));
    vec2 p= gl_FragCoord.xy/u_resolution*res-res/2.;
    


    vec2 A= vec2(0.0,0.0);
    vec2 B= vec2(p.x,3.5);



    float sdf= lineSegmentSDF(A,B,p);
    float r=cos(sdf*3.*p.y)*cos(sdf+u_time*.006*(cos(p.y)*cos(p.x)));
    float g=cos(sdf*12.+u_time*0.2*p.x/(1.1+cos(p.y)));


    
    
    float plt1= smoothstep(r-0.61,0.,1.)-smoothstep(r+1.3,0.,1.0);
    float plt2= smoothstep(g-0.371,0.,1.)-smoothstep(g+.81,0.,1.0);

    // float size=100.;
    // uv*=size;
    // // vec2 indicator= floor(uv)/size;
    // uv=fract(uv*cos(u_time*0.5)+0.2);
    float s= sin(sdf*30.)*cos(plt2*1.);

    

    gl_FragColor=vec4(plt1*sin(plt2+u_time*0.1)/(s),s*s*s,s/plt1, 1.);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 