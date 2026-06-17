# Volumetric Rendering

A real-time volumetric rendering scene implemented in OpenGL using ray marching, procedural noise, and physically-based single scattering illumination.

## Demo GIF
<div align="center">
  <img src="demo/volumetric-rendering.gif" alt="Volumetric Cloud Rendering Engine" style="border-radius: 12px; margin-bottom: 25px; width: 100%; object-fit: cover;" />
</div>
[Full demo video](demo/volumetric-rendering.mov)

## Prerequisites

All external dependencies (glew, freeglut, glm) are included in the repository.

### macOS
All dependencies are included. The file `opengl-2022/glew/lib/libGLEW.a` is a fat binary with both x64 and arm64 versions. If you're running an older macOS and encounter compatibility issues, use `libGLEW.a-old` from the same directory.

### Linux
Install dependencies using your package manager. On Debian or Ubuntu:

```bash
apt-get install libglu1-mesa-dev freeglut3-dev mesa-common-dev libglew-dev
```

You'll also need either `clang` or `g++` (the Makefile defaults to `clang`). On some systems, `-DEXPERIMENTAL` may need to be added to `CFLAGS` to expose modern OpenGL features.

### Windows
Use Visual Studio (tested with Community Edition). Open `opengl-2022/opengl.sln` and build normally. If you encounter missing build tools or SDK errors, right-click the solution and select "Retarget solution" to update to your installed tools and SDK version.

## Building and Running

### macOS and Linux (Command Line)

Navigate to the source directory and use the included Makefile:

```bash
cd opengl-2022/src
make
../build/volumetric-rendering
```

### Windows (Visual Studio)

1. Open `opengl-2022/opengl.sln`
2. Build and run

## Controls 

### Keyboard 

* `q` / `ESC`: Quit.
* `1`, `2`, `3`, `4`, `5`: Change the octave level in the FBM calculation. Higher octaves add more detail and variation to the clouds but impact performance. Originally it is set to 3.
* `w`: Switch to Classic Perlin 3D Noise for density calculation (softer look).
* `e`: Switch to Simplex 3D Noise for density calculation (more sparse, better performance).
* `a`: Day sky setting.
* `s`: Sunset sky setting.

## Important Notes

- **Execute from the `src` directory**: The program opens files relative to `src`, so it must be run from there.
- **Shader files**: `vshader.glsl` and `fshader.glsl` are in the `src` directory and can be edited in any text editor with GLSL syntax highlighting.

## Project Contents

```
opengl-2022/
├── src/
│   ├── volumetric-rendering.cpp
│   ├── vshader.glsl
│   ├── fshader.glsl
│   ├── README.md (explanation about the shaders)
│   └── Makefile
├── build/            # Output executable
├── glew/             # GLEW library
├── freeglut/         # FreeGLUT library
├── glm/              # GLM math library
└── opengl.sln        # Visual Studio solution (Windows)
```
