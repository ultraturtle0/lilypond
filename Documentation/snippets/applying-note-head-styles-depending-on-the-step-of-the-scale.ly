%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.10"

\header {
  lsrtags = "pitches, editorial-annotations"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  doctitlees = "Aplicar estilos de cabeza según la nota de la escala"
  texidoces = "
La propiedad @code{shapeNoteStyles} se puede usar para definir varios
estilos de cabezas de nota para cada grado de la escala (según esté
establecido por la armadura o por la propiedad \"tonic\").  Esta
propiedad requiere un conjunto de símbolos, que pueden ser puramente
arbitrarios (se permiten expresiones geométricas como @code{triangle},
triángulo, @code{cross}, aspas, y @code{xcircle}, círculo con aspas) o
basados en una antigua tradición americana de grabado (ciertos nombres
de nota latinos trambién se permiten).

Dicho esto, para imitar antiguos cancioneros americanos, existen varios
estilos predefinidos de cabezas de nota disponibles a través de
instrucciones de abreviatura como @code{\\aikenHeads} o
@code{\\sacredHarpHeads}.

Este ejemplo muestra distintas formas de obtener cabezas de notas con forma,
y muestra la capacidad de transportar una melodía sin perder la
correspondencia entre las funciones armónicas y los estilos de cabezas de
nota.

"

%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  doctitlede = "Notenkopfstile basierend auf der Tonleiterstufe erstellen"
  texidocde = "
Die @code{shapeNoteStyles}-(NotenFormenStile)-Eigenschaft kann benutzt
werden, um verschiedene Notenstile für jeden Schritt der Tonleiter
zu definieren (vorgegeben von der Tonart oder der @qq{tonic}
(Tonika)-Eigneschaft.  Diese Eigenschaft braucht eine Anzahl von Symbolen,
welche beliebig sein können (geometrische Ausdrücke wie @code{triangle}
(Dreieck), @code{cross} (Kreuz) und @code{xcircle} (X-Kreis) sind erlaubt)
oder basierend auf einer alten amerikanischen Notensatztradition (einige
lateinische Notenbezeichnungen sind auch erlaubt).

Um alte amerikanische Liederbücher zu imitieren, gibt es einige
vordefinierte Notenstile wie etwa @code{\\aikenHeads} (im Stil von Aiken)
oder @code{\\sacredHarpHeads} (im Stil der Sacred Harp-Tradition).

Dieses Beispiel zeigt, wie man unterschiedlich geformte Noten erhält und
eine Melodie transponieren kann, ohne dass das Verhältnis zwischen den
harmonischen Funktionen und dem Notenstil verloren geht.

"
%% Translation of GIT committish: 59968a089729d7400f8ece38d5bc98dbb3656a2b
  texidocfr = "
La propriété @code{shapeNoteStyles} permet d'affecter un profil
particulier à chaque degré de la gamme -- à partir de l'armure ou
de la propriété @code{tonic}.  Ses valeurs sont constituées d'une liste 
de symboles, qu'il s'agisse de formes géométriques (@code{triangle},
@code{cross}, ou @code{xcircle}) ou basés sur la tradition des graveurs
américains (avec quelques noms de note latins).

LilyPond dispose de deux raccourcis, @code{\aikenHeads} et
@code{\sacredHarpHeads}, permettant de reproduire déanciens recueils de
chansons américaines. 

L'exemple suivant montre plusieurs manières de profiler les têtes de
note, ainsi que la capacité de trnsposer tout en respectant la fonction
harmonique de chaque note dans la gamme. 

"
  doctitlefr = "Profilage des notes selon leur degré dans la gamme"


  texidoc = "
The @code{shapeNoteStyles} property can be used to define various note
head styles for each step of the scale (as set by the key signature or
the @code{tonic} property). This property requires a set of symbols,
which can be purely arbitrary (geometrical expressions such as
@code{triangle}, @code{cross}, and @code{xcircle} are allowed) or based
on old American engraving tradition (some latin note names are also
allowed).

That said, to imitate old American song books, there are several
predefined note head styles available through shortcut commands such as
@code{\\aikenHeads} or @code{\\sacredHarpHeads}.

This example shows different ways to obtain shape note heads, and
demonstrates the ability to transpose a melody without losing the
correspondence between harmonic functions and note head styles.

"
  doctitle = "Applying note head styles depending on the step of the scale"
} % begin verbatim

fragment = {
  \key c \major
  c2 d
  e2 f
  g2 a
  b2 c
}

\new Staff {
  \transpose c d
  \relative c' {
    \set shapeNoteStyles = #'#(do re mi fa
                               #f la ti)
    \fragment
  }

  \break

  \relative c' {
    \set shapeNoteStyles = #'#(cross triangle fa #f
                               mensural xcircle diamond)
    \fragment
  }
}

