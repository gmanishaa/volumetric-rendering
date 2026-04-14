#version 150

in vec2 v_uv;

out vec4 fColor;

const int MAX_STEPS = 100;
const float STEP_SIZE = 0.05;
const vec3 CAMERA = vec3(0.0, 0.0, -5.0);

float sdfSphere(in vec3 p, in float r) {
   return length(p) - r;
}

bool march(in vec3 e, in vec3 s, out vec3 colour)
{
   colour = vec3(0.0);

   vec3 rayDir = normalize(s - e);
   float t = 0.0;

   for (int i = 0; i < MAX_STEPS; i++) {
      vec3 p = e + t * rayDir;

      float d = sdfSphere(p, 1.0);

      if ( d < 0.001 ) {
         colour = vec3(1.0);
         return true;
      }

      t += d;

      if ( t > 20.0 ) {
         break;
      }
   }

   return false;
}

void main() 
{ 
   vec3 s = vec3(v_uv, CAMERA.z + 1.0);
   vec3 colour = vec3(0.0);

   march(CAMERA, s, colour);

   fColor = vec4(colour, 1.0);
}
