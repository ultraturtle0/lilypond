/*
  dynamic-engraver.cc -- implement Dynamic_engraver

  source file of the GNU LilyPond music typesetter

  (c)  1997--2000 Han-Wen Nienhuys <hanwen@cs.uu.nl>
*/
#include "debug.hh"
#include "dimensions.hh"
#include "crescendo.hh"
#include "musical-request.hh"
#include "lookup.hh"
#include "paper-def.hh"
#include "paper-column.hh"
#include "staff-symbol.hh"
#include "note-column.hh"
#include "text-item.hh"
#include "side-position-interface.hh"
#include "engraver.hh"
#include "stem.hh"
#include "note-head.hh"
#include "group-interface.hh"
#include "directional-element-interface.hh"
#include "staff-symbol-referencer.hh"

#define DYN_LINE

#ifdef DYN_LINE

class Dynamic_line_spanner : public Spanner
{
public:
  Dynamic_line_spanner ();
  
  void add_element (Score_element*);
  void add_column (Note_column*);
  Direction get_default_dir () const;

protected:
  virtual void do_add_processing ();
  // URG: see Dynamic_engraver::do_removal_processing
  friend class Dynamic_engraver;
  virtual void do_post_processing ();

private:
  void translate_elements (Real);
  Real get_extreme_y () const;
};

Dynamic_line_spanner::Dynamic_line_spanner ()
{
  set_elt_property ("transparent", SCM_BOOL_T);
}

void
Dynamic_line_spanner::add_element (Score_element* e)
{
  Group_interface gi (this, "elements");
  gi.add_element (e);
  //?
  Side_position_interface (e).set_axis (Y_AXIS);
  add_dependency (e);
}

void
Dynamic_line_spanner::add_column (Note_column* n)
{
  Group_interface gi (this, "note-columns");
  gi.add_element (n);
  add_dependency (n);
}

/*
  Copied (urg: literally!) from slur.
  Why not do this once, at post-processing stage?
 */
void
Dynamic_line_spanner::do_add_processing ()
{
  Link_array<Note_column> encompass_arr =
    Group_interface__extract_elements (this, (Note_column*)0, "note-columns");

  if (encompass_arr.size ())
    {
      set_bounds (LEFT, encompass_arr[0]);    
      if (encompass_arr.size () > 1)
	set_bounds (RIGHT, encompass_arr.top ());
    }
}

#if 0
Molecule
Dynamic_line_spanner::do_brew_molecule () const
{
  return Molecule ();
}
#endif

void
Dynamic_line_spanner::do_post_processing ()
{
  translate_elements (get_extreme_y ());
}

void
Dynamic_line_spanner::translate_elements (Real dy)
{
  SCM s = get_elt_property ("elements");
  for (; gh_pair_p (s); s = gh_cdr (s))
    {
      Score_element* se = unsmob_element (gh_car (s));
      se->translate_axis (dy, Y_AXIS);
    }
}

Direction
Dynamic_line_spanner::get_default_dir () const
{
  return DOWN;
  //Direction dir = directional_element (this).get ();
}

Real
Dynamic_line_spanner::get_extreme_y () const
{
  Link_array<Note_column> encompass_arr =
    Group_interface__extract_elements (this, (Note_column*)0, "note-columns");
  
  Staff_symbol_referencer_interface si (this);
  int stafflines = si.line_count ();
  //hurg?
  stafflines = stafflines != 0 ? stafflines : 5;
  Direction dir = get_default_dir ();

  Real staff_space = si.staff_space ();
  // burp?  when are these available?
  staff_space = staff_space != 0 ? staff_space : 5 PT;

  // urg: TODO: padding
  Real y = (stafflines / 2 + 1) * staff_space;

  for (int i = 0; i < encompass_arr.size (); i++)
    {
      Note_column* column = encompass_arr[i];
      Stem* stem = column->stem_l ();
      if (stem)
	{
	  Direction stem_dir = directional_element (stem).get ();
	  if ((stem_dir == dir)
	      && !stem->extent (Y_AXIS).empty_b ())
	    {
	      y = y >? (stem->extent (Y_AXIS)[dir]) * dir;
	    }
	  else
	    {
	      y = y >? (column->extent (Y_AXIS)[dir]) * dir;
	    }
	}
    }

  return y * dir;
}

#endif

/*
  TODO:
    * why handle absolute and span requests in one cryptic engraver,
    what about Span_dynamic_engraver?

    * hairpin
    * text:
      - `cresc. --  --  --'
      - `cresc. poco a poco -- -- --'
 */

/**
   print text & hairpin dynamics.
 */
class Dynamic_engraver : public Engraver
{
  Text_item * abs_text_p_;
  Text_item * cr_text_p_;
  Crescendo * to_end_cresc_p_;
  Crescendo * cresc_p_;

  Span_req * cresc_req_l_;
  Array<Request*> dynamic_req_l_arr_;

#ifdef DYN_LINE
  /*
    We probably need two of these: line-up above and below staff
   */
  Dynamic_line_spanner* spanner_;
  Moment last_request_mom_;
#endif
  
