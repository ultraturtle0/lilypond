%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
 doctitlees = "Cambiar el número del grupo especial"
 texidoces = "

De forma predeterminada sólo se imprime el numerador del grupo
especial sobre el corchete de grupo, es decir, el denominador del
argumento de la instrucción @code{\\times}. De forma alternativa, se
puede imprimr un quebrado en la forma numerador:denominador del número
del grupo, o eliminar el número.

"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
texidocde = "
Standardmäßig wird nur der Zähler des N-tolen-Bruchs über der Klammer
dargestellt, wie er dem @code{\\times}-Befehl übergeben wird.
Man kann aber auch Zähler/Nenner ausgeben lassen, oder die Zahl
vollständig unterdrücken.

"
  doctitlede = "Die Zahl der N-tole verändern"


%% Translation of GIT committish: e71f19ad847d3e94ac89750f34de8b6bb28611df
  texidocfr = "
L'apparence du chiffre est déterminée par la propriété @code{text} dans
@code{TupletNumber}.  La valeur par défaut imprime seulement le
dénominateur, mais si elle est définie par la fonction
@code{tuplet-number::calc-fraction-text}, la fraction entière
@var{num}:@var{den} sera imprimée à la place.

"
  doctitlefr = "Modifier l'apparence du chiffre de nolet"

  texidoc = "
By default, only the numerator of the tuplet number is printed over the
tuplet bracket, i.e., the denominator of the argument to the
@code{\\times} command. Alternatively, num:den of the tuplet number may
be printed, or the tuplet number may be suppressed altogether.

"
  doctitle = "Changing the tuplet number"
} % begin verbatim

\relative c'' {
  \times 2/3 { c8 c c }
  \times 2/3 { c8 c c }
  \override TupletNumber #'text = #tuplet-number::calc-fraction-text
  \times 2/3 { c8 c c }
  \override TupletNumber #'stencil = ##f
  \times 2/3 { c8 c c }
}

