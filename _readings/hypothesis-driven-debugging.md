---
title: Hypothesis-driven debugging
summary: |
  We present a systematic approach to debugging your code and show you how you can use debugging tools to augment this approach.
---

## Hypothesis-driven debugging

*Hypothesis-driven debugging* captures the idea that we can use the scientific process to make debugging systematic rather than ad-hoc.
In this framework, we are observing and ultimately making predictions about the behavior of our program.
There are five steps to hypothesis-driven debugging:

1.  Gather data
2.  State assumptions
3.  Predict what is wrong
4.  Use tools to verify/refute your prediction
5.  Analyze your results

### Gather data

In the first step, we gather data about the error that we have encountered.
Primarily, this is the *indicator* that we have encountered an error in the first place.
In many cases this is the *error message* generated by Scheme as the result of faulty syntax, a violated contract, *etc*.
However, in the case of other errors, this may be more subtle, *e.g.*, the output of a function not matching what you expected.

Scheme error messages help you narrow down the *location* and *kind* of error ultimately plaguing your code.
Sometimes the error message is very clear about these things, *e.g.*, this contract violation:

~~~racket
+: contract violation
  expected: number?
  given: "1"
  argument position: 2nd
  other arguments...:
~~~

Tells me that the second argument, `"1"`, violates the contract of `+` because a `number?` was expected.
In contrast:

