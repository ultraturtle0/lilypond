%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "editorial-annotations"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
La dirección predeterminada de las plicas sobre la tercera línea
del pentagrama está determinada por la propiedad
@code{neutral-direction} del objeto @code{Stem}.

"
  doctitlees = "Dirección predeterminada de las plicas sobre la tercera línea del pentagrama"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Die Richtung von Hälsen auf der mittleren Linie kann mit der @code{Stem}-Eigenschaft
@code{neutral-direction} gesetzt werden.

"
  doctitlede = "Standardrichtung für Hälse auf der Mittellinie"

  texidoc = "
The default direction of stems on the center line of the staff is set
by the @code{Stem} property @code{neutral-direction}.

"
  doctitle = "Default direction of stems on the center line of the staff"
} % begin verbatim

\relative c'' {
  a4 b c b
  \override Stem #'neutral-direction = #up
  a4 b c b
  \override Stem #'neutral-direction = #down
  a4 b c b
}

