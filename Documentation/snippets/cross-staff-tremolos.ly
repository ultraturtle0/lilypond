%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.31"

\header {
%% Translation of GIT committish: a5bde6d51a5c88e952d95ae36c61a5efc22ba441

  texidoces = "

Dado que @code{\\repeat tremolo} espera exactamente dos argumentos
musicales para los trémolos de acorde, la nota o acorde que cambia de
pentagrama en un trémolo que cruza el pentagrama se debe colocar
dentro de llaves curvas junto a su instrucción @code{\\change Staff}.

"

  doctitlees = "Trémolos de pentagrama cruzado"

  lsrtags = "repeats, keyboards"


%% Translation of GIT committish: a5bde6d51a5c88e952d95ae36c61a5efc22ba441
  texidocfr = "
Dans la mesure où @code{\\repeat tremolo} requiert deux arguments
musicaux pour un trémolo d'accords, la note ou l'accord de la
portée opposée doît être encadré par des accolades et se voir adjoindre
la commande @code{\\change Staff}.

"
  doctitlefr = "Trémolo et changement de portée"


  texidoc = "
Since @code{\\repeat tremolo} expects exactly two musical arguments for
chord tremolos, the note or chord which changes staff within a
cross-staff tremolo should be placed inside curly braces together with
its @code{\\change Staff} command.

"
  doctitle = "Cross-staff tremolos"
} % begin verbatim

\new PianoStaff <<
  \new Staff = "up" \relative c'' {
    \key a \major
    \time 3/8
    s4.
  }
  \new Staff = "down" \relative c'' {
    \key a \major
    \time 3/8
    \voiceOne
    \repeat tremolo 6 {
      <a e'>32
      {
        \change Staff = "up"
        \voiceTwo
        <cis a' dis>32
      }
    }
  }
>>

