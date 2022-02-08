#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     CS 381 - Programming Lab #4	;
;					;
;  < Lin Tsu Ching >			;
;  < lintsuc@oregonstate.edu >	        ;
;					;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; your code here
(define (member? e lst)
  ; complete this function definition
  (cond
    [(empty? lst) #f]
    [(equal? (first lst) e) #t]
    [else (member? e (rest lst))]
    )
)

(define (set? lst) 
  ; complete this function definition
  (cond
    [(empty? lst) #t]
    [(member? (first lst) (rest lst)) #f]
    [else (set? (rest lst))]
    )
)

;helper function for union
(define (set-of-element x lst)
  (cond
    [(empty? lst) #f]
    [(equal? x (car lst)) #t]
    [else (set-of-element x (cdr lst))]
    )
)

(define (union lst1 lst2)
  ; complete this function definition
  (cond
    [(empty? lst1) lst2]
    [(set-of-element (car lst1) lst2) (union (cdr lst1) lst2)]
    [else (cons (car lst1) (union (cdr lst1) lst2))]
    )
)

(define (intersect lst1 lst2)
  ; complete this function definition
  (if (null? lst1)
      '()
      (if (set-of-element (car lst1) lst2)
          (cons (car lst1) (intersect (cdr lst1) lst2))
          (intersect (cdr lst1) lst2)
          )
   )
)

(define (difference lst1 lst2)
  ; complete this function definition
  (if (null? lst1)
      '()
      (if (set-of-element (car lst1) lst2)
          (difference (cdr lst1) lst2)
          (cons (car lst1) (difference (cdr lst1) lst2))
          )
   )
)

;helper function
(define (flat lst)
  (cond
    [(empty? lst) null]
    [(not (list? lst)) (list lst)]
    [else (append (flat (first lst)) (flat(rest lst)))]
   )
)

(define (flatten lst1 lst2)
  ; complete this function definition
  (append (flat lst1) (flat lst2))
)

;;;;;;;;;;;;;;;;;
;  DO NOT EDIT  ;
;;;;;;;;;;;;;;;;;
; enables testing via piping in stdin
(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))
(let loop ()
  (define line (read-line (current-input-port) 'any))
  (if (eof-object? line)
    (display "")
    (begin (print (eval (read (open-input-string line)) ns)) (newline) (loop))))