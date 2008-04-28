%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.38"

\header {
  lsrtags = "vocal-music, unfretted-strings, midi"

  texidoc = "
Problem: How to know which @code{midiInstrument} would be best for your
composition?Solution: A LilyPond demo file.



"
  doctitle = "Demo MidiInstruments"
} % begin verbatim
\header {
  title = "Demo of all midi sounds"
  arranger = "Myself "
}

basemelodie = \relative c' {
  c4. \mf g  c16 b' c d |
  e d e f g4 g'4 r |
  r1
}
melodie = { \tempo 4 = 150 \basemelodie }

\score {
  \new Staff <<
    \new Voice { \melodie 
    }
  >>
  \layout { }
}

\score { 
  \new Staff <<
    %\set Staff.instrumentName= "S/A"
    %\set Staff.midiMinimumVolume = #0.2 
    %\set Staff.midiMaximumVolume = #0.4
    %\set Voice.dynamicAbsoluteVolumeFunction = #0.6
    \new Voice { r \mf
      \set Staff.midiInstrument = "acoustic grand" \melodie
      \set Staff.midiInstrument = "bright acoustic" \melodie
      \set Staff.midiInstrument = "electric grand" \melodie
      \set Staff.midiInstrument = "honky-tonk" \melodie
      \set Staff.midiInstrument = "electric piano 1" \melodie
      \set Staff.midiInstrument = "electric piano 2" \melodie
      \set Staff.midiInstrument = "harpsichord" \melodie
      \set Staff.midiInstrument = "clav" \melodie
      \set Staff.midiInstrument = "celesta" \melodie
      \set Staff.midiInstrument = "glockenspiel" \melodie
      \set Staff.midiInstrument = "music box" \melodie
      \set Staff.midiInstrument = "vibraphone" \melodie
      \set Staff.midiInstrument = "marimba" \melodie
      \set Staff.midiInstrument = "xylophone" \melodie
      \set Staff.midiInstrument = "tubular bells" \melodie
      \set Staff.midiInstrument = "dulcimer" \melodie
      \set Staff.midiInstrument = "drawbar organ" \melodie
      \set Staff.midiInstrument = "percussive organ" \melodie
      \set Staff.midiInstrument = "rock organ" \melodie
      \set Staff.midiInstrument = "church organ" \melodie
      \set Staff.midiInstrument = "reed organ" \melodie
      \set Staff.midiInstrument = "accordion" \melodie
      \set Staff.midiInstrument = "harmonica" \melodie
      \set Staff.midiInstrument = "concertina" \melodie
      \set Staff.midiInstrument = "acoustic guitar (nylon)" \melodie
      \set Staff.midiInstrument = "acoustic guitar (steel)" \melodie
      \set Staff.midiInstrument = "electric guitar (jazz)" \melodie
      \set Staff.midiInstrument = "electric guitar (clean)" \melodie
      \set Staff.midiInstrument = "electric guitar (muted)" \melodie
      \set Staff.midiInstrument = "overdriven guitar" \melodie
      \set Staff.midiInstrument = "distorted guitar" \melodie
      \set Staff.midiInstrument = "acoustic bass" \melodie
      \set Staff.midiInstrument = "electric bass (finger)" \melodie
      \set Staff.midiInstrument = "electric bass (pick)" \melodie
      \set Staff.midiInstrument = "fretless bass" \melodie
      \set Staff.midiInstrument = "slap bass 1" \melodie
      \set Staff.midiInstrument = "slap bass 2" \melodie
      \set Staff.midiInstrument = "synth bass 1" \melodie
      \set Staff.midiInstrument = "synth bass 2" \melodie
      \set Staff.midiInstrument = "violin" \melodie
      \set Staff.midiInstrument = "viola" \melodie
      \set Staff.midiInstrument = "cello" \melodie
      \set Staff.midiInstrument = "contrabass" \melodie
      \set Staff.midiInstrument = "tremolo strings" \melodie
      \set Staff.midiInstrument = "pizzicato strings" \melodie
      \set Staff.midiInstrument = "orchestral strings" \melodie
      \set Staff.midiInstrument = "timpani" \melodie
      \set Staff.midiInstrument = "string ensemble 1" \melodie
      \set Staff.midiInstrument = "string ensemble 2" \melodie
      \set Staff.midiInstrument = "synthstrings 1" \melodie
      \set Staff.midiInstrument = "synthstrings 2" \melodie
      \set Staff.midiInstrument = "choir aahs" \melodie
      \set Staff.midiInstrument = "voice oohs" \melodie
      \set Staff.midiInstrument = "synth voice" \melodie
      \set Staff.midiInstrument = "orchestra hit" \melodie
      \set Staff.midiInstrument = "trumpet" \melodie
      \set Staff.midiInstrument = "trombone" \melodie
      \set Staff.midiInstrument = "tuba" \melodie
      \set Staff.midiInstrument = "muted trumpet" \melodie
      \set Staff.midiInstrument = "french horn" \melodie
      \set Staff.midiInstrument = "brass section" \melodie
      \set Staff.midiInstrument = "synthbrass 1" \melodie
      \set Staff.midiInstrument = "synthbrass 2" \melodie
      \set Staff.midiInstrument = "soprano sax" \melodie
      \set Staff.midiInstrument = "alto sax" \melodie
      \set Staff.midiInstrument = "tenor sax" \melodie
      \set Staff.midiInstrument = "baritone sax" \melodie
      \set Staff.midiInstrument = "oboe" \melodie
      \set Staff.midiInstrument = "english horn" \melodie
      \set Staff.midiInstrument = "bassoon" \melodie
      \set Staff.midiInstrument = "clarinet" \melodie
      \set Staff.midiInstrument = "piccolo" \melodie
      \set Staff.midiInstrument = "flute" \melodie
      \set Staff.midiInstrument = "recorder" \melodie
      \set Staff.midiInstrument = "pan flute" \melodie
      \set Staff.midiInstrument = "blown bottle" \melodie
      \set Staff.midiInstrument = "shakuhachi" \melodie
      \set Staff.midiInstrument = "whistle" \melodie
      \set Staff.midiInstrument = "ocarina" \melodie
      \set Staff.midiInstrument = "lead 1 (square)" \melodie
      \set Staff.midiInstrument = "lead 2 (sawtooth)" \melodie
      \set Staff.midiInstrument = "lead 3 (calliope)" \melodie
      \set Staff.midiInstrument = "lead 4 (chiff)" \melodie
      \set Staff.midiInstrument = "lead 5 (charang)" \melodie
      \set Staff.midiInstrument = "lead 6 (voice)" \melodie
      \set Staff.midiInstrument = "lead 7 (fifths)" \melodie
      \set Staff.midiInstrument = "lead 8 (bass+lead)" \melodie
      \set Staff.midiInstrument = "pad 1 (new age)" \melodie
      \set Staff.midiInstrument = "pad 2 (warm)" \melodie
      \set Staff.midiInstrument = "pad 3 (polysynth)" \melodie
      \set Staff.midiInstrument = "pad 4 (choir)" \melodie
      \set Staff.midiInstrument = "pad 5 (bowed)" \melodie
      \set Staff.midiInstrument = "pad 6 (metallic)" \melodie
      \set Staff.midiInstrument = "pad 7 (halo)" \melodie
      \set Staff.midiInstrument = "pad 8 (sweep)" \melodie
      \set Staff.midiInstrument = "fx 1 (rain)" \melodie
      \set Staff.midiInstrument = "fx 2 (soundtrack)" \melodie
      \set Staff.midiInstrument = "fx 3 (crystal)" \melodie
      \set Staff.midiInstrument = "fx 4 (atmosphere)" \melodie
      \set Staff.midiInstrument = "fx 5 (brightness)" \melodie
      \set Staff.midiInstrument = "fx 6 (goblins)" \melodie
      \set Staff.midiInstrument = "fx 7 (echoes)" \melodie
      \set Staff.midiInstrument = "fx 8 (sci-fi)" \melodie
      \set Staff.midiInstrument = "sitar" \melodie
      \set Staff.midiInstrument = "banjo" \melodie
      \set Staff.midiInstrument = "shamisen" \melodie
      \set Staff.midiInstrument = "koto" \melodie
      \set Staff.midiInstrument = "kalimba" \melodie
      \set Staff.midiInstrument = "bagpipe" \melodie
      \set Staff.midiInstrument = "fiddle" \melodie
      \set Staff.midiInstrument = "shanai" \melodie
      \set Staff.midiInstrument = "tinkle bell" \melodie
      \set Staff.midiInstrument = "agogo" \melodie
      \set Staff.midiInstrument = "steel drums" \melodie
      \set Staff.midiInstrument = "woodblock" \melodie
      \set Staff.midiInstrument = "taiko drum" \melodie
      \set Staff.midiInstrument = "melodic tom" \melodie
      \set Staff.midiInstrument = "synth drum" \melodie
      \set Staff.midiInstrument = "reverse cymbal" \melodie
      \set Staff.midiInstrument = "guitar fret noise" \melodie
      \set Staff.midiInstrument = "breath noise" \melodie
      \set Staff.midiInstrument = "seashore" \melodie
      \set Staff.midiInstrument = "bird tweet" \melodie
      \set Staff.midiInstrument = "telephone ring" \melodie
      \set Staff.midiInstrument = "helicopter" \melodie
      \set Staff.midiInstrument = "applause" \melodie
      \set Staff.midiInstrument = "gunshot" \melodie
    }
  >>
  \midi { }
}
