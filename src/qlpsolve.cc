#include "qlpsolve.hh"
#include "const.hh"
#include "debug.hh"
#include "choleski.hh"

const Real TOL=1e-2;		// roughly 1/10 mm

String
Active_constraints::status() const
{
    String s("Active|Inactive [");
    for (int i=0; i< active.size(); i++) {
	s += String(active[i]) + " ";
    }

    s+="| ";
    for (int i=0; i< inactive.size(); i++) {
	s += String(inactive[i]) + " ";
    }
    s+="]";

    return s;
}

void
Active_constraints::OK()
{
    #ifndef NDEBUG
    H.OK();
    A.OK();
    assert(active.size() +inactive.size() == opt->cons.size());
    assert(H.dim() == opt->dim());
    assert(active.size() == A.rows());
    Array<int> allcons;

    for (int i=0; i < opt->cons.size(); i++)
	allcons.add(0);
    for (int i=0; i < active.size(); i++) {
	int j = active[i];
	allcons[j]++;
    }
    for (int i=0; i < inactive.size(); i++) {
	int j = inactive[i];
	allcons[j]++;
    }
    for (int i=0; i < allcons.size(); i++)
	assert(allcons[i] == 1);
#endif
}

Vector
Active_constraints::get_lagrange(Vector gradient)
{
    Vector l(A*gradient);

    return l;
}

void
Active_constraints::add(int k)
{
    // add indices
    int cidx=inactive[k];
    active.add(cidx);

    inactive.swap(k,inactive.size()-1);
    inactive.pop();

    Vector a( opt->cons[cidx] );
    // update of matrices
    Vector Ha = H*a;
    Real aHa = a*Ha;
    Vector addrow(Ha.dim());
    if (abs(aHa) > EPS) {
	/*
	  a != 0, so if Ha = O(EPS), then
	  Ha * aH / aHa = O(EPS^2/EPS)

	  if H*a == 0, the constraints are dependent.
	  */
	H -= Matrix(Ha/aHa , Ha);
    

	/*
	  sorry, don't know how to justify this. ..
	  */
	addrow=Ha;
        addrow/= aHa;
	A -= Matrix(A*a, addrow);
	A.insert_row(addrow,A.rows());
    }else
	WARN << "degenerate constraints";
}

void
Active_constraints::drop(int k)
{
    int q=active.size()-1;

        // drop indices
    inactive.add(active[k]);
    active.swap(k,q);
    A.swap_rows(k,q);
    active.pop();

    Vector a(A.row(q));
    if (a.norm() > EPS) {
	/*
	 
	 */
        Real q = a*opt->quad*a;
	H += Matrix(a,a/q);
	A -= A*opt->quad*Matrix(a,a/q);
    }else
	WARN << "degenerate constraints";
   #ifndef NDEBUG
    Vector rem_row(A.row(q));
    assert(rem_row.norm() < EPS);
   #endif
     
    A.delete_row(q);
}


Active_constraints::Active_constraints(Ineq_constrained_qp const *op)
    :       A(0,op->dim()),
	    H(op->dim()),
	    opt(op)
{
    for (int i=0; i < op->cons.size(); i++)
	inactive.add(i);
    Choleski_decomposition chol(op->quad);
    H=chol.inverse();
}

/* Find the optimum which is in the planes generated by the active
    constraints.        
    */
Vector
Active_constraints::find_active_optimum(Vector g)
{
    return H*g;
}

/****************************************************************/

int
min_elt_index(Vector v)
{
    Real m=INFTY; int idx=-1;
    for (int i = 0; i < v.dim(); i++){
	if (v(i) < m) {
	    idx = i;
	    m = v(i);
	}
	assert(v(i) <= INFTY);
    }
    return idx;
}

///the numerical solving
Vector
Ineq_constrained_qp::solve(Vector start) const 
{    
    Active_constraints act(this);


    act.OK();    

    
    Vector x(start);
    Vector gradient=quad*x+lin;


    Vector last_gradient(gradient);
    int iterations=0;
    
    while (iterations++ < MAXITER) {
	Vector direction= - act.find_active_optimum(gradient);
       	
	mtor << "gradient "<< gradient<< "\ndirection " << direction<<"\n";
	
	if (direction.norm() > EPS) {
	    mtor << act.status() << '\n';
	    
	    Real minalf = INFTY;

	    Inactive_iter minidx(act);


	    /*
    we know the optimum on this "hyperplane". Check if we
    bump into the edges of the simplex
    */
    
	    for (Inactive_iter ia(act); ia.ok(); ia++) {

		if (ia.vec() * direction >= 0)
		    continue;
		Real alfa= - (ia.vec()*x - ia.rhs())/
		    (ia.vec()*direction);
		
		if (minalf > alfa) {
		    minidx = ia;
		    minalf = alfa;
		}
	    }
	    Real unbounded_alfa = 1.0;
	    Real optimal_step = min(minalf, unbounded_alfa);

	    Vector deltax=direction * optimal_step;
	    x += deltax;	    
	    gradient += optimal_step * (quad * deltax);
	    
	    mtor << "step = " << optimal_step<< " (|dx| = " <<
		deltax.norm() << ")\n";	    
	   
	    if (minalf < unbounded_alfa) {
		/* bumped into an edge. try again, in smaller space. */
		act.add(minidx.idx());
		mtor << "adding cons "<< minidx.idx()<<'\n';
		continue;
	    }
	    /*ASSERT: we are at optimal solution for this "plane"*/
    
    
	}
	
	Vector lagrange_mult=act.get_lagrange(gradient);	
	int m= min_elt_index(lagrange_mult);
	
	if (m>=0 && lagrange_mult(m) > 0) {
	    break;		// optimal sol.
	} else if (m<0) {
	    assert(gradient.norm() < EPS) ;
	    
	    break;
	}
	
	mtor << "dropping cons " << m<<'\n';
	act.drop(m);
    }
    if (iterations >= MAXITER)
	WARN<<"didn't converge!\n";
    
    mtor <<  ": found " << x<<" in " << iterations <<" iterations\n";
    assert_solution(x);
    return x;
} 

/** Mordecai Avriel, Nonlinear Programming: analysis and methods (1976)
    Prentice Hall.

    Section 13.3

    This is a "projected gradient" algorithm. Starting from a point x
    the next point is found in a direction determined by projecting
    the gradient onto the active constraints.  (well, not really the
    gradient. The optimal solution obeying the active constraints is
    tried. This is why H = Q^-1 in initialisation) )


    */
    
