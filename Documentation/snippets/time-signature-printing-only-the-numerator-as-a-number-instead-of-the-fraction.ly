%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "rhythms, tweaks-and-overrides"

  texidoc = "
Sometimes, a time signature should not print the whole fraction (e.g.
7/4), but only the numerator (7 in this case). This can be easily done
by using \\override Staff.TimeSignature #'style = #'single-digit to
change the style permanently. By using \\revert Staff.TimeSignature
#'style, this setting can be reversed. To apply the single-digit style
to only one time signature, use the \\override command and prefix it
with a \\once.

"
  doctitle = "Time signature printing only the numerator as a number (instead of the fraction)"
} % begin verbatim

\relative c'' {
  \time 3/4
  c4 c c
  % Change the style permanently
  \override Staff.TimeSignature #'style = #'single-digit
  \time 2/4
  c c
  \time 3/4
  c c c
  % Revert to default style:
  \revert Staff.TimeSignature #'style
  \time 2/4
  c c
  % single-digit style only for the next time signature
  \once \override Staff.TimeSignature #'style = #'single-digit
  \time 5/4
  c c c c c
  \time 2/4
  c c
}
