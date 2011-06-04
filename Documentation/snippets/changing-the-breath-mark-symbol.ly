%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "expressive-marks"

%% Translation of GIT committish: 91eeed36c877fe625d957437d22081721c8c6345
  texidoces = "
El glifo de la marca de respiración se puede ajustar
sobreescribiendo la propiedad de texto del objeto de presentación
@code{BreathingSign}, con cualquier otro texto de marcado.

"
  doctitlees = "Cambiar el símbolo de la marca de respiración"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Das Schriftzeichen für das Atemzeichen kann verändert werden, indem
die Text-Eigenschaft des @code{BreathingSign}-Layoutobjekts mit einer
beliebigen Textbeschriftung definiert wird.

"
  doctitlede = "Das Atemzeichen-Symbol verändern"

%% Translation of GIT committish: 217cd2b9de6e783f2a5c8a42be9c70a82195ad20
  texidocfr = "
On peut choisir le glyphe imprimé par cette commande, en modifiant la
propriété @code{text} de l'objet @code{BreathingSign}, pour lui affecter
n'importe quelle indication textuelle.

"
  doctitlefr = "Modification de l'indicateur de respiration"


  texidoc = "
The glyph of the breath mark can be tuned by overriding the text
property of the @code{BreathingSign} layout object with any markup
text.

"
  doctitle = "Changing the breath mark symbol"
} % begin verbatim

\relative c'' {
  c2
  \override BreathingSign #'text = \markup { \musicglyph #"scripts.rvarcomma" }
  \breathe
  d2
}
