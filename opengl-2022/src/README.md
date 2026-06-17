# Volumetric Rendering - Shader Implementation

## Shaders

Rendering is mainly done on the GPU, specifically the fragment shader.

### `vshader.glsl`
This is a simplified vertex shader that outputs a single triangle large enough to cover the entire screen. This allows for per-pixel calculations on the fragment shader.

### `fshader.glsl`
The core of the volumetric rendering is done entirely in the fragment shader. It uses ray marching to step through the volume (a sphere evaluated by an SDF) and accumulates density using Fractal Brownian Motion (fbm). It also accounts for single scattering by nesting a light-marching loop, applying Beer-Lambert's law for transmittance, and approximating directional scattering using the Henyey-Greenstein phase function. Two types of noise are togglable for generating density: Simplex Noise and Classic Perlin Noise.
