Manisha Gurukumar  
7934750  
COMP4490  

# Final Project: Volumetric Rendering

For this project, I have implemented a real-time volumetric rendering scene in OpenGL. The project simulates a cloud-like volume using a combination of ray marching, procedural noise functions, and physically-based single scattering illumination.

All the project files are located under the `src/` directory, specifically `volumetric-rendering.cpp`, `vshader.glsl`, and `fshader.glsl`.  

I did this project on macOS 26.2 on a Macbook Air with the M1 chip and used the included Makefile (with brief changes) to compile the program. The Makefile used is provided in `src/`.

## Shaders
Rendering is mainly done on the GPU, specifically the fshader.

### `vshader.glsl` 
This is a very simplified vertex shader that outputs a single triangle large enough to cover the entire screen. This allows for per-pixel calculations on the fragment shader.

### `fshader.glsl` 
The core of the volumetric rendering is done entirely in the fragment shader. It uses ray marching to step through the volume (a sphere evaluated by an SDF) and accumulates density using Fractal Brownian Motion (fbm). It also accounts for single scattering by nesting a light-marching loop, applying Beer-Lambert's law for transmittance, and approximating directional scattering using the Henyey-Greenstein phase function. Two types of noise are togglable for generating density: Simplex Noise and Classic Perlin Noise.

## Controls 

### Keyboard 

* `q` / `ESC`: Quit.
* `1`, `2`, `3`, `4`, `5`: Change the octave level in the FBM calculation. Higher octaves add more detail and variation to the clouds but impact performance. Originally it is set to 3.
* `w`: Switch to Classic Perlin 3D Noise for density calculation (softer look).
* `e`: Switch to Simplex 3D Noise for density calculation (more sparse, better performance).
* `a`: Day sky setting.
* `s`: Sunset sky setting.

## Build and Run 
From the `opengl-2022/src` directory:
```bash
make  
../build/volumetric-rendering
```

## Other Notes
- The scene has wind animation 
- Used the examples provided as a base 