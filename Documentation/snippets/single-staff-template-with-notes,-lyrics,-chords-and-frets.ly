%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "vocal-music, chords, template"

%% Translation of GIT committish: 91eeed36c877fe625d957437d22081721c8c6345
  texidoces = "
Presentamos a continuación un ejemplo de plantilla para una hoja
guía de acordes con melodía, letra, acordes y diagramas de
trastes.
"

  doctitlees = "Plantilla para un pentagrama único con música letra acordes y trastes"

  texidoc = "
Here is a simple lead sheet template with melody, lyrics, chords and
fret diagrams.

"
  doctitle = "Single staff template with notes lyrics chords and frets"
} % begin verbatim

verseI = \lyricmode {
  \set stanza = #"1."
  This is the first verse
}

verseII = \lyricmode {
  \set stanza = #"2."
  This is the second verse.
}

theChords = \chordmode {
  % insert chords for chordnames and fretboards here
  c2 g4 c
}

staffMelody = \relative c' {
   \key c \major
   \clef treble
   % Type notes for melody here
   c4 d8 e f4 g
   \bar "|."
}

\score {
  <<
    \context ChordNames { \theChords }
    \context FretBoards { \theChords }
    \new Staff {
      \context Voice = "voiceMelody" { \staffMelody }
    }
    \new Lyrics = "lyricsI" {
      \lyricsto "voiceMelody" \verseI
    }
    \new Lyrics = "lyricsII" {
      \lyricsto "voiceMelody" \verseII
    }
  >>
  \layout { }
  \midi { }
}

