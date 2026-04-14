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

const char *WINDOW_TITLE = "Assignment 1";
const double FRAME_RATE_MS = 1000.0/60.0;

//---------------------------------------------------------------------------
// globals

GLuint VAO;

// OpenGL initialization
void
init()
{
   // Load shaders and use the resulting shader program
   GLuint program = InitShader( "vshaderA1.glsl", "fshaderA1.glsl" );
   glUseProgram( program );

   glEnable( GL_DEPTH_TEST );
   glClearColor( 0.0, 0.0, 0.0, 1.0 );
   // glClearColor( 1.0, 1.0, 1.0, 1.0 );

   // Create a single empty vertex array object
   // The vertex shader will natively generate the geometry
   glGenVertexArrays( 1, &VAO );
   glBindVertexArray( VAO );
}

//----------------------------------------------------------------------------
// DRAWING HELPER FUNCTIONS 
//----------------------------------------------------------------------------

void
display( void )
{
   glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

   // Bind the empty VAO and draw the 3 vertices
   glBindVertexArray( VAO );
   glDrawArrays( GL_TRIANGLES, 0, 3 );

   glutSwapBuffers();
}

//----------------------------------------------------------------------------

void
keyboard( unsigned char key, int x, int y )
{
   switch( key ) {
      case 033: // Escape Key
      case 'q': case 'Q':
         exit( EXIT_SUCCESS );
         break;
   }
}

//----------------------------------------------------------------------------

void
mouse( int button, int state, int x, int y )
{
}

//----------------------------------------------------------------------------

void
update( void )
{
   // Animation updates can go here (e.g. updating time uniforms)
   glutPostRedisplay();
}

//----------------------------------------------------------------------------

void
reshape( int width, int height )
{
   glViewport( 0, 0, width, height );
}