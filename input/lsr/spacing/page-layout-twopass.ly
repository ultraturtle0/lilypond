\version "2.10.12"

\header { texidoc = "
Page breaking details can be stored for later reference.

(you should run this snippet on your own computer; we cannot compute
the two-pass layout here)
" }

\paper  {
  #(define write-page-layout #t)
}

bla = \new Staff {
  c1 c1
  \break
  \grace { c16 } c1\break
  \repeat unfold 5 \relative { c1 c1 c1 }
}


\book {
  \score {
    \bla
    \layout {
      #(define tweak-key "blabla")
    }
  }
}

tweakFileName = #(format "~a-page-layout.ly" (ly:parser-output-name parser))

#(newline)

#(ly:progress "Contents of: '~a'" (ly:gulp-file tweakFileName))