  void  typeset_all ();
public:
  VIRTUAL_COPY_CONS(Translator);
  Dynamic_engraver();
  
protected:

  void announce_element (Score_element_info);
  
  virtual void do_removal_processing ();
  virtual void acknowledge_element (Score_element_info);
  virtual bool do_try_music (Music *req_l);
  virtual void do_process_requests();
  virtual void do_pre_move_processing();
  virtual void do_post_move_processing();
  virtual void typeset_element (Score_element*);
};

ADD_THIS_TRANSLATOR (Dynamic_engraver);

void
Dynamic_engraver::announce_element (Score_element_info i)
{
  group (i.elem_l_, "interfaces").add_thing (ly_symbol2scm ("dynamic"));
  
  Engraver::announce_element (i);
}


Dynamic_engraver::Dynamic_engraver ()
{
  do_post_move_processing();
  abs_text_p_ = 0;
  cr_text_p_ = 0;
  to_end_cresc_p_ = cresc_p_ = 0;
  cresc_req_l_ = 0;
#ifdef DYN_LINE
  spanner_ = 0;
#endif
}

void
Dynamic_engraver::do_post_move_processing()
{
  dynamic_req_l_arr_.clear();
}

/*
  ugr
 */
bool
Dynamic_engraver::do_try_music (Music * m)
{
  Request * r = dynamic_cast<Request*> (m);

  if(Text_script_req * d = dynamic_cast <Text_script_req *> (r))
    {
      if (d->style_str_ != "dynamic")
	return false;
    }
  else if (Span_req * s =  dynamic_cast <Span_req*> (r))
    {
      if (s-> span_type_str_ != "crescendo"
	  && s->span_type_str_ != "decrescendo")
	return false;
    }
  else
    return false;
  
#ifdef DYN_LINE
  if (!spanner_)
    spanner_ = new Dynamic_line_spanner;
  last_request_mom_ = now_mom ();
#endif
  
  for (int i=0; i < dynamic_req_l_arr_.size (); i++)
    if (r->equal_b (dynamic_req_l_arr_[i]))
      return true;
  
  dynamic_req_l_arr_.push (r);
  return true;
}


void
Dynamic_engraver::do_process_requests()
{
  Crescendo*  new_cresc_p=0;

  for (int i=0; i < dynamic_req_l_arr_.size(); i++)
    {
      if (Text_script_req *absd =
	  dynamic_cast<Text_script_req *> ( dynamic_req_l_arr_[i]))
	{
	  if (abs_text_p_)
	    {
	      dynamic_req_l_arr_[i]->warning (_("Got a dynamic already.  Continuing dazed and confused."));
	      continue;
	    }
	  
	  String loud = absd->text_str_;

	  abs_text_p_ = new Text_item;
	  abs_text_p_->set_elt_property ("text",
				     ly_str02scm (loud.ch_C()));
	  abs_text_p_->set_elt_property ("style", gh_str02scm ("dynamic"));
	  abs_text_p_->set_elt_property ("script-priority",
				     gh_int2scm (100));
	  
#ifdef DYN_LINE
	  assert (spanner_);
	  spanner_->add_element (abs_text_p_);
#else
	  Side_position_interface (abs_text_p_).set_axis (Y_AXIS);
	  
	  if (absd->get_direction ())
	    {
	      abs_text_p_->set_elt_property ("direction", gh_int2scm (absd->get_direction ()));
	    }


	  /*
	    UGH UGH 
	   */
	  SCM prop = get_property ("dynamicDirection");
	  if (!isdir_b (prop))
	    {
	      prop = get_property ("verticalDirection");
	    }

	  if (isdir_b (prop) && to_dir (prop))
	    abs_text_p_->set_elt_property ("direction", prop);

	  prop = get_property ("dynamicPadding");
	  if (gh_number_p(prop))
	    {
	      abs_text_p_->set_elt_property ("padding", prop);
	    }
#endif
	  announce_element (Score_element_info (abs_text_p_, absd));

	}
      else if (Span_req *span_l
	       = dynamic_cast <Span_req *> (dynamic_req_l_arr_[i]))
	{
	  if (span_l->span_dir_ == STOP)
	    {
	      if (!cresc_p_)
		{
		  span_l->warning (_ ("Can't find (de)crescendo to end"));
		}
	      else
		{
		  assert (!to_end_cresc_p_);
		  to_end_cresc_p_ =cresc_p_;
		  
		  cresc_p_ = 0;
		}
	    }
	  else if (span_l->span_dir_ == START)
	    {
	      cresc_req_l_ = span_l;
	      assert (!new_cresc_p);
	      new_cresc_p  = new Crescendo;
	      new_cresc_p->set_elt_property
		("grow-direction",
		 gh_int2scm ((span_l->span_type_str_ == "crescendo")
			     ? BIGGER : SMALLER));
	      
	      SCM s = get_property (span_l->span_type_str_ + "Text");
	      if (gh_string_p (s))
		{
		  cr_text_p_ = new Text_item;
		  cr_text_p_->set_elt_property ("text", s);
		  // urg
		  cr_text_p_->set_elt_property ("style", gh_str02scm ("italic"));
		  // ?
		  cr_text_p_->set_elt_property ("script-priority",
						gh_int2scm (100));
		  
		  /*
		    This doesn't work.
		    I'd like to have support like this:
                           |
                          x|
		          cresc. - - -

		    or
                           |
                          x|
		          ff cresc. - - -

		   */
		  if (0) //abs_text_p_)
		    {
		      Side_position_interface (cr_text_p_).set_axis (X_AXIS);
		      Side_position_interface (cr_text_p_).add_support (abs_text_p_);
		    }

#ifdef DYN_LINE
		  assert (spanner_);
		  spanner_->add_element (cr_text_p_);
#endif

		  //Side_position_interface (cr_text_p_).set_axis (Y_AXIS);
		  announce_element (Score_element_info (cr_text_p_, span_l));
		}

	      s = get_property (span_l->span_type_str_ + "Spanner");
	      if (gh_string_p (s)) //&& ly_scm2string (s) != "hairpin")
		{
		  new_cresc_p->set_elt_property ("spanner", s);
		}
	  
#ifdef DYN_LINE
	      assert (spanner_);
	      spanner_->add_element (new_cresc_p);
#else
	      // what's the diff between side_position and Side_pos_iface?
	      side_position (new_cresc_p).set_axis (Y_AXIS);
#endif
	      announce_element (Score_element_info (new_cresc_p, span_l));
	    }
	}
    }

  if (new_cresc_p)
    {
      if (cresc_p_)
	{
	  ::warning (_ ("Too many crescendi here"));

	  typeset_element (cresc_p_);

	  cresc_p_ = 0;
	}
      
      cresc_p_ = new_cresc_p;
      cresc_p_->set_bounds(LEFT,get_staff_info().musical_pcol_l ());

      // arrragh, brr, urg: we know how wide text is, no?
      if (abs_text_p_)
	{
	  index_set_cell (cresc_p_->get_elt_property ("dynamic-drul"),
			  LEFT, SCM_BOOL_T);
	  if (to_end_cresc_p_)
	    index_set_cell (to_end_cresc_p_->get_elt_property ("dynamic-drul"),
			    RIGHT, SCM_BOOL_T);
	}
    }

}

