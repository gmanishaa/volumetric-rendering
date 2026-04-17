#version 150

// triangle that covers entire screen
const vec2 vertices[3] = vec2[3](
  vec2(-1.0, -1.0),
  vec2( 3.0, -1.0),
  vec2(-1.0,  3.0)
);

out vec2 v_uv;

void main()
{
  vec2 pos = vertices[gl_VertexID];
  
  // set out variable to current position
  v_uv = pos;
  
  gl_Position = vec4(pos, 0.0, 1.0);
}

