\score { 
  \context Voice \notes\relative c {
    % this used to work:
	% <{\voiceone e}
	% {\voicetwo c}>
	
	% now we need:
	\context Staff
	<{\voiceone e}
	{\voicetwo c}>
	
	
	\version "1.0.21"; 
	
  }
  \paper { }  
  \midi { }
}