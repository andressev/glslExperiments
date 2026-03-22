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
vec3 hsv2rgb(vec3 c)
{
    vec3 p = abs(fract(c.xxx + vec3(0,2,4)/3.)*6.-3.);
    return c.z * mix(vec3(1.), clamp(p-1.,0.,1.), c.y);
}

vec4 complexToQuat(vec2 z){
    return vec4(z.x, z.y, sin(z.x), cos(z.y));
}



void main(){
    float res=3.7;
    vec2 coords= gl_FragCoord.xy;
    
    vec2 p= (coords)/u_resolution*res-res/2.;
    vec2 mouse=u_mouse/u_resolution*res-res/2.;

    // vec2 z0=vec2(-1.1,0.23);

    vec2 zi=p;
    float iter=0.0;

    //Polynomial Iteration
    for(int i=0; i<20; i++){
        iter= float(i);
        zi= zetSquare(zi)+mouse;
        if((dot(zi,zi) > 2.0) ){
            break;
        }
    }


    vec4 quat = complexToQuat(zi);
    vec3 color= quat.wyz;

    float fade = float(iter)/float(20);

    color = vec3(color.x*fade,color.y*fade,color.z);
    vec3 lengthColor = vec3(length(color));


    gl_FragColor=vec4(lengthColor*fade, 1.);
}

// color= r(p.x+p.y)+g()+b();
//  si x = 1  ==> r= 1-y
// 