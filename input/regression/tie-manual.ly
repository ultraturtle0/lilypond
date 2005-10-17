\header {

  texidoc = "Tie formatting may be adjusted manually, by setting the
@code{tie-configuration} property. The override should be placed at
the second note of the chord."

}

\version "2.7.13"

\layout {
  raggedright = ##t
}


\relative c'' {
  
  <b d f g>~

  
  \once \override TieColumn #'tie-configuration =
     #'((0 . -1)  (2 . -1) (5.5 . 1) (7 . 1))

  <b d f g>
} 
