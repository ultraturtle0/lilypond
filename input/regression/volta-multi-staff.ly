\header {

  texidoc = "By setting @code{voltaOnThisStaff}, repeats can be put
    also over other staves than the topmost one in a score."

}

\layout { raggedright = ##t }
\version "2.7.13"


vmus =  { \repeat volta 2 c1 \alternative { d e } } 



\relative c'' <<
  \new StaffGroup <<
    \context Staff \vmus
    \new Staff \vmus
  >>
  \new StaffGroup <<
    \new Staff <<
      \set Staff.voltaOnThisStaff = ##t
      \vmus >>
    \new Staff \vmus
  >>
>>



