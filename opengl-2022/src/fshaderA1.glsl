#version 150

in vec2 v_uv;

out vec4 fColor;

const int MAX_STEPS = 100;
const float STEP_SIZE = 0.05;
const vec3 CAMERA = vec3(0.0, 0.0, -3.0);

float sdfSphere(in vec3 p, in float r) {
   float dist = length(p) - r;
   return -dist;
}

void march(in vec3 e, in vec3 s, out vec3 colour)
{
   colour = vec3(0.0);
   float transmittance = 1.0;

   vec3 rayDir = normalize(s - e);
   float t = 0.0;

   for (int i = 0; i < MAX_STEPS; i++) {
      vec3 p = e + t * rayDir;

      float d = sdfSphere(p, 1.5);

      // density bigger than 0 (inside sphere)
      if ( d > 0 ) {
         float density = 1.0;

        // how much light is absorbed this step
        float absorption = density * STEP_SIZE;

        // accumulate colour — transmittance weights contribution by how much light remains
        colour += transmittance * absorption * vec3(1.0);

        // beer's law — attenuate transmittance
        transmittance *= exp(-absorption);

        // early exit — ray is fully occluded, no point continuing
        if (transmittance < 0.01) break;
      }

      t += STEP_SIZE;

      if ( t > 20.0 ) {
         break;
      }
   }
}

void main() 
{ 
   vec3 s = vec3(v_uv, CAMERA.z + 1.0);
   vec3 colour = vec3(0.0);

   march(CAMERA, s, colour);

   fColor = vec4(colour, 1.0);
}
