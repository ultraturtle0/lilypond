/*
  lexer.hh -- declare Lily_lexer

  source file of the GNU LilyPond music typesetter

  (c) 1997--2004 Han-Wen Nienhuys <hanwen@cs.uu.nl>
*/

#ifndef MY_LILY_LEXER_HH
#define MY_LILY_LEXER_HH

#include "includable-lexer.hh"

#include "input.hh"
#include "lily-proto.hh"
#include "flower-proto.hh"
#include "array.hh"
#include "string.hh"
#include "duration.hh"
#include "pitch.hh"
#include "smobs.hh"

bool busy_parsing ();
void kill_lexer ();
void set_lexer ();

/*
  TODO: this has a lot of SCM objects. Smobify me.
 */
class Lily_lexer : public Includable_lexer 
{
  DECLARE_SMOBS(Lily_lexer,);
public:
  SCM scopes_;
  SCM encoding_;
  
private:
  int lookup_keyword (String);
  int scan_bare_word (String);
  SCM scan_markup_word (String);
  int scan_escaped_word (String);
  int identifier_type (SCM);
  char escaped_char (char) const;

public:
  String main_input_name_;
  void *lexval;
  bool main_input_b_;
  
  Sources *sources_; 

  /* Scheme hash tables with (oct name acc)  values, and symbol keys.  */
  SCM chordmodifier_tab_;
  SCM pitchname_tab_stack_;

  Keyword_table *keytable_;
  int error_level_;
  Input last_input_;

  Lily_lexer (Sources*);
  Lily_lexer (Lily_lexer const&);
  ~Lily_lexer ();

  int yylex ();

  void prepare_for_next_token ();
  int try_special_identifiers (SCM* ,SCM);
  Input here_input () const;
  
  void add_scope (SCM);
  SCM remove_scope ();
  
  void start_main_input ();

  SCM lookup_identifier (String s);
  SCM lookup_identifier_symbol (SCM s);
  void push_chord_state (SCM tab);
  void push_figuredbass_state ();
  void push_lyric_state ();
  void push_initial_state ();
  void push_markup_state ();
  void push_note_state (SCM tab);
  void pop_state ();
  void LexerError (char const *);
  void set_encoding (String);
  SCM encoding () const;
  void set_identifier (SCM name_string, SCM);
  bool is_note_state () const;
  bool is_chord_state () const;
  bool is_lyric_state () const;
  bool is_figure_state () const;
};

#endif /* MY_LILY_LEXER_HH */
