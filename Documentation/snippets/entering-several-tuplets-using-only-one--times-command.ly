%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.29"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: 0b55335aeca1de539bf1125b717e0c21bb6fa31b
 doctitlees = "Escribir varios grupos especiales usando una sola instrucción \\times"
 texidoces = "
La propiedad @code{tupletSpannerDuration} establece cuánto debe durar
cada grupo de valoración especial contenido dentro del corchete que
aparece después de @code{\\times}.  Así, se pueden escribir muchos
tresillos seguidos dentro de una sola expresión @code{\\times},
ahorrando trabajo de teclado.

En el ejemplo se muestran dos tresillos, aunque se ha escrito
@code{\\times} una sola vez.


Para ver más inforamción sobre @code{make-moment}, véase la sección
correspondiente del manual de Referencia de la Notación.

"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Die Eigenschaft @code{tupletSpannerDuration} bestimmt, wie lange jede
der N-tolen innerhalb der Klammern nach dem @code{\\times}-Befehl
dauert.  Auf diese Art können etwa viele Triolen nacheinander mit nur
einem @code{\\times}-Befehl geschrieben werden.

Im Beispiel sind zwei Triolen zu sehen, obwohl @code{\\times} nur
einmal geschrieben wurde.

Mehr Information über @code{make-moment} gibt es in \"Verwaltung der Zeiteinheiten\".

"
  doctitlede = "Mehrere Triolen notieren aber nur einmal \\times benutzen"



%% Translation of GIT committish: 4ab2514496ac3d88a9f3121a76f890c97cedcf4e
  texidocfr = "
La propriété @code{tupletSpannerDuration} spécifie la longueur voulue de
chaque crochet.  Avec elle, vous pouvez faire plusieurs nolets en ne
tapant @code{\\times} qu'une fois, ce qui évite une longue saisie.

Dans l'exemple suivant, deux triolets sont imprimés avec une seule fonction
@code{\\times}.

Pour plus d'information sur @code{make-moment}, voir la section
appropriée du manuel de notation.

"
  doctitlefr = "Plusieurs triolets avec une seule commande \\times"

  texidoc = "
The property @code{tupletSpannerDuration} sets how long each of the
tuplets contained within the brackets after @code{\\times} should last.
Many consecutive tuplets can then be placed within a single
@code{\\times} expression, thus saving typing.

In the example, two triplets are shown, while @code{\\times} was
entered only once.


Read the relevant sections of the Notation Reference for more
information about @code{ly:make-moment}.

"
  doctitle = "Entering several tuplets using only one \\times command"
} % begin verbatim

\relative c' {
  \time 2/4
  \set tupletSpannerDuration = #(ly:make-moment 1 4)
  \times 2/3 { c8 c c c c c }
}

