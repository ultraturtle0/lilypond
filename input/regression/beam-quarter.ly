
\version "2.7.13"
\header
{
  texidoc= "Quarter notes may be beamed: the beam is halted momentarily."
}

\layout { raggedright = ##t }

\relative c'' {
  c8[ c4 c8] % should warn here!
}
