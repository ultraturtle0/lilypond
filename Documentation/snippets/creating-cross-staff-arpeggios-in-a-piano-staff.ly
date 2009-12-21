%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "expressive-marks"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Dentro de un @code{PianoStaff}, es posible hacer que un arpegio
cruce entre los pentagramas ajustando la propiedad
@code{PianoStaff.connectArpeggios}.

"
  doctitlees = "Crear arpegios que se cruzan entre pentagramas dentro de un sistema de piano"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
texidocde = "
Arpeggio über mehrere Systeme können in anderen Kontexten als dem
@code{PianoStaff} erstellt werden, wenn der @code{Span_arpeggio_engraver}
in den @code{Score}-Kontext eingefügt wird.

"
  doctitlede = "Arpeggio über mehrere Systeme in anderen Kontexten"
%% Translation of GIT committish: ae814f45737bd1bdaf65b413a4c37f70b84313b7
  texidocfr = "
Dans une double portée pour piano (@code{PianoStaff}), un arpège peut
s'étendre sur les deux portées grâce à la propriété 
@code{PianoStaff.connectArpeggios}.

"
  doctitlefr = "Arpège distribué sur une partition pour piano"


  texidoc = "
In a @code{PianoStaff}, it is possible to let an arpeggio cross between
the staves by setting the property @code{PianoStaff.connectArpeggios}.


"
  doctitle = "Creating cross-staff arpeggios in a piano staff"
} % begin verbatim

\new PianoStaff \relative c'' <<
  \set PianoStaff.connectArpeggios = ##t
  \new Staff {
    <c e g c>4\arpeggio
    <g c e g>4\arpeggio
    <e g c e>4\arpeggio
    <c e g c>4\arpeggio
  }
  \new Staff {
    \clef bass
    \repeat unfold 4 {
      <c,, e g c>4\arpeggio
    }
  }
>>

