#!/usr/bin/perl -w
#############################################################################
## Name:        minimal.pl
## Purpose:     Minimal Wx::GLCanvas sample
## Author:      Mattia Barbon
## Modified by:
## Created:     26/07/2003
## RCS-ID:      $Id: minimal.pl,v 1.2 2003/09/12 21:32:51 mbarbon Exp $
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

# every program must have a Wx::App-derive class
package MyApp;

use strict;
use base 'Wx::App';

# this is called automatically on object creation
sub OnInit {
  my( $this ) = @_;

  # create new MyFrame
  my( $frame ) = MyFrame->new( "Lame wxGLCanvas demo",
			       Wx::Point->new( 50, 50 ),
			       Wx::Size->new( 450, 350 )
                             );

  # show the frame
  $frame->Show( 1 );

  1;
}

package MyCanvas;

use strict;
use Wx::Event qw(EVT_PAINT EVT_SIZE EVT_ERASE_BACKGROUND);
# must load OpenGL *before* Wx::GLCanvas
use OpenGL qw(:glconstants :glfunctions);
use base 'Wx::GLCanvas';

sub new {
  my $class = shift;
  my $self = $class->SUPER::new( @_ );

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

package MyFrame;

use strict;
use base 'Wx::Frame';

use Wx::Event qw(EVT_MENU);
use Wx qw(wxBITMAP_TYPE_ICO wxMENU_TEAROFF);

# Parameters: title, position, size
sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );

  # load an icon and set it as frame icon
  $this->SetIcon( Wx::GetWxPerlIcon() );

  my $glcanvas = MyCanvas->new( $this, undef, -1 );

  $this;
}

package main;

# create an instance of the Wx::App-derived class
my( $app ) = MyApp->new();
# start processing events
$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
