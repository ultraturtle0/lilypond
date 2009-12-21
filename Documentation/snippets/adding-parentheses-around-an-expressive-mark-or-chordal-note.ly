%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "expressive-marks"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
La función @code{\\parenthesize} es un truco especial que encierra
objetos entre paréntesis.  El grob asociado es
@code{Score.ParenthesesItem}.

"
  doctitlees = "Encerrar entre paréntesis una marca expresiva o una nota de un acorde"

  texidoc = "
The @code{\\parenthesize} function is a special tweak that encloses
objects in parentheses.  The associated grob is
@code{Score.ParenthesesItem}.

"
  doctitle = "Adding parentheses around an expressive mark or chordal note"
} % begin verbatim

\relative c' {
  c2-\parenthesize ->
  \override ParenthesesItem #'padding = #0.1
  \override ParenthesesItem #'font-size = #-4
  <d \parenthesize f a>2
}


