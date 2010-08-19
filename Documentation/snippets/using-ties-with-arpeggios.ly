%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.29"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
 doctitlees = "Uso de ligaduras en los arpegios"
 texidoces = "
En ocasiones se usan ligaduras de unión para escribir los arpegios.
En este caso, las dos notas ligadas no tienen que ser consecutivas.
Esto se puede conseguir estableciendo la propiedad
@code{tieWaitForNote} al valor @code{#t}.  La misma funcionalidad
es de utilidad, por ejemplo, para ligar un trémolo a un acorde, pero
en principio también se puede usar para notas normales consecutivas.

"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
 texidocde = "
 Überbindungen werden teilweise benutzt, um Arpeggios zu notieren.  In
 diesem Fall stehen die übergebundenen Noten nicht unbedingt hintereinander.
Das Verhalten kann erreicht werden, indem die @code{tieWaitForNote}-Eigenschaft
auf @code{#t} gesetzt wird.  Diese Funktion ist auch sinnvoll, um etwa
ein Tremolo mit einem Akkord zu überbinden, kann aber prinzipiell auch
für normale Überbindungen eingesetzt werden
"
  doctitlede = "Überbingungen für Arpeggio genutzen"



%% Translation of GIT committish: 4da4307e396243a5a3bc33a0c2753acac92cb685
  texidocfr = "
Les liaisons de tenue servent parfois à rendre un accord arpégé. Dans
ce cas, les notes liées ne sont pas toutes consécutives. Il faut alors
assigner à la propriété @code{tieWaitForNote} la valeur @code{#t}
(@emph{true} pour @qq{vrai}).  Cette même méthode peut servir, par
exemple, à lier un trémolo à un accord.
"
  doctitlefr = "Liaison de tenue et arpège"

  texidoc = "
Ties are sometimes used to write out arpeggios.  In this case, two tied
notes need not be consecutive.  This can be achieved by setting the
@code{tieWaitForNote} property to @code{#t}.  The same feature is also
useful, for example, to tie a tremolo to a chord, but in principle, it
can also be used for ordinary consecutive notes.

"
  doctitle = "Using ties with arpeggios"
} % begin verbatim

\relative c' {
  \set tieWaitForNote = ##t
  \grace { c16[ ~ e ~ g] ~ } <c, e g>2
  \repeat tremolo 8 { c32 ~ c' ~ } <c c,>1
  e8 ~ c ~ a ~ f ~ <e' c a f>2
  \tieUp
  c8 ~ a
  \tieDown
  \tieDotted
  g8 ~ c g2
}

