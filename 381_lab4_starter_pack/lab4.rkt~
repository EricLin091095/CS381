#lang racket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     CS 381 - Programming Lab #4		;
;										;
;  < your name >					 	;
;  < your email >	                	;
;										;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; your code here




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