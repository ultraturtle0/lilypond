\header {
% this example doesn't look very useful.  Perhaps remove it in
% the future, although it _does_ demonstrate a neat feature of
% lilypond.  Maybe regression?  Or a "neat features" page
% (one of the intro pages, maybe?)
% OTOH, this is probably a basic lesson for engraving music,
% so it might not be worth advertising it.  :)
texidoc = "@cindex Beam Damp
Beams are less steep than the notes they encompass.
" }

\version "1.7.18"
\score{
	\notes\relative c''{
%		\stemUp
%		 a16-[ b b c]
%		 c-[ b b a]
%		\stemDown
%		 c-[ b b a]
%		 a-[ b b c]
		\stemUp
		 g16-[ a b c]
		 c-[ b a g]
		\stemDown
		 d'-[ c b a]
		 a-[ b c d]
	}
	\paper{
		raggedright = ##t
	}
}

%% new-chords-done %%
