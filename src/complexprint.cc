#include "keyitem.hh"

#include "request.hh"
#include "pscore.hh"
#include "paperdef.hh"
#include "complexstaff.hh"
#include "sccol.hh"
#include "debug.hh"

#include "clefitem.hh"
#include "bar.hh"
#include "meter.hh"
const NO_LINES = 5;

Item *
Complex_staff::get_TYPESET_item(Command *com)
{
    Item *s=0;
    Array<Scalar> arg( com->args);
    String type =arg[0];
    arg.del(0);
    if (com->args[0] == "KEY") {
	return new Keyitem(NO_LINES);	// urgh. depends on clef.
    } else if (type ==  "BAR" ) {
	s = new Bar(com->args[1]);	
    } else if (type == "METER") {
	s = new Meter(arg);
    } else if (type == "CLEF" || type == "CURRENTCLEF") {
	Clef_item * c = new Clef_item;
	s = c;
	c->change = (type == "CLEF");	
    }else{
	WARN << "ignoring TYPESET command for " << type << '\n';
    }
    return s;
}



Interval
itemlist_width(const Array<Item*> &its)
{
    Interval iv ;
    iv.set_empty();
     
    for (int j =0; j < its.size(); j++){
	iv.unite (its[j]->width());

    }
    return iv;
}

void
Complex_column::typeset_item(Item *i, int breakst)
{
    assert(i);
    
    staff_l_->pscore_l_->typeset_item(i, score_column_l_->pcol_l_,
				  staff_l_->pstaff_l_,breakst);
    
    if (breakst == BREAK_PRE - BREAK_PRE) {
	
        Array<Item*> to_move(
	    staff_l_->pscore_l_->select_items(staff_l_->pstaff_l_,
					  score_column_l_->pcol_l_->prebreak_p_));
	Interval column_wid = itemlist_width(to_move);
	assert(!column_wid.empty());

	for (int j=0; j < to_move.size(); j++) {
	    to_move[j]->translate(Offset(-column_wid.right, 0));
	}
    }
}    
/*
  UGGGG
  */
void
Complex_column::typeset_item_directional(Item *i, int dir, int breakst) // UGH!
{
    assert(i);
    PCol * c=score_column_l_->pcol_l_;
    if (breakst == 0)
	c = c->prebreak_p_;
    else if (breakst == 2)
	c = c->postbreak_p_;
    
    Array<Item*> to_move(staff_l_->pscore_l_->select_items(staff_l_->pstaff_l_,
						      c));    
    typeset_item(i, breakst);

    Interval column_wid = itemlist_width(to_move);
    if (column_wid.empty())
	column_wid = Interval(0,0);
    i->translate(Offset(column_wid[dir] - i->width()[-dir], 0));
}

void
Complex_staff::set_output(PScore* pscore_l )
{
    pstaff_l_ = new PStaff(pscore_l); // pstaff_l_ is added to pscore later.
    pscore_l_ = pscore_l;
    pscore_l_->add(pstaff_l_);
}