void
Dynamic_engraver::do_pre_move_processing()
{
  typeset_all ();
}

void
Dynamic_engraver::do_removal_processing ()
{
  if (cresc_p_)
    {
      typeset_element (cresc_p_ );
      cresc_req_l_->warning (_ ("unended crescendo"));
      cresc_p_ =0;
    }
#ifdef DYN_LINE
  if (spanner_)
    {
      // URG urg.  We did't get a post_processing call !?
      spanner_->do_post_processing ();
      typeset_element (spanner_);
      spanner_ = 0;
    }
#endif
  typeset_all ();
}


void
Dynamic_engraver::typeset_all ()
{  
  if (to_end_cresc_p_)
    {
      to_end_cresc_p_->set_bounds(RIGHT,get_staff_info().musical_pcol_l ());
      typeset_element (to_end_cresc_p_);

      to_end_cresc_p_ =0;

    }
  
  if (abs_text_p_)
    {
      typeset_element (abs_text_p_);
      abs_text_p_ = 0;
    }

  if (cr_text_p_)
    {
      typeset_element (cr_text_p_);
      cr_text_p_ = 0;
    }
#ifdef DYN_LINE
  /*
    TODO: This should be optionised:
      * break when group of dynamic requests ends
      * break now 
      * continue through piece
   */
  if (spanner_ && last_request_mom_ < now_mom ())
    {
      typeset_element (spanner_);
      spanner_ = 0;
    }
#endif
}

void
Dynamic_engraver::typeset_element (Score_element * e)
{
#ifndef DYN_LINE
  side_position(e).add_staff_support ();
#endif
  Engraver::typeset_element (e);
}

#ifdef DYN_LINE

void
Dynamic_engraver::acknowledge_element (Score_element_info i)
{
  if (spanner_)
    {
      if (Note_column* n = dynamic_cast<Note_column*> (i.elem_l_))
	spanner_->add_column (n);
    }
}

#else

void
Dynamic_engraver::acknowledge_element (Score_element_info i)
{
  if (dynamic_cast<Stem *> (i.elem_l_)
      || dynamic_cast<Note_head *> (i.elem_l_)
      )
    {
      if (abs_text_p_)
	Side_position_interface (abs_text_p_).add_support (i.elem_l_);

      if (cr_text_p_)  ///&& !abs_text_p_)
	{
	  Side_position_interface (cr_text_p_).set_axis (Y_AXIS);
	  Side_position_interface (cr_text_p_).add_support (i.elem_l_);
	}

      if (to_end_cresc_p_)
	Side_position_interface (to_end_cresc_p_).add_support (i.elem_l_);

      if (cresc_p_)
	Side_position_interface(cresc_p_).add_support (i.elem_l_);
    }
}

#endif
