
\version "2.1.18"
\header {
    texidoc = "Partcombiner and grace notes can go together."
}

\paper { raggedright= ##t }

\score {
    \new Staff
	    \partcombine 
	     \notes \relative c'' {
		c4 d e f  \grace f16 g1
	    }
	     \notes \relative c' {
		c4 d e2  g1
	    }
	
    
}

