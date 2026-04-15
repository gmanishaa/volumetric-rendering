// Name: Manisha Gurukumar
// Student Number: 7934750
// Course: COMP 4490
// Project

#include "common.h"
#include <vector>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <glm/gtc/constants.hpp>

//---------------------------------------------------------------------------
// global constants

const char *WINDOW_TITLE = "Volumetric Rendering";
const double FRAME_RATE_MS = 1000.0 / 60.0;

//---------------------------------------------------------------------------
// globals
float animationIndexCount = 0.0;
int octaveLevel = 5;
GLuint VAO;

// shader uniform locations
GLuint animationIndex;
GLuint maxOctaves;

// OpenGL initialization
void init()
{
   // Load shaders and use the resulting shader program
   GLuint program = InitShader("vshader.glsl", "fshader.glsl");
   glUseProgram(program);

   animationIndex = glGetUniformLocation(program, "animationIndex");
   maxOctaves = glGetUniformLocation(program, "maxOctaves");

   glEnable(GL_DEPTH_TEST);
   glClearColor(0.0, 0.0, 0.0, 1.0);
   // glClearColor( 1.0, 1.0, 1.0, 1.0 );

   glGenVertexArrays(1, &VAO);
   glBindVertexArray(VAO);
}

//----------------------------------------------------------------------------
// DRAWING HELPER FUNCTIONS
//----------------------------------------------------------------------------

void display(void)
{
   glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

   // Bind the empty VAO and draw the 3 vertices
   glBindVertexArray(VAO);
   glDrawArrays(GL_TRIANGLES, 0, 3);

   glutSwapBuffers();
}

//----------------------------------------------------------------------------

void keyboard(unsigned char key, int x, int y)
{
   switch (key)
   {
   case 033: // Escape Key
   case 'q':
   case 'Q':
      exit(EXIT_SUCCESS);
      break;
   case '1':
      octaveLevel = 1;
      break;
   case '2':
      octaveLevel = 2;
      break;
   case '3':
      octaveLevel = 3;
      break;
   case '4':
      octaveLevel = 4;
      break;
   case '5':
      octaveLevel = 5;
      break;
   case '6':
      octaveLevel = 6;
      break;
   case '7':
      octaveLevel = 7;
      break;
   case '8':
      octaveLevel = 8;
      break;
   }
}

//----------------------------------------------------------------------------

void mouse(int button, int state, int x, int y)
{
}

//----------------------------------------------------------------------------

void update(void)
{
   animationIndexCount = animationIndexCount + 0.01;

   glUniform1f(animationIndex, animationIndexCount);
   glUniform1i(maxOctaves, octaveLevel);
}

//----------------------------------------------------------------------------

void reshape(int width, int height)
{
   glViewport(0, 0, width, height);
}