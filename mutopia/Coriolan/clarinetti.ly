\header{
filename =	 "clarinetti.ly";
% %title =	 "Ouvert\\"ure zu Collins Trauerspiel \\"Coriolan\\" Opus 62";
description =	 "";
composer =	 "Ludwig van Beethoven (1770-1827)";
enteredby =	 "JCN";
copyright =	 "public domain";


}

\version "1.3.59";

\include "clarinetto-1.ly"
\include "clarinetto-2.ly"

clarinettiStaff = \context Staff = clarinetti <
	\property Staff.midiInstrument = #"clarinet"
	\property Staff.instrument = #"2 Clarinetti\n(B\\textflat)"
	\property Staff.instr = #"Cl.\n(B\\textflat)"
	% urg: can't; only My_midi_lexer:<non-static> () parses pitch?
	%\property Staff.transposing = "bes"
	\property Staff.transposing = #-2
	\time 4/4;
	\notes \key f \major;
	\skip 1*314; \bar "|.";
	\context Voice=one \partcombine Voice
		\context Thread=one \clarinettoI
		\context Thread=two  \clarinettoII
>

