%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.29"

\header {
  lsrtags = "chords"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
  texidoces = "
La presentación del acorde de séptima mayor se
puede ajustar mediante majorSevenSymbol.

"
  doctitlees = "Nombre de acorde maj7"


%% Translation of GIT committish: 134d9cb2e14ae624aec6fa2dd1630e284807dc42
 texidocde = "
Das Aussehen des großen Septakkords kann mit @code{majorSevenSymbol} verändert werden.

"

  doctitlede = "Akkordbezeichnung maj7"



  texidoc = "
The layout of the major 7 can be tuned with @code{majorSevenSymbol}.

"
  doctitle = "chord name major7"
} % begin verbatim

\chords {
  c:7+
  \set majorSevenSymbol = \markup { j7 }
  c:7+
}

