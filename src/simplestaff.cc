#include "request.hh"
#include "voice.hh"
#include "swalker.hh"
#include "debug.hh"
#include "clef.hh"
#include "staff.hh"
#include "command.hh"
#include "simplestaff.hh"
#include "sccol.hh" 
#include "simplewalker.hh"



Simple_column::Simple_column(Score_column*s, Simple_staff *rs)
    : Staff_column(s)
{
    stem_requester_len = 0;
    stem_ = 0;    
    staff_ = rs;
    beam_ = 0;
    text_=0;
}

Simple_staff::Simple_staff()
{
    theline = 0;
}

/**
 accept:

    BREAK: all
    TYPESET: bar, meter,
Scalar
    */



void
Simple_column::process_requests()
{
    for (int i = 0 ; i < v_elts.size(); i ++)
	for (iter_top(v_elts[i]->reqs,j); j.ok(); j++) {
	    Request *rq= j;
	    if (rq->barcheck()) {
		if (tdescription_->whole_in_measure) {
		    error("Barcheck failed, " + tdescription_->str());
		}
	    }
				   
	    if (rq->rhythmic()){
		notes.add(rq->rhythmic());
	    }
	    if (rq->script()) {
		notes.last().scripts.add(rq->script());
	    }
	    if (rq->stem()) {
		stem_ = rq->stem();
		stem_requester_len = v_elts[i]->duration;
	    }
	    if (rq->text()) {
		text_ = rq->text();
	    }
	    if (rq->beam()) {
		beam_ = rq->beam();
	    }
	    if (rq->slur()) {
		slurs.add(rq->slur());
	    }
	}
}

Staff_column*
Simple_staff::create_col(Score_column*s)
{
    return new Simple_column(s,this);
}

void
Simple_staff::walk()
{
    for (Simple_walker sc(this); sc.ok(); sc++) {
	sc.col()->process_requests();// TODO
	sc.process();
    }
}
Note_info::Note_info()
{
    rq =0;
}
Note_info::Note_info(Rhythmic_req*r) {
    rq = r;
}