~~~racket
read-syntax: expected a `)` to close `(
~~~

Hints at, but does not outright say, that the problem is that we're missing parentheses in our code.
Furthermore, this error message does not say *where* the missing parentheses might be.

Because of the imprecision of errors, we rely on other data to get our bearings.
This includes:

+   The *topology* of the program, *i.e.*, the order in which functions are called in our program.
    This is also captured by the *call stack* of an error which describes the sequence of function calls that generated the error in question.
+   Our knowledge of what parts of the code were last edited since the appear began appearing.
    This is also called the *delta* of the code we added since our last successful execution of the program.

These are things you likely "just know" about your program, but it is important, especially early on, to explicitly acknowledge these facts in your mind when you encounter an error.
In some cases, you might find it productive to *write down* this information to get it out of your head!

**Kinds of errors**

It is useful to understand the different kinds of errors possible when programming.
Each kind of error begets its own set of strategies for ultimately resolving the problems at hand.

Regardless of programming language, we break up errors into two overarching classes:

+   *Static errors*: these are errors that happen *before* the program executes.
+   *Dynamic errors*: these are errors that happen *during program execution*.

Some languages and their tools have well-defined "pre-execution" phases where the program is *compiled* into an executable in one step and then ran in a second step.
Scamper bleeds the pre-execution and execution phases together in its "Run" button.
When run is pressed:

+   Scamper first checks the syntax of our program to ensure that it is well-formed.
    It also checks to ensure that all of our usage of identifiers are well-scoped.
+   Scamper then runs the program and outputs the result in a window.

Within each class of errors, there are different sub-categories of errors that are dependent on the language involved.
In Scheme, there are two kinds of static errors you will encounter:

+   **Syntax errors** where the program is malformed in some way, *e.g.*, missing a parentheses.
+   **Undefined identifier errors** where an identifier is used outside of its scope.
    Recall that Scheme is a *lexically scoped* language.
    That is, the syntax of the program alone determines where an identifier is *live* or usable.

In Scheme, virtually every other error you see is a dynamic error of some form or another.
These include:

+   **Contract violations** where a value is passed to a function and that value does not fulfill the function's contract (preconditions).
+   **Exceptions** where function-defined errors are raised, *e.g.*, divisor by error or out-of-bounds list indexing.
+   **Logic errors** where a program is semantically correct, *i.e.*, language constructs are used in a consistent manner, but the output of the program is still wrong.
    For example, your translation of an arithmetic formula may incorrectly contain a subtraction when an addition was needed.

## State assumptions

When designing your program, you made assumptions about its behavior.
For example, the preconditions and postconditions of a function codify assumption about its behavior.
Because the program didn't work as expected, those assumptions were likely violated in some way.
It is therefore important to explicitly consider what assumption you have made about your code as they can serve as starting points for further investigation.

For example, suppose we have a function that counts all of the occurrences of a given letter in the string:

~~~racket
;;; (extract-occurrences s c) -> exact-nonnegative-integer?
;;;   s : string?
;;;   c : char?
;;; Returns the number of occurrences of c in s.
~~~

And you receive the following contract violation (a dynamic error) when testing the function with the expression `(extract-occurrences 12718 #\1)`:

~~~
string-ref: contract violation
  expected: string?
  given: 12718
  argument position: 1st
  other arguments...:
~~~

If we note that our function expects that `s` is a `string?`, its precondition, then we can more readily identify the likely problem, even without looking at the code: `12718` is a `number?` rather than a `string?`.
Most likely, `s` is not a `string?` which violates our precondition.

## Predict what is wrong

We first *hypothesize* what is wrong with the code *before* we actually dive in and use debugging tools.
This is akin to the scientific method where we make our predictions before running our experiments.
In the context of general science, this is important because if we run our experiments first, we will likely make predictions specifically to *match the results* from the experiments.
This doesn't mean our predictions are wrong---indeed, we have to do some sort of *observing before predicting* to generate reasonable hypotheses in the first place.
But such behavior does not *scientifically validate* our hypotheses; additional experimentation is necessary to do so.

When debugging, we don't run risk of violating ethical standards if we observe-and-then-predict.
However, we do run the risk of *wasting our time* if we aren't entering the observation phase of debugging without a clear *prediction* to verify or refute.
Programs can be wrong in a startling amount of ways.
We can become quickly overwhelmed by the possibilities if we begin prodding the code with a debugger before we have an idea of what we are looking for.
Therefore, making predictions first helps us *tame the complexity of problem solving*.

If you can immediately predict the *root cause* of the error, that's great!
But frequently, that is not the case.
Instead, you might make smaller predictions about the behavior of parts of your program you suspect are problematic.
The most common of these predictions you might make are:

+   **"The value of this variable is *x*."**
    You make a prediction about the value of a particular variable.
+   **"I made it to this part of the code."**
    You make a prediction about the *flow* of execution in the program, *e.g.*, the program execute the if-branch versus the else-branch of a conditional?

In both cases, you can use the data and assumptions you gathered previously along with your mental model of computation to help you make these predictions.

## Use tools to verify/refute your prediction

It is only at step 4 where we actually use debugging tools!
Now that we have something concrete to look for, we can use our debugging tools to quickly find that thing rather than dig aimlessly.

In most languages, there are a variety of tools that people use to verify and refute predictions about our code's behavior.

+   *Loggers* that capture the relevant state of our program during its execution.
    Loggers include *print debugging* where you use the print-to-console facilities of most languages to quickly log values.
+   *Debuggers* that allow us to systematically execute a program step-by-step and inspect the contents of variables, the call stack, *etc.*
+   *Unit testing frameworks* that allow us to check smaller pieces of the program.
    (As you may have recently learned, it's often best to check small pieces of
    a program before checking bigger pieces.)
+   *Assertions* that allow us to verify conditions at certain points in a program
    and stop the program if those conditions aren't met.  

Each approach has some trade-offs:

+   Loggers, in particular, print debugging, are easier and more intuitive to use.
    However, they are limited in scope---you can only see what you log---and invasive to code---you litter your code with prints that you need to remember to clean up or comment out when you are done.
    There are also "Heisenbugs", situations in which the bug disappears when you
    log and reappear when you stop logging.
+   Debuggers are more comprehensive, powerful, and specifically do not leave "traces" in your code.
    However, that power comes at a price: debuggers can be more complicated to learn and more annoying to use on a consistent basis, especially for smaller problems.
+   Unit testing frameworks often focus on small parts.  Sometimes it's the combination of small parts that break things.
+   Assertions, like loggers, may need to be turned off (and may require effort
    to do so.  Assertions are also harder to use in a functional framework.

Our primary tool for debugging is the _explorations pane_ which allows us to reply execution of our program.

## Analyze your results

After using your debugging tool of choice, what are the ramifications of what you found?
If your prediction was the root cause, then congratulations; you're done!
Otherwise, your prediction has given you some new information.
What further predictions can you make that will get you closer to the root cause of the problem?
Repeat the hypothesis-driven debugging process until you unveil this cause!


# Self-Check: Going Through the Motions (‡)

In a previous lab, you wrote a function for making change given an amount of cents.
Here's an attempt at the function.

(Note this function uses functionality, namely `let`-bindings, we have not seen yet.
But that is ok!
We can use our tools, namely the stepper, and intuition to diagnose errors, even with new code!)

~~~racket
(define make-change
  (lambda (n)
    (let* ([quarters (quotient n 25)]
           [left-over (remainder n 25)]
           [dimes (quotient n 25)]
           [left-over (remainder left-over 25)]
           [nickels (quotient left-over 25)]
           [cents (remainder left-over 25)])
      (list quarters dimes nickels cents))))
~~~

However the function does not work as expected:

<pre class="scamper source">
(import test)

(define make-change
  (lambda (n)
    (let* ([quarters (quotient n 25)]
           [left-over (remainder n 25)]
           [dimes (quotient n 25)]
           [left-over (remainder left-over 25)]
           [nickels (quotient left-over 25)]
           [cents (remainder left-over 25)])
      (list quarters dimes nickels cents))))

(test-case "change example"
  equal? (list 5 0 0 4) (lambda () (make-change 129)))
</pre>

Go through each step of the hypothesis debugging process to discover, diagnose, and ultimately fix the problem.
For each step of the process, write a sentence or two about what you did and why.
For this problem, you do not have to submit your fixed code; we only want your description of what you did during the debugging process!