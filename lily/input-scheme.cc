/*
  input-scheme.cc --  implement Input bindings.

  source file of the GNU LilyPond music typesetter

  (c) 2005 Han-Wen Nienhuys <hanwen@xs4all.nl>

*/

#include "string.hh"
#include "input-smob.hh"

/* We don't use IMPLEMENT_TYPE_P, since the smobification part is
   implemented separately from the class.  */
LY_DEFINE (ly_input, "ly:input-location?", 1, 0, 0,
	   (SCM x),
	   "Return #t if @var{x} is an input location.")
{
  return unsmob_input (x) ? SCM_BOOL_T : SCM_BOOL_F;
}

LY_DEFINE (ly_input_message, "ly:input-message", 2, 0, 0, (SCM sip, SCM msg),
	  "Print @var{msg} as a GNU compliant error message, pointing to the"
	   "location in @var{sip}.\n")
{
  Input *ip = unsmob_input (sip);
  SCM_ASSERT_TYPE (ip, sip, SCM_ARG1, __FUNCTION__, "input location");
  SCM_ASSERT_TYPE (scm_is_string (msg), msg, SCM_ARG2, __FUNCTION__, "string");

  String m = ly_scm2string (msg);
  ip->message (m);

  return SCM_UNSPECIFIED;
}

/*
  TODO: rename this function. ly:input-location? vs ly:input-location
 */
LY_DEFINE (ly_input_location, "ly:input-location", 1, 0, 0, (SCM sip),
	  "Return input location in @var{sip} as (file-name line column).")
{
  Input *ip = unsmob_input (sip);
  SCM_ASSERT_TYPE (ip, sip, SCM_ARG1, __FUNCTION__, "input location");
  return scm_list_3 (scm_makfrom0str (ip->file_string ().to_str0 ()),
		     scm_int2num (ip->line_number ()),
		     scm_int2num (ip->column_number ()));
}

LY_DEFINE (ly_input_both_locations, "ly:input-both-locations", 1, 0, 0, (SCM sip),
	  "Return input location in @var{sip} as (file-name first-line first-column last-line last-column).")
{
  Input *ip = unsmob_input (sip);
  SCM_ASSERT_TYPE (ip, sip, SCM_ARG1, __FUNCTION__, "input location");
  return scm_list_5 (scm_makfrom0str (ip->file_string ().to_str0 ()),
		     scm_int2num (ip->line_number ()),
		     scm_int2num (ip->column_number ()),
		     scm_int2num (ip->end_line_number ()),
		     scm_int2num (ip->end_column_number ()));
}
