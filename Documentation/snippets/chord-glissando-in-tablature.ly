% DO NOT EDIT this file manually; it is automatically
% generated from Documentation/snippets/new
% Make any changes in Documentation/snippets/new/
% and then run scripts/auxiliar/makelsr.py
%
% This file is in the public domain.
%% Note: this file works from version 2.13.53
\version "2.14.0"

\header {
%% Translation of GIT committish: 69d7781c6ab26df02bc81ff1eb294d47fa673491

  texidoces = "
Los deslizamientos para acordes se pueden indicar tanto en el contexto
Staff como en TabStaff.  Los números de cuerda son necesarios para
TabStaff porque los cálculos de cuerda automáticos son diferentes para
los acordes y para notas sueltas, y @code{\\chordGlissando} traza
líneas entre las notas individuales.

"

  doctitlees = "Glissando de acordes en tablatura"
  lsrtags = "fretted-strings"
  texidoc = "
Slides for chords can be indicated in both Staff and TabStaff.
String numbers are necessary for TabStaff because automatic
string calculations are different for chords and for single notes,
and @code{\\chordGlissando} draws lines between single notes.
"
  doctitle = "Chord glissando in tablature"
} % begin verbatim


myMusic = \relative c' {
  \chordGlissando
  <c\3 e\2 g\1>8 <f\3 a\2 c\1>
}

\score {
  <<
    \new Staff {
      \clef "treble_8"
      \myMusic
    }
    \new TabStaff {
      \myMusic
    }
  >>
}
