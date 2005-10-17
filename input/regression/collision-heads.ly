\version "2.7.13"
\header {
  texidoc =

  "If @code{merge-differently-headed} is enabled, then
open note heads may be merged with black noteheads, but only
if the black note heads are from 8th or shorter notes.
"
  
}

\layout { raggedright= ##t }


\context Staff  \relative c'' <<
  {
    c2 c8 c4.
    
    \override Staff.NoteCollision  #'merge-differently-headed = ##t
    c2 c8 c4.
    c2
  }\\
  {
    c8 c4. c2
    
    c8 c4. c2
    c4
  }
>>
