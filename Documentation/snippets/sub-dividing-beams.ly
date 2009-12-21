%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Las barras de semicorcheas (o notas más breves) seguidas no se
subdividen de forma predeterminada.  Esto es: las tres (o más)
barras se prolongan, sin dividirse, sobre grupos completos de
notas.  Este comportamiento se puede modificar para que las barras
se subdividan en subgrupos mediante el establecimiento de la
propiedad @code{subdivideBeams}.  Cuando está establecida, las
diversas barras se subdividen a intervalos definidos por el valor
actual de la longitud del pulso @code{beatLength} reduciendo las
barras múltiples a una sola entre los subgrupos.  Observe que el
valor predeterminado de @code{beatLength} es de una unidad sobre
el denominador del compás en curso, si no está establecido
explícitamente.  Se debe establecer al valor de una fracción que
da la duración el subgrupo de barras utilizando la función
@code{make-moment}, como se muestra aquí:

"
  doctitlees = "Subdivisión de las barras de semicorchea"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Die Balken von aufeinanderfolgenden Sechszehnteln (oder kürzeren Notenwerten)
werden standardmäßig nicht unterteilt.  Dieses Verhalten kann verändert
werden, sodass die Balken in Untergruppen aufgeteilt werden, indem man
die Eigenschaft @code{subdivideBeams} verändert.  Man muss die Unterteilungsintervalle
als Notenbruch mit der @code{make-moment}-Funktion für @code{beatLength} angeben,
damit die Balken unterbrochen wird und nur ein Balken durchgezogen bleibt.  Der
Standardwert für @code{beatLength} ist 1 / Zähler des aktuellen Taktes.

"
  doctitlede = "Balken in Untergruppen teilen"


%% Translation of GIT committish: b3196fadd8f42d05ba35e8ac42f7da3caf8a3079
  texidocfr = "
Les ligatures d'une succession de notes de durée inférieure à la croche
ne sont pas subdivisées par défaut.  Autrement dit, tous les traits de
ligature seront continus.  Ce comportement peut être modifié afin de
diviser la ligature en sous-groupes grâce à la propriété
@code{subdivideBeams}.  Lorsqu'elle est activée, les ligatures seront
subdivisées selon un intervalle défini par @code{beatLength} ; il n'y
aura alors plus qu'un seul trait de ligature entre chaque sous-groupe.
Par défaut, @code{beatLength} fixe la valeur de référence à une noire.
Il faudra donc lui fournir, à l'aide de la fonction @code{make-moment},
une fraction correspondant au sous-groupe désiré, comme dans l'exemple
suivant.

"
  doctitlefr = "Subdivision des ligatures"

  texidoc = "
The beams of consecutive 16th (or shorter) notes are, by default, not
sub-divided.  That is, the three (or more) beams stretch unbroken over
entire groups of notes.  This behavior can be modified to sub-divide
the beams into sub-groups by setting the property
@code{subdivideBeams}. When set, multiple beams will be sub-divided at
intervals defined by the current value of @code{beatLength} by reducing
the multiple beams to just one beam between the sub-groups. Note that
@code{beatLength} defaults to one over the denominator of the current
time signature if not set explicitly. It must be set to a fraction
giving the duration of the beam sub-group using the @code{make-moment}
function, as shown here:



"
  doctitle = "Sub-dividing beams"
} % begin verbatim

\relative c'' {
  c32[ c c c c c c c]
  \set subdivideBeams = ##t
  c32[ c c c c c c c]

  % Set beam sub-group length to an eighth note
  \set beatLength = #(ly:make-moment 1 8)
  c32[ c c c c c c c]

  % Set beam sub-group length to a sixteenth note
  \set beatLength = #(ly:make-moment 1 16)
  c32[ c c c c c c c]
}

