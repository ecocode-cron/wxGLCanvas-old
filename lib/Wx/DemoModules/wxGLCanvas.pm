#############################################################################
## Name:        lib/Wx/DemoModules/wxGLCanvas.pm
## Purpose:     wxPerl demo helper for Wx::GLCanvas
## Author:      Mattia Barbon
## Modified by:
## Created:     26/07/2003
## RCS-ID:      $Id: wxGLCanvas.pm,v 1.1 2006/08/19 18:07:56 mbarbon Exp $
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DemoModules::wxGLCanvas;

use strict;

use Wx::Event qw(EVT_PAINT EVT_SIZE EVT_ERASE_BACKGROUND);
# must load OpenGL *before* Wx::GLCanvas
use OpenGL qw(:glconstants :glfunctions);
use base qw(Wx::GLCanvas);

sub new {
  my( $class, $parent ) = @_;
  my $self = $class->SUPER::new( $parent );

  EVT_PAINT( $self,
             sub {
               my $dc = Wx::PaintDC->new( $self );
               $self->Render( $dc );
           } );
  EVT_SIZE( $self,
            sub {
                my $size = $self->GetClientSize;
                return unless $self->GetContext;

                $self->SetCurrent;
                glViewport( 0, 0, $size->x, $size->y );

                $_[1]->Skip;
            } );
  # avoid flicker
  EVT_ERASE_BACKGROUND( $self, sub { } );

  return $self;
}

sub InitGL {
  my $self = shift;

  return if $self->{init};
  return unless $self->GetContext;

  $self->{init} = 1;
  # set viewing projection
  glMatrixMode(GL_PROJECTION);
  glFrustum(-0.5, 0.5, -0.5, 0.5, 1.0, 3.0);

  # position viewer
  glMatrixMode(GL_MODELVIEW);
  glTranslatef(0.0, 0.0, -2.0);

  # position object
  glRotatef(30.0, 1.0, 0.0, 0.0);
  glRotatef(30.0, 0.0, 1.0, 0.0);

  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
}

sub Render {
  my( $self, $dc ) = @_;

  return unless $self->GetContext;
  $self->SetCurrent;

  $self->InitGL;

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glFrustum(-0.5, 0.5, -0.5, 0.5, 1.0, 3.0);
  glMatrixMode(GL_MODELVIEW);

  # clear color and depth buffers
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  if( !$self->{gllist} )
  {
    my $gllist = $self->{gllist} = glGenLists( 1 );

    glNewList( $gllist, GL_COMPILE_AND_EXECUTE );
    # draw six faces of a cube
    glBegin(GL_QUADS);
    glNormal3f( 0.0, 0.0, 1.0);
    glVertex3f( 0.5, 0.5, 0.5); glVertex3f(-0.5, 0.5, 0.5);
    glVertex3f(-0.5,-0.5, 0.5); glVertex3f( 0.5,-0.5, 0.5);

    glNormal3f( 0.0, 0.0,-1.0);
    glVertex3f(-0.5,-0.5,-0.5); glVertex3f(-0.5, 0.5,-0.5);
    glVertex3f( 0.5, 0.5,-0.5); glVertex3f( 0.5,-0.5,-0.5);

    glNormal3f( 0.0, 1.0, 0.0);
    glVertex3f( 0.5, 0.5, 0.5); glVertex3f( 0.5, 0.5,-0.5);
    glVertex3f(-0.5, 0.5,-0.5); glVertex3f(-0.5, 0.5, 0.5);

    glNormal3f( 0.0,-1.0, 0.0);
    glVertex3f(-0.5,-0.5,-0.5); glVertex3f( 0.5,-0.5,-0.5);
    glVertex3f( 0.5,-0.5, 0.5); glVertex3f(-0.5,-0.5, 0.5);

    glNormal3f( 1.0, 0.0, 0.0);
    glVertex3f( 0.5, 0.5, 0.5); glVertex3f( 0.5,-0.5, 0.5);
    glVertex3f( 0.5,-0.5,-0.5); glVertex3f( 0.5, 0.5,-0.5);

    glNormal3f(-1.0, 0.0, 0.0);
    glVertex3f(-0.5,-0.5,-0.5); glVertex3f(-0.5,-0.5, 0.5);
    glVertex3f(-0.5, 0.5, 0.5); glVertex3f(-0.5, 0.5,-0.5);
    glEnd();

    glEndList();
  }
  else
  {
    glCallList( $self->{gllist} );
  }

  glFlush();
  $self->SwapBuffers();
}

sub tags { [ 'windows/glcanvas' => 'wxGLCanvas' ] }
sub add_to_tags { qw(windows/glcanvas) }
sub title { 'Cube' }

1;
