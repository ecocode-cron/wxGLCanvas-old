#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile
## Author:      Mattia Barbon
## Modified by:
## Created:     26/07/2003
## RCS-ID:      $Id: Makefile.PL,v 1.4 2006/08/19 18:09:39 mbarbon Exp $
## Copyright:   (c) 2003, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx::build::MakeMaker 0.16;

wxWriteMakefile( NAME          => 'Wx::GLCanvas',
                 VERSION_FROM  => 'lib/Wx/GLCanvas.pm',
                 LIBS          => ( $^O eq 'MSWin32' ? '-lopengl32' : '' ),
                 WX_CORE_LIB   => 'gl core base',
                 WX_OVERLOAD   => { header  => 'cpp/ovl_const.h',
                                    source  => 'cpp/ovl_const.cpp',
                                    },
                 PREREQ_PM     => { Wx   => '0.57',
                                    },
                 );
