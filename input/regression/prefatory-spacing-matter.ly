
\version "2.7.13"
\header {

  texidoc = "Distances between prefatory items (e.g. clef, bar,
etc.)  are determined by engraving standards.  These distances depend
on which items are combined.  Mid-line, the order for clef and
bar-line is different from the start of line.
"

}

\layout  {
  raggedright = ##t
}

\relative c'' {
  \set Staff.instrument = "fobar"
  \bar "||:"
  \key cis \major
  cis4 cis4 cis4 cis4 \clef bass  cis,1
  \clef treble
  \bar ":|"
  \key g \minor
  c1
}



