\version "2.7.13"
\header
{
  texidoc = "Symmetric figures should lead to symmetric slurs."

}

\layout{
  raggedright = ##t
}


\relative c'<<
  \time 6/8
  \context Staff{
    e8(e e) e(d e) e(c e) e(b e)
  }
  \new Staff{
    f'8(f f) f(g f) f(a f) f(b f)
  }
>>



