
"
Internally markup is stored as lists, whose head is a function.

  (FUNCTION ARG1 ARG2 ... )

When the markup is formatted, then FUNCTION is called as follows

  (FUNCTION GROB PROPS ARG1 ARG2 ... ) 

GROB is the current grob, PROPS is a list of alists, and ARG1.. are
the rest of the arguments.

The function should return a molecule (i.e. a formatted, ready to
print object).



To add a function,

1. It should be named  COMMAND-markup

2. It should have an object property set that describes it's
signature. This is to allow the parser to figure out how many
arguments to expect:

  (set-object-property! COMMAND-markup  scm0-markup1)

(insert in the list below).

3. The command is now available in markup mode, e.g.


  \markup { .... \COMMAND #1 argument ... }


BUGS:

At present, markup functions must be defined in this
file. Implementing user-access for markup functions is an excercise
for the reader.


 

" ; " 

;; debugging.

(define (mydisplay x) (display x) (newline) x)

(define-public (simple-markup grob props . rest)
  (Text_item::text_to_molecule grob props (car rest))
  )

(define-public (stack-molecule-line space molecules)
  (if (pair? molecules)
      (if (pair? (cdr molecules))
	  (let* (
		 (tail (stack-molecule-line  space (cdr molecules)))
		 (head (car molecules))
		 (xoff (+ space (cdr (ly:get-molecule-extent head X))))
		 )
	    
	    (ly:add-molecule
	     head
	     (ly:molecule-translate-axis tail xoff X))
	  )
	  (car molecules))
      '())
  )

(define-public (line-markup grob props . rest)
  (stack-molecule-line
   (cdr (chain-assoc 'word-space props))
   (map (lambda (x) (interpret-markup grob props x)) (car rest)))
  )

(define (combine-molecule-list lst)
  (if (null? (cdr lst)) (car lst)
      (ly:add-molecule (car lst) (combine-molecule-list (cdr lst)))
      ))

(define-public (combine-markup grob props . rest)
  (ly:add-molecule
   (interpret-markup grob props (car rest))
   (interpret-markup grob props (cadr rest))))
  
;   (combine-molecule-list (map (lambda (x) (interpret-markup grob props x)) (car rest))))

(define (font-markup qualifier value)
  (lambda (grob props . rest)
    (interpret-markup grob (cons (cons `(,qualifier . ,value) (car props)) (cdr props)) (car rest))
  
  ))


(define-public (set-property-markup qualifier)
  (lambda (grob props . rest  )
    (interpret-markup grob
		      (cons (cons `(,qualifier . ,(car rest))
				  (car props)) (cdr props))
		      (cadr rest))
    ))


(define-public fontsize-markup (set-property-markup 'font-relative-size))
(define-public magnify-markup (set-property-markup 'font-magnification))

(define-public bold-markup
  (font-markup 'font-series 'bold))
(define-public number-markup
  (font-markup 'font-family 'number))


(define-public huge-markup
  (font-markup 'font-relative-size 2))
(define-public large-markup
  (font-markup 'font-relative-size 1))
(define-public small-markup
  (font-markup 'font-relative-size -1))
(define-public tiny-markup
  (font-markup 'font-relative-size -2))
(define-public teeny-markup
  (font-markup 'font-relative-size -3))
(define-public dynamic-markup
  (font-markup 'font-family 'dynamic))
(define-public italic-markup
  (font-markup 'font-shape 'italic))


;; TODO: baseline-skip should come from the font.
(define-public (column-markup grob props . rest)
  (stack-lines
   -1 0.0 (cdr (chain-assoc 'baseline-skip props))
   (map (lambda (x) (interpret-markup grob props x)) (car rest)))
  )

(define-public (musicglyph-markup grob props . rest)
  (ly:find-glyph-by-name
   (ly:get-font grob (cons '((font-family . music)) props))
   (car rest))
  )

(define-public (lookup-markup grob props . rest)
  "Lookup a glyph by name."
  (ly:find-glyph-by-name
   (ly:get-font grob props)
   (car rest))
  )

(define-public (char-markup grob props . rest)
  "Syntax: \\char NUMBER. "
  (ly:get-glyph  (ly:get-font grob props) (car rest))
  )

(define-public (raise-markup grob props  . rest)
  "Syntax: \\raise AMOUNT MARKUP. "
  (ly:molecule-translate-axis (interpret-markup
			       grob
			       props
			       (cadr rest))
			      (car rest) Y)
  )

(define-public (normal-size-superscript-markup grob props . rest)
  (ly:molecule-translate-axis (interpret-markup
			       grob
			       props (car rest))
			      (* 0.5 (cdr (chain-assoc 'baseline-skip props)))
			      Y)
  )

(define-public (super-markup grob props  . rest)
  "Syntax: \\super MARKUP. "
  (ly:molecule-translate-axis (interpret-markup
			       grob
			       (cons '((font-relative-size . -2)) props) (car rest))
			      (* 0.5 (cdr (chain-assoc 'baseline-skip props)))
			      Y)
  )

(define-public (translate-markup grob props . rest)
  "Syntax: \\translate OFFSET MARKUP. "
  (ly:molecule-translate (interpret-markup  grob props (cadr rest))
			 (car rest))

  )

(define-public (sub-markup grob props  . rest)
  "Syntax: \\sub MARKUP."
  (ly:molecule-translate-axis (interpret-markup
			       grob
			       (cons '((font-relative-size . -2)) props)
			       (car rest))
			      (* -0.5 (cdr (chain-assoc 'baseline-skip props)))
			      Y)
  )

;; todo: fix negative space
(define (hspace-markup grob props . rest)
  "Syntax: \\hspace NUMBER."
  (let*
      ((amount (car rest)))
    (if (> amount 0)
	(ly:make-molecule "" (cons 0 amount) '(-1 . 1) )
	(ly:make-molecule "" (cons amount amount) '(-1 . 1)))
  ))

(define-public (override-markup grob props . rest)
  "Tack the 1st arg in REST onto PROPS, e.g.

\override #'(font-family . married) \"bla\"

"
  
  (interpret-markup grob (cons (list (car rest)) props)
		    (cadr rest)))

(define-public (smaller-markup  grob props . rest)
  "Syntax: \\smaller MARKUP"
  (let*
      (
       (fs (cdr (chain-assoc 'font-relative-size props)))
       (entry (cons 'font-relative-size (- fs 1)))
       )
  (interpret-markup
   grob (cons (list entry) props)
   (car rest))

  ))

(define-public (bigger-markup  grob props . rest)
  "Syntax: \\bigger MARKUP"
  (let*
      (
       (fs (cdr (chain-assoc 'font-relative-size props)))
       (entry (cons 'font-relative-size (+ fs 1)))
       )
  (interpret-markup
   grob (cons (list entry) props)
   (car rest))
  ))

(define (markup-signature-to-keyword sig)
  " (A B C) -> a0-b1-c2 "
  
  (let* ((count  0))
    (string->symbol (string-join
     
     (map
     (lambda (func)
       (set! count (+ count 1))
       (string-append

	;; for reasons I don't get,
	;; (case func ((markup?) .. )
	;; doesn't work.
	(cond 
	  ((eq? func markup?) "markup")
	  ((eq? func markup-list?) "markup-list")
	  (else "scheme")
	  )
	(number->string (- count 1))
	))
     
     sig)
     "-"))

  ))


(define (markup-function? x)
  (object-property x 'markup-signature)
  )

(define (markup-list? arg)
  (define (markup-list-inner? l)
    (if (null? l)
	#t
	(and (markup? (car l)) (markup-list-inner? (cdr l)))
    )
  )
  (and (list? arg) (markup-list-inner? arg)))


(define (markup-argument-list? signature arguments)
  (if (and (pair? signature) (pair? arguments))
      (and ((car signature) (car arguments))
	   (markup-argument-list? (cdr signature) (cdr arguments)))
      (and (null? signature) (null? arguments)))
  )

;;
;; full recursive typecheck.
;;
(define (markup-typecheck? arg)
  (and (pair? arg)
       (markup-function? (car arg))
       (markup-argument-list?
	(object-property (car arg) 'markup-signature)
	(cdr arg))
  ))

;; 
;; typecheck, and throw an error when something amiss.
;; 
(define (markup-thrower-typecheck arg)
  (cond
   ((not (pair? arg))
    (throw 'markup-format "Not a pair" arg)
    )
   ((not (markup-function? (car arg)))
    (throw 'markup-format "Not a markup function " (car arg)))
   
  
   ((not (markup-argument-list? 
	  (object-property (car arg) 'markup-signature)
	  (cdr arg)))
    (throw 'markup-format "Arguments failed  typecheck for " arg)))
   #t
  )

(define (cheap-markup? x)
  (and (pair? x)
       (markup-function? (car x)))
)

;;
;; replace by markup-thrower-typecheck for more detailed diagnostics.
;; 
(define markup?  cheap-markup?)


(define markup-function-list
  (list

   ;; abs size
   (cons teeny-markup (list markup?))
   (cons tiny-markup (list markup?))
   (cons small-markup (list markup?))
   (cons dynamic-markup (list markup?))
   (cons large-markup (list markup?)) 
   
   (cons huge-markup (list markup?))

   ;; size
   (cons smaller-markup (list markup?))
   (cons bigger-markup (list markup?))

   ;; 
   (cons sub-markup (list markup?))
   (cons super-markup (list markup?))
   
   (cons bold-markup (list markup?))
   (cons italic-markup (list markup?))
   
   (cons number-markup (list markup?))
   
   (cons column-markup (list markup-list?))
   (cons line-markup  (list markup-list?))

   (cons combine-markup (list markup? markup?))
   (cons simple-markup (list string?))
   (cons musicglyph-markup (list scheme?))
   
   (cons translate-markup (list number-pair? markup?))
   (cons override-markup (list pair? markup?))
   (cons char-markup (list integer?))
   (cons lookup-markup (list string?))
   
   (cons hspace-markup (list number?))

   (cons raise-markup (list number? markup?))
   (cons magnify-markup (list number? markup?))
   (cons fontsize-markup (list number? markup?))
   )
  )


(define markup-module (current-module))

(map (lambda (x)
       (set-object-property! (car x) 'markup-signature (cdr x))
       (set-object-property! (car x) 'markup-keyword (markup-signature-to-keyword (cdr x)))
       )
     markup-function-list)


;; construct a
;;
;; make-FOO-markup function that typechecks its arguments.
;;
;; TODO: should construct a message says
;; Invalid argument 4 : expecting a BLADIBLA, found: (list-ref 4 args)
;;
;; right now, you get the entire argument list.
(define (make-markup-maker  entry)
  (let*
	((foo-markup (car entry))
	 (signature (cons 'list (cdr entry)))
	 (name (symbol->string (procedure-name foo-markup)))
	 (make-name  (string-append "make-" name))
	 )
      
      `(define (,(string->symbol make-name) . args)
	 (if (markup-argument-list? ,signature args)
	     (cons ,foo-markup args)
	     (scm-error 'markup-format ,make-name "Invalid argument list: ~A." (list args) #f)
	     )))
    )


(eval
 (cons 'begin (map make-markup-maker markup-function-list))
 markup-module
 )

(define-public (lookup-markup-command code)
  (let*
      ( (sym (string->symbol (string-append code "-markup")))
	(var (module-local-variable markup-module sym))
	)
    (if (eq? var #f)
	#f   
	(cons (variable-ref var) (object-property  (variable-ref var) 'markup-keyword))
    )
  ))


(define-public (brew-new-markup-molecule grob)
  (interpret-markup grob
		    (Font_interface::get_property_alist_chain grob)
		    (ly:get-grob-property grob 'text)
		    )
  )

(define-public empty-markup `(,simple-markup ""))

(define (interpret-markup  grob props markup)
  (let*
      (
       (func (car markup))
       (args (cdr markup))
       )
    
    (apply func (cons grob (cons props args)) )
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test make-foo-markup functions
(if #f
(begin
  (make-line-markup (make-simple-markup "FOO")
		    (make-simple-markup "foo")
		    )

  (make-teeny-markup (make-simple-markup 1)))
)

;;
;; test typecheckers. Not wholly useful, because errors are detected
;; in other places than they're made.
;;
(if #f
 (begin

   ;; To get error messages, see above to install the alternate
   ;; typecheck routine for markup?.
   
   (define (typecheck-with-error x)
     (catch
      'markup-format
      (lambda () (markup? x))
      (lambda (key message arg)
	(display "\nERROR: markup format error: \n")
	(display message)
	(newline)
	(write arg (current-output-port))
	)
      ))

   (display (typecheck-with-error `(,simple-markup "foobar")))
   (display (typecheck-with-error `(,simple-markup "foobar")))
   (display (typecheck-with-error `(,simple-markup 1)))
   (display
    (typecheck-with-error  `(,line-markup ((,simple-markup "foobar"))
					  (,simple-markup 1))))
   (display
    (typecheck-with-error  `(,line-markup (,simple-markup "foobar")
					 (,simple-markup "bla"))))
   
   ))
