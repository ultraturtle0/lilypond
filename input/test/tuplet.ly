\score { 
  \context Voice \notes\relative c {
    \property Voice.textEmptyDimension = 1
	\property Voice.textScriptPadding = 10
	\property Voice.tupletVisibility = 0
	\times2/3{c'4^"tupletVisibility = 0" d e} \times2/3{[f8 g a]} 
	  \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 1
	\times2/3{c,4^"tupletVisibility = 1" d e} \times2/3{[f8 g a]} 
	  \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 2
	\times2/3{c,4^"tupletVisibility = 2" d e} \times2/3{[f8 g a]} 
	  \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 3
	\times2/3{c,4^"tupletVisibility = 3" d e} \times2/3{[f8 g a]} 
	  \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 4
	\times2/3{c,4^"tupletVisibility = 4" d e} \times2/3{[f8 g a]} 
	  \times2/3{b16 c d} c8 | \break
	
	\property Voice.tupletDirection = \down
	\property Voice.tupletVisibility = 0
	\times2/3{c,4^"tupletDirection = down" d e} 
	  \times2/3{[[f8 g a]]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 1
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 2
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 3
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 4
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |\break
	
	\property Voice.tupletDirection = \up
	\property Voice.tupletVisibility = 0
	\times2/3{c,4^"tupletDirection = up" d e} 
	  \times2/3{[[f8 g a]]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 1
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 2
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 3
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |
	\property Voice.tupletVisibility = 4
	\times2/3{c,4 d e} \times2/3{[f8 g a]} \times2/3{b16 c d} c8 |
	
  }
  \paper { }  
  \midi { }
}