;; CSC 151-NN (TERM)
;; Lab: Reading and writing procedures
;; Authors: YOUR NAMES HERE
;; Date: THE DATE HERE
;; Acknowledgements:
;;   ACKNOWLEDGEMENTS HERE


; +---------------------------------------------+--------------------
; | Exercise 1: Interpreting function execution |
; +---------------------------------------------+

; Approximate time: 10 minutes
; For this problem, B side drives and A side navigates.

; In this exercise, we will use our substitutive model of Scamper program
; execution to predict the behavior of some tricky scenarios involving
; functions.  We will then generalize what we see to arrive at some conclusions
; regarding the behavior of functions.

; Consider the following function definitions:

(define my-func-1
  (lambda (x y)
    (+ x (* y y) x)))

(define my-func-2
  (lambda (n)
    (* n 2)))

(define my-func-3
  (lambda (n)
    (+ (my-func-2 n) (my-func-2 8) n)))

; Give the execution trace (i.e., step-by-step evaluation) of each of
; the following expressions in the space above them.  Note that when you
; evaluate an arithmetic operator with more than 2 arguments, you can
; evaluate the addition in one step, e.g., (+ 1 1 1) --> 3. Make sure
; to write your trace as a collection of line comments so that your
; file still runs successfully. (Similarly to how this prose is just
; one big comment block!)

; Use the explorations pane to check that your trace produces the correct value.
; We recommend checking each intermediate expression as you go.

; a.
;      (my-func-1 (+ 1 1) 5)
;  --> ...

; b.
;     (my-func-2 (my-func-2 (my-func-2 3)))
; --> ...

; +----------------------+-------------------------------------------
; | Exercise 2: What if? |
; +----------------------+

; Driver: A
; Approximate time: Five to Ten minutes

; The previous exercises might suggest an important maxim regarding functions
; and parameter names:

; > The names of the parameters of a function don't matter.

; To delve into what this means, consider the following alternative
; definition of my-func-2:

(define my-func-2-alt
  (lambda (x)
    (* x 2)))

; With your partner, use your mental model of computation to compare the
; behavior of my-func-2 and my-func-2-alt and in a few sentences, explain what
; the maxim presented above means.  E.g., you might consider

(my-func-2-alt (my-func-2-alt (my-func-2-alt 3)))

; and compare the evaluation.

; Write your explanation in the space below:
;
; ...
;

; +-----------------------------------------------------------------
; | Exercise 3: Bounding  |
; +-----------------------+

; Driver: B
; Approximate time: 5 - 10 minutes

; Write a procedure which bounds its input between 0 and 100.

; Example: (boundnum 101) returns 100
;          (boundnum 50) returns 50
;          (boundnum -5) returns 0

; Note that we *do not* 
; have tools like conditionals (for those of you with experience with those)! 
; If you're struggling, look for ideas for mathematical tools in the docs:
;    https://scamper.cs.grinnell.edu/2.8.7/docs.html

(define boundnum
  {??})

; +-----------------------------------------------------------------
; | Exercise 4: Writing generic text |
; +----------------------------------+

; Driver: A
; Approximate time: 5 minutes

; Consider the following code which creates a letter

(define recipient "NAME")
(define magazine "NAME")
(define article "NAME")
(define cr (string #\newline))

(define letter
 (string-append
  "Dear " recipient ", " cr
  cr
  "Thank you for your submission to " magazine ".  Unfortunately, we " cr
  "consider the subject of your article, " article ", inappropriate " cr
  "for our readership.  In fact, it is probably inappropriate for any " cr
  "readership.  Please do not contact us again, and do not bother " cr  
  "other magazines with this inappropriate material or we will be " cr
  "forced to contact the appropriate authorities." cr
  cr
  "Regards," cr
  "Ed I. Tor" cr))

; Experiment with defining `recipient` as `"Professor Schneider"`, `magazine`
; as `"College Trustee News"`, and `article as `"Using Grinnell's Endowment
; to Eliminate Tuition"`.  Make sure it looks how you expect. 


; Define a procedure, letter2, which gives the same (or similar) output as letter, 
; but has three parameters: recipient, magazine, and article

(define letter2
  {??})

; +----------------+-------------------------------------------------
; | Submit the lab |
; +----------------+

; You're done.  Congratulations!  It's time to submit your lab.  After
; doing so, you should review the extra problems below and, as
; appropriate, pick one or more to attempt.  We'd suggest that you
; start with the first extra problem.

; To turn in your work:

; a. If you were working with separate parts, combine the two parts of 
;    the assignment into one file.
; b. Ensure that your file runs properly.  (E.g., when we click "Run", it should
;    work not produce errors.)
; c. Make sure that this file is named `procedures.scm`.
; d. Submit this final file to Gradescope.  Make sure to submit your work 
;    as a group submission and include your partner in the submission.
; e. Wait for the autograder results to make sure that you met the
;    basic goals.

; +---------------------------+--------------------------------------
; | For those with extra time |
; +---------------------------+

; If you find that you have extra time, you should try one or more of
; the following exercises. 

; +----------------------------+-------------------------------------
; | Extra 1: Rounding          |
; +----------------------------+

; Write a procedure which rounds a number to a given number of decimal points. 
; For example:
;   (round 22.71256 2) should produce 22.71


; +-----------------------+------------------------------------------
; | Extra 2: More tracing |
; +-----------------------+

; Try tracing
; one more function call.

;     (my-func-3 11)
; --> ...
;

(define example-expr-3 (my-func-3 11))

; +-------------------------+----------------------------------------
; | Extra 3: Counting words |
; +-------------------------+

; We can use the following code to count the number
; of words in a string.

;;; (count-words str) -> integer?
;;;    str : string
;;; Determine approximately how many "words" appear in the
;;; given string.
(define count-words
  (lambda (str)
    (length (string-split str " "))))

; a.  Check the behavior of count-words on a few inputs.  Copy and paste
; your experiments here.
;
; ...
;

; b. In your own words, explain how count-words works.
;
; ...
;
