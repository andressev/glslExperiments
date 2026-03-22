#version 300 es
#define PI 3.1415
precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;
const int dim = 3;

out vec4 fragColor;

vec2 oneOverZ(vec2 z){
    float r2 = dot(z, z);
    r2 = max(r2, 1e-6);
    return vec2(z.x / r2, -z.y / r2);
}

vec2 cMul(vec2 a, vec2 b){
    return vec2(a.x*b.x - a.y*b.y, a.x*b.y + a.y*b.x);
}

float getCoeff(int index, int k,vec2 coef){
    int bit = (index >> k) & 1;
    return bit == 1 ? coef.x : coef.y;
}
vec3 hsv2rgb(vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x*6.0 + vec3(0,4,2), 6.0)-3.0)-1.0, 0.0, 1.0);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void main(){
    float res = 4.;
    vec2 z = res * (gl_FragCoord.xy / u_resolution - 0.5);
    vec2 mouse= res * (u_mouse/ u_resolution - 0.5);
    vec2 zpowers[dim];
    zpowers[0] = z;
    for(int i = 1; i < dim; i++){
        zpowers[i] = cMul(zpowers[i-1], z); // z^(i+1)
    }

    vec2 minP = vec2(0.0);
    float minNorm = 1e20;

    float iter=1.;
    for(int i = 0; i < 8; i++){
        vec2 auxP = vec2(0.0);

        for(int n = 0; n < dim; n++){
            auxP += zpowers[n] * getCoeff(i, n, mouse*10.);
        }
            auxP+=mouse;

        float auxNorm = dot(auxP, auxP);
        
        if(auxNorm < minNorm){
            minNorm = auxNorm;
            minP = auxP;
            iter=float(i);
        }
    }

    vec2 plt= oneOverZ(minP);

    float len=length(plt);
    vec3 color= vec3(log(len));
   
    //Cada color representa una raiz de un polinomio diferente
    //checar   
    vec3 iteration= vec3(iter/pow(2.,float(dim)),abs(cos(iter)), abs(sin(iter)));
    fragColor = vec4(color*iteration, 1.0);
}