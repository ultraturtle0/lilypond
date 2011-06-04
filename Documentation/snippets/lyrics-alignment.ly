%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "text, vocal-music"

%% Translation of GIT committish: 91eeed36c877fe625d957437d22081721c8c6345
  texidoces = "
La alineación horizontal de la letra se puede ajustar sobreescribiendo
la propiedad @code{self-alignment-X} del objeto @code{LyricText}.
@code{#-1} es izquierda, @code{#0} es centrado y @code{#1} es derecha;
sin embargo, puede usar también @code{#LEFT}, @code{#CENTER} y
@code{#RIGHT}.

"
  doctitlees = "Alineación de la letra"

%% Translation of GIT committish: 27b1197f3bae8512c14d946752cd3e40e7c76016

  texidocde = "
Die horizontale Ausrichtung von Gesangstext kann eingestellt werden, indem
man die @code{self-alignment-X}-Eigenschaft des @code{LyricText}-Objekts
verändert.  @code{#-1} bedeutet links, @code{#0} bedeutet mittig und @code{#1}
bedeutet rechts, man kann aber genauso gut auch @code{#LEFT}, @code{#CENTER}
und @code{#RIGHT} benutzen.

"
  doctitlede = "Ausrichtung von Gesangstext"


%% Translation of GIT committish: c1d5bb448321d688185e0c6b798575d4c325ae80
  texidocfr = "
L'alignement horizontal des paroles peut se gérer à l'aide de la
propriété @code{self-alignment-X} de l'objet @code{LyricText}.
Les valeurs @code{#-1} ou @code{#LEFT} produiront un alignement par la
gauche, les valeurs @code{#0} ou @code{#CENTER} un alignement centré, et
les valeurs @code{#1} ou @code{#RIGHT} un alignement par la droite.

"
  doctitlefr = "Alignement des syllabes"


  texidoc = "
Horizontal alignment for lyrics cam be set by overriding the
@code{self-alignment-X} property of the @code{LyricText} object.
@code{#-1} is left, @code{#0} is center and @code{#1} is right;
however, you can use @code{#LEFT}, @code{#CENTER} and @code{#RIGHT} as
well.

"
  doctitle = "Lyrics alignment"
} % begin verbatim

\layout { ragged-right = ##f }
\relative c'' {
  c1
  c1
  c1
}
\addlyrics {
  \once \override LyricText #'self-alignment-X = #LEFT
  "This is left-aligned"
  \once \override LyricText #'self-alignment-X = #CENTER
  "This is centered"
  \once \override LyricText #'self-alignment-X = #1
  "This is right-aligned"
}

