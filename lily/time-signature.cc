/*   
  time-signature.cc --  implement Time_signature
  
  source file of the GNU LilyPond music typesetter
  
  (c) 1996--2002 Han-Wen Nienhuys <hanwen@cs.uu.nl>
  
 */


#include "molecule.hh"
#include "text-item.hh"
#include "time-signature.hh"
#include "paper-def.hh"
#include "font-interface.hh"
#include "warn.hh"
#include "staff-symbol-referencer.hh"

MAKE_SCHEME_CALLBACK (Time_signature,brew_molecule,1);
/*
  TODO: make different functions for special and normal timesigs.
 */
SCM
Time_signature::brew_molecule (SCM smob) 
{
  Grob * me = unsmob_grob (smob);
  SCM st = me->get_grob_property ("style");
  SCM frac = me->get_grob_property ("fraction");
  int n = 4;
  int d = 4;
  if (gh_pair_p (frac))
    {
      n = gh_scm2int (ly_car (frac));
      d = gh_scm2int (ly_cdr (frac));
    }

  Molecule m;
  if (gh_symbol_p (st))
    {
      String style (ly_scm2string (scm_symbol_to_string (st)));
      if (style[0]=='1')
	{
	  m = numbered_time_signature (me, n, 0);
	}
      else
	{
	  m = special_time_signature (me, st, n, d);
	}
    }
  else
    m = numbered_time_signature (me, n,d);

  if (Staff_symbol_referencer::line_count (me) % 2 == 0)
    m.translate_axis (Staff_symbol_referencer::staff_space (me)/2 , Y_AXIS);

  return m.smobbed_copy ();
}

Molecule
Time_signature::special_time_signature (Grob *me, SCM style, int n, int d)
{
  String st = ly_scm2string (scm_symbol_to_string (style));
  SCM scm_n = gh_int2scm (n);
  SCM scm_d = gh_int2scm (d);
  SCM exp = scm_list_n (ly_symbol2scm ("find-timesig-symbol"),
			scm_n, scm_d, ly_quote_scm (style),
			SCM_UNDEFINED);
  SCM scm_pair = scm_primitive_eval (exp);
  SCM scm_font_char = ly_car (scm_pair);
  SCM scm_font_family = ly_cdr (scm_pair);
  String font_char = ly_scm2string (scm_font_char);
  String font_family = ly_scm2string (scm_font_family);
  me->set_grob_property("font-family", ly_symbol2scm (font_family.to_str0 ()));

  Molecule m =
    Font_interface::get_default_font (me)->find_by_name ("timesig-" + font_char);
  if (!m.empty_b ())
    return m;

  /*
    If there is no such symbol, we default without warning to the
    numbered style.
   */
  return numbered_time_signature (me, n, d);
}

Molecule
Time_signature::numbered_time_signature (Grob*me,int num, int den)
{
  SCM chain = Font_interface::font_alist_chain (me);
  me->set_grob_property("font-family", ly_symbol2scm ("number"));

  Molecule n = Text_item::text2molecule (me,
					 scm_makfrom0str (to_string (num).to_str0 ()),
					 chain);
  Molecule d = Text_item::text2molecule (me,
					 scm_makfrom0str (to_string (den).to_str0 ()),
					 chain);
  n.align_to (X_AXIS, CENTER);
  d.align_to (X_AXIS, CENTER);
  Molecule m;
  if (den)
    {
      m.add_at_edge (Y_AXIS, UP, n, 0.0);
      m.add_at_edge (Y_AXIS, DOWN, d, 0.0);
    }
  else
    {
      m = n;
      m.align_to (Y_AXIS, CENTER);
    }

  m.align_to (X_AXIS, LEFT);
  
  return m;
}

ADD_INTERFACE (Time_signature,"time-signature-interface",
  "A time signature, in different styles.
  The following values for 'style are are recognized:

    @table @samp
      @item @code{C}
        4/4 and 2/2 are typeset as C and struck C, respectively.  All
        other time signatures are written with two digits.

      @item @code{old}
        2/2, 3/2, 2/4, 3/4, 4/4, 6/4, 9/4, 4/8, 6/8 and 9/8 are
        typeset with old-style mensuration marks.  All other time
        signatures are written with two digits.

      @item @code{1xxx}
        All time signatures are typeset with a single
        digit, e.g. 3/2 is written as 3. (Any symbol starting
	with the digit @code{1} will do.)

      @item @code{C}@var{M}@code{/}@var{N}, 
@code{old}@var{M}@code{/}@var{N} or
      @code{old6/8alt}
        Tells LilyPond to use a specific symbol as time signature, 
	regardless of the actual time signature.
    @end table

See also the test-file @file{input/test/time.ly}.
",
  "fraction style");
