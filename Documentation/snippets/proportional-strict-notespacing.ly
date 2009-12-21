%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "tweaks-and-overrides, spacing"

  texidoc = "
If @code{strict-note-spacing} is set spacing of notes is not influenced
by bars or clefs within a system. Rather, they are placed just before
the note that occurs at the same time. This may cause collisions.

"
  doctitle = "Proportional strict notespacing"
} % begin verbatim

\relative c'' <<
  \override Score.SpacingSpanner #'strict-note-spacing = ##t
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 16)
  \new Staff {
    c8[ c \clef alto c c \grace { d16 } c8 c] c4
    c2 \grace { c16[ c16] } c2
  }
  \new Staff {
    c2 \times 2/3 { c8 \clef bass cis,, c } c4
    c1
  }
>>

