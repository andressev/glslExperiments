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
    float res=5.0;
    vec2 p= gl_FragCoord.xy/u_resolution*res-res/2.;
    


    vec2 A= vec2(0.0,0.0);
    vec2 B= vec2(5.,5.5);

    vec2 B2= vec2(-5.,5.0);

    float sdf= min(lineSegmentSDF(A,B,p),lineSegmentSDF(A,B2,p));
    sdf=min(sdf, lineSegmentSDF(A,-B,p));
    sdf=min(sdf,lineSegmentSDF(A,-B2,p));

    sdf=mod(sdf,cos(u_time*0.3));

    // sdf= 

    
    
    float plt= smoothstep(sdf-0.01,0.,1.)-smoothstep(sdf+.01,0.,1.0);
   

    

    gl_FragColor=vec4(plt,0.,0., 1.);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 