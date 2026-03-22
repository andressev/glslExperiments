precision highp float; 

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;



float hSum(float a,float b){
    float t=1.;
    float res= (a+b)/(1.+(a*b)/(t*t));
    return res;
}
float hSubtract(float a, float b){
    float t=1.;
    float res= (a-b)/(1.+(a*b)/(t*t));
    return res;
}

vec2 hSum2D(vec2 a, vec2 b){
    return vec2(hSum(a.x,b.x),hSum(a.y,b.y));
}
vec2 hSubtract2D(vec2 a, vec2 b){
    return vec2(hSubtract(a.x,b.x),hSubtract(a.y,b.y));
}
vec2 cMulH(vec2 a, vec2 b){
    return vec2(hSubtract(a.x*b.x,a.y*b.y), hSum(a.x*b.y,a.y*b.x));
}

vec2 zSquareH(vec2 z){
    return vec2(hSubtract(z.x*z.x,z.y*z.y), 2.0*z.x*z.y);
}
vec2 zCubeH(vec2 z){
    vec2 z2=cMulH(z,z);
    return cMulH(z2,z);

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
    return vec4(z.x, z.y, 1.5*abs(sin(z.x)), abs(cos(z.y)));
}



void main(){
    //ZETA cambiale al valor res intenta 0.5
    float res=.52;
    vec2 coords= gl_FragCoord.xy;
    // coords.y+=900.0;   
    // coords.x-=400.0;


    vec2 p = (2.0*coords - u_resolution) / min(u_resolution.x, u_resolution.y);
    p *= res;
    // coords.x+=250.;

    // coords+= u_mouse;
    // vec2 p= (coords)/u_resolution*res-res/2.;

    // vec2 z0=p;

    vec2 zi=p;
    float iter=0.0;
    vec2 mouse= u_mouse/u_resolution*res-res/2.;
    vec2 z0=mouse;
    for(int i=0; i<20; i++){

        vec2 z1=zi;
        vec2 z2= cMulH(z1,zi);
        vec2 z3= cMulH(z2,zi);
        vec2 z4= cMulH(z3,zi);

        vec2 p1= hSum2D(cMulH(mouse*10.,z4),cMulH(z3,hSum2D(cMulH(z2,z0),z1)));
        // vec2 p2= oneOverZ(hSum2D(z4,z1));

        iter= float(i);
        zi= hSum2D(p1,u_mouse/u_resolution);
        if((dot(zi,zi) > 30.0) ){
            break;
        }
    }
    vec4 quat = complexToQuat(zi);
    vec3 color= quat.xyz;

    float fade = float(iter)/float(250);

    color = vec3(color.x,color.y*fade,color.z*fade);
    


    gl_FragColor=vec4(color, 1.);
}
