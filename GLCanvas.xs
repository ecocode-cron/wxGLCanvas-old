/////////////////////////////////////////////////////////////////////////////
// Name:        GLCanvas.xs
// Purpose:     XSor Wx::GLCanvas.pm
// Author:      Mattia Barbon
// Modified by:
// Created:     26/07/2003
// RCS-ID:      $Id: GLCanvas.xs,v 1.2 2003/09/12 21:30:50 mbarbon Exp $
// Copyright:   (c) 2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define STRICT

#include <wx/defs.h>
#include "wx/window.h"
#include "cpp/wxapi.h"

#if WXPERL_W_VERSION_GE( 2, 5, 0 ) && wxUSE_GLCANVAS
    #include <wx/glcanvas.h>
#else
    #ifdef __WXMSW__
        #undef  wxUSE_GLCANVAS
        #define wxUSE_GLCANVAS 1
        #define WXDLLIMPEXP_GL

        #include "myglcanvas.h"
        #include "glcanvas.cpp"
    #else
        #include <wx/glcanvas.h>
    #endif
#endif

MODULE=Wx__GLCanvas PACKAGE=Wx::GLCanvas

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

wxGLCanvas*
wxGLCanvas::new( parent, context, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxGLCanvasName )
    wxWindow* parent
    wxGLContext* context
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxGLCanvas( parent, context, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

##wxGLCanvas*
##wxGLCanvas::newWithContext()

wxGLContext*
wxGLCanvas::GetContext()

void
wxGLContext::SetColour( colour )
    wxString colour

void
wxGLCanvas::SetCurrent()

void
wxGLCanvas::SwapBuffers()

MODULE=Wx__GLCanvas PACKAGE=Wx::GLContext

wxGLContext*
wxGLContext::new( isRGB, win, palette = (wxPalette*)&wxNullPalette, cxt = NULL )
    bool isRGB
    wxGLCanvas* win
    wxPalette* palette
    wxGLContext* cxt
  CODE:
    RETVAL = cxt ? new wxGLContext( isRGB, win, *palette, cxt )
                 : new wxGLContext( isRGB, win, *palette );
  OUTPUT: RETVAL

void
wxGLContext::SetCurrent()

void
wxGLContext::SetColour( colour )
    wxString colour

void
wxGLContext::SwapBuffers()

