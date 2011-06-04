\header {

  texidoc = "in collisions, the stems of outer voice are added to the
  dot support of the inner voices."

}

\version "2.14.0"

\layout { ragged-right = ##t }

\new Staff {
  \key e \major \time 3/4
  \relative c'' {
    << { dis4.  } \\
       { fis,4 } \\ { b4 } >>
  }
}
