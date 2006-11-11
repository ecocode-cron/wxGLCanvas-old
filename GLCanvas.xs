/////////////////////////////////////////////////////////////////////////////
// Name:        GLCanvas.xs
// Purpose:     XSor Wx::GLCanvas.pm
// Author:      Mattia Barbon
// Modified by:
// Created:     26/07/2003
// RCS-ID:      $Id: GLCanvas.xs,v 1.6 2006/11/11 16:14:17 mbarbon Exp $
// Copyright:   (c) 2003, 2005 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define STRICT

#include <wx/defs.h>
#include "wx/window.h"
#include "cpp/wxapi.h"
#include "cpp/overload.h"
#include "cpp/ovl_const.h"
#include "cpp/ovl_const.cpp"

#undef THIS

#if WXPERL_W_VERSION_GE( 2, 5, 0 ) && wxUSE_GLCANVAS
    #include <wx/glcanvas.h>
#else
    #ifdef __WXMSW__
        #undef  wxUSE_GLCANVAS
        #define wxUSE_GLCANVAS 1
        #define WXDLLIMPEXP_GL

        #include "wx/myglcanvas.h"
        #include "wx/glcanvas.cpp"
    #else
        #include <wx/glcanvas.h>
    #endif
#endif

MODULE=Wx__GLCanvas PACKAGE=Wx::GLCanvas

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

## DECLARE_OVERLOAD( wglx, Wx::GLContext )
## DECLARE_OVERLOAD( wglc, Wx::GLCanvas )

void
wxGLCanvas::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_n_wpoi_wsiz_n_s, newDefault, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_wglx_n_wpoi_wsiz_n_s, newContext, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_wglc_n_wpoi_wsiz_n_s, newCanvas, 2 )
    END_OVERLOAD( Wx::GLCanvas::new )

static wxGLCanvas*
wxGLCanvas::newDefault( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxGLCanvasName )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxGLCanvas( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

static wxGLCanvas*
wxGLCanvas::newContext( parent, context, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxGLCanvasName )
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

static wxGLCanvas*
wxGLCanvas::newCanvas( parent, canvas, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxGLCanvasName )
    wxWindow* parent
    wxGLCanvas* canvas
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxGLCanvas( parent, canvas, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxGLContext*
wxGLCanvas::GetContext()

void
wxGLCanvas::SetCurrent()

#ifdef __WXMSW__

void
wxGLCanvas::SetupPalette( palette )
    wxPalette* palette
  CODE:
    THIS->SetupPalette( *palette );

#endif

void
wxGLCanvas::SwapBuffers()

MODULE=Wx__GLCanvas PACKAGE=Wx::GLContext

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

wxGLContext*
wxGLContext::new(win, cxt = NULL )
    wxGLCanvas* win
    wxGLContext* cxt
  CODE:
    RETVAL = cxt ? new wxGLContext( win, cxt )
                 : new wxGLContext( win );
  OUTPUT: RETVAL

#else

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

#endif

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

void
wxGLContext::SetCurrent( wxGLCanvas* canvas )
  C_ARGS: *canvas

#else

void
wxGLContext::SetCurrent()

void
wxGLContext::SwapBuffers()

#endif

#if WXPERL_W_VERSION_LE( 2, 7, 0 )

void
wxGLContext::SetColour( colour )
    wxString colour

#endif
