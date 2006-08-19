#############################################################################
## Name:        GLCanvas.pm
## Purpose:     loader for Wx::GLCanvas.pm
## Author:      Mattia Barbon
## Modified by:
## Created:     26/07/2003
## RCS-ID:      $Id: GLCanvas.pm,v 1.1 2006/08/19 18:07:56 mbarbon Exp $
## Copyright:   (c) 2003, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::GLCanvas;

use strict;
use Wx;
use base 'Wx::ScrolledWindow';

$Wx::GLCanvas::VERSION = '0.04';

Wx::load_dll( 'gl' );
Wx::wx_boot( 'Wx::GLCanvas', $Wx::GLCanvas::VERSION );

1;

__END__

=head1 NAME

Wx::GLCanvas - interface to wxWidgets' OpenGL canvas

=head1 SYNOPSIS

    use OpenGL; # or any other module providing OpenGL API
    use Wx::GLCanvas;

=head1 DESCRIPTION

The documentation for this module is included in the main
wxPerl distribution (wxGLCanvas).

=head1 AUTHOR

Mattia Barbon <mbarbon@cpan.org>

=cut

# local variables:
# mode: cperl
# end:
