#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile
## Author:      Mattia Barbon
## Modified by:
## Created:     26/07/2003
## RCS-ID:      $Id: Makefile.PL,v 1.3 2005/01/05 14:41:22 mbarbon Exp $
## Copyright:   (c) 2003, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx::build::MakeMaker 0.16;

wxWriteMakefile( NAME         => 'Wx::GLCanvas',
                 VERSION_FROM => 'GLCanvas.pm',
                 LIBS         => ( $^O eq 'MSWin32' ? '-lopengl32' : '' ),
                 WX_CORE_LIB  => 'gl core base',
               );
