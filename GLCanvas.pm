#############################################################################
## Name:        GLCanvas.pm
## Purpose:     loader for Wx::GLCanvas.pm
## Author:      Mattia Barbon
## Modified by:
## Created:     26/07/2003
## RCS-ID:      $Id: GLCanvas.pm,v 1.1 2003/09/10 17:37:30 mbarbon Exp $
## Copyright:   (c) 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::GLCanvas;

use strict;
use Wx;
use OpenGL ();
use base 'Wx::ScrolledWindow';

$Wx::GLCanvas::VERSION = '0.01';

Wx::wx_boot( 'Wx::GLCanvas', $Wx::GLCanvas::VERSION );

1;

__END__

=head1 NAME

Wx::GLCanvas - interface to wxWindows' OpenGL canvas

=head1 SYNOPSIS

    use OpenGL;
    use Wx::GLCanvas;

=head1 DESCRIPTION

The documentation for this module is included in the main
wxPerl distribution (wxGLCanvas).

=head1 AUTHOR

Mattia Barbon <mbarbon@dsi.unive.it>

=cut

# local variables:
# mode: cperl
# end:
