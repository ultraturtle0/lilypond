%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "expressive-marks, staff-notation, editorial-annotations, tweaks-and-overrides"

  texidoc = "
This method prints two 'rehearsal marks', one on top of the other. It
shifts the lower rehearsal mark below the staff and then adds padding
above it in order to place the upper rehearsal mark above the staff.

By adjusting the extra-offset and baseline-skip values you can increase
or decrease the overall space between the rehearsal mark and the staff.

Because nearly every type of glyph or string can be made to behave like
a rehearsal mark it is possible to centre those above and below a bar
line.

Adding the appropriate 'break visibility' as shown in snippet 1 will
allow you to position two marks at the end of a line as well.

Note: Method 1 is less complex than Method 2 but does not really allow
for fine tuning of placement of one of the rehearsal marks without
affecting the other.  It may also give some problems with vertical
spacing, since using @code{extra-offset} does not change the bounding
box of the mark from its original value.



"
  doctitle = "How to print two rehearsal marks above and below the same barline (method 1)"
} % begin verbatim

\relative c'{
    c d e f |
    \once \override Score.RehearsalMark #'extra-offset = #'(0 . -8.5)
    \once \override Score.RehearsalMark #'baseline-skip = #9
    \mark \markup \center-column { \circle 1 \box A }
    g f e d |
    \once \override Score.RehearsalMark #'extra-offset = #'(0 . -8.5)
    \once \override Score.RehearsalMark #'baseline-skip = #9
    \mark \markup \center-column { \flat { \bold \small \italic Fine. } }
    g f e d |
    \once \override Score.RehearsalMark #'extra-offset = #'(0 . -8.5)
    \once \override Score.RehearsalMark #'baseline-skip = #9
    \override Score.RehearsalMark #'break-visibility = #begin-of-line-invisible
    \mark \markup \center-column { \musicglyph #"scripts.ufermata" \box z }
}
