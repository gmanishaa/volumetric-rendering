#version 150

// We generate a single massive triangle that covers the entire NDC screen space.
// Vertex 0: (-1, -1) Bottom Left
// Vertex 1: ( 3, -1) Far Bottom Right (off-screen)
// Vertex 2: (-1,  3) Far Top Left (off-screen)
const vec2 vertices[3] = vec2[3](
    vec2(-1.0, -1.0),
    vec2( 3.0, -1.0),
    vec2(-1.0,  3.0)
);

out vec2 v_uv;

void main()
{
  vec2 pos = vertices[gl_VertexID];
  
  // Map from [-1, 1] NDC space to [0, 1] UV space for the fragment shader (optional but helpful)
  // v_uv = pos * 0.5 + 0.5;
  v_uv = pos;
  
  gl_Position = vec4(pos, 0.0, 1.0);
}

