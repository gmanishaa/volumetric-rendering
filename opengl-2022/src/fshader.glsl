#version 150

in vec2 v_uv;

out vec4 fColor;

const int MAX_STEPS = 100;
const float STEP_SIZE = 0.05;
const vec3 CAMERA = vec3(0.0, 0.0, -3.0);
const int NUM_OCTAVES = 4;

//	Simplex 3D Noise 
//	by Ian McEwan, Stefan Gustavson (https://github.com/stegu/webgl-noise)
//  Used under MIT license
vec4 permute(vec4 x) {
  return mod(((x * 34.0) + 1.0) * x, 289.0);
}
vec4 taylorInvSqrt(vec4 r) {
  return 1.79284291400159 - 0.85373472095314 * r;
}

float snoise(vec3 v) {
  const vec2 C = vec2(1.0 / 6.0, 1.0 / 3.0);
  const vec4 D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i = floor(v + dot(v, C.yyy));
  vec3 x0 = v - i + dot(i, C.xxx);

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min(g.xyz, l.zxy);
  vec3 i2 = max(g.xyz, l.zxy);

  //  x0 = x0 - 0. + 0.0 * C 
  vec3 x1 = x0 - i1 + 1.0 * C.xxx;
  vec3 x2 = x0 - i2 + 2.0 * C.xxx;
  vec3 x3 = x0 - 1. + 3.0 * C.xxx;

// Permutations
  i = mod(i, 289.0);
  vec4 p = permute(permute(permute(i.z + vec4(0.0, i1.z, i2.z, 1.0)) + i.y + vec4(0.0, i1.y, i2.y, 1.0)) + i.x + vec4(0.0, i1.x, i2.x, 1.0));

// Gradients
// ( N*N points uniformly over a square, mapped onto an octahedron.)
  float n_ = 1.0 / 7.0; // N=7
  vec3 ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,N*N)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_);    // mod(j,N)

  vec4 x = x_ * ns.x + ns.yyyy;
  vec4 y = y_ * ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4(x.xy, y.xy);
  vec4 b1 = vec4(x.zw, y.zw);

  vec4 s0 = floor(b0) * 2.0 + 1.0;
  vec4 s1 = floor(b1) * 2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
  vec4 a1 = b1.xzyw + s1.xzyw * sh.zzww;

  vec3 p0 = vec3(a0.xy, h.x);
  vec3 p1 = vec3(a0.zw, h.y);
  vec3 p2 = vec3(a1.xy, h.z);
  vec3 p3 = vec3(a1.zw, h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
  m = m * m;
  return 42.0 * dot(m * m, vec4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));
}

float octaves(in vec3 p) {
  float fbm = 0.0;
  float amplitude = 0.75;
  float freq = 2.0;
  for(int i = 0; i < NUM_OCTAVES; i++) {
    fbm += amplitude + snoise(p * freq);
    freq *= 2.0;
    amplitude *= 0.5;
  }
  return fbm;
}

// float octaves(in vec3 p) {
//   float fbm = 0.0;
//   float amplitude = 0.5;
//   float freq = 2.0;
//   for(int i = 0; i < NUM_OCTAVES; i++) {
//     fbm += amplitude + snoise(p);
//     p *= freq;
//     freq += 0.21;
//     amplitude *= 0.5;
//   }
//   return fbm;
// }

float sdfSphere(in vec3 p, in float r) {
  float dist = length(p) - r;
  return -dist;
}

void march(in vec3 e, in vec3 s, out vec3 colour) {
  colour = vec3(0.0);
  float transmittance = 1.0;

  vec3 rayDir = normalize(s - e);
  float t = 0.0;

  for(int i = 0; i < MAX_STEPS; i++) {
    vec3 p = e + t * rayDir;

    float d = sdfSphere(p, 1.5);

    // density bigger than 0 (inside sphere)
    if(d > 0) {
      float density = clamp(d, 0, 1) * octaves(p);

      float absorption = density * STEP_SIZE;

      colour += transmittance * absorption * vec3(1.0);

      transmittance *= exp(-absorption);

      if(transmittance < 0.01)
        break;
    }

    t += STEP_SIZE;

    if(t > 20.0) {
      break;
    }
  }
}

void main() {
  vec3 s = vec3(v_uv, CAMERA.z + 1.0);
  vec3 colour = vec3(0.0);

  march(CAMERA, s, colour);

  fColor = vec4(colour, 1.0);
}
