\score { 
  \context Voice \notes\relative c {
    % CASE 3
	d''4 ( ) b a ( ) e' \break
	g,( \stemdown ) b \stemboth c ( ) f, \break
	
	% no adjusting...
	\stemup [d'8 ( b a] \stemboth ) e' \break
	\stemup [g,8 ( b d] \stemboth ) c \break
	
	% still ugly
	g4 ( b d ) c \break
	
	%TIES
	d ~ b a ~ e' \break
	g, ~ \stemdown b \stemboth c ~ f, \break
	
	
  }
  \paper {
    linewidth=-1.0;
  }  
  \midi { }
}