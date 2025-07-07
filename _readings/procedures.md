---
title: Writing your own procedures
summary: |
  We explore why and how to define your own procedures in Scheme.
preimg: true
---

# Writing your own procedures

In today's reading, we explore why and how to define your own procedures in Scheme.

## Introduction

As you may recall from the introduction to algorithms, the ability to write subroutines is one of the key components of algorithm design.
Subroutines typically have a _name_ that we use to refer to the subroutine, zero or more _parameters_ that provide the input to the subroutine, and a set of _instructions_ (an expression in Scheme) for doing the computation.
That is, a subroutine is just an algorithm that has been named and "parameterized".

For example, we might want to define a procedure, `square`, that takes as input a number and computes the square of that number.

<pre class="scamper source">
(square 5)
(square 1.5)
(square 0.333)
(+ (square 0.5) (square 0.333))
(square (square 2))
</pre>

As you may have noted, `square` can have multiple meanings.

An aside note: when we choose names in Scheme, we should try not to conflict with existing names (here `square` is an existing name in Scheme).
Sometimes Scheme will stop us from reusing a name; other times it will blithely move along, letting us break things through such reuse.

So, how do we define these procedures?  Read on and see.

## Defining procedures with `lambda`

Scheme provides a variety of mechanisms for defining procedures.
We will start with the most general, which uses the keyword `lambda`, which means "procedure".
The lambda mechanism is relatively straightforward.

As you may recall, we typically think of a procedure as having three main aspects: The _name_ we use to refer to the procedure, the names of the _parameters_ (inputs) to the procedure, and the _instructions_ the procedure executes.

Here is the general form of procedure definitions in Scheme, at least as we will use them in this class.
Scheme does not require the indentation, but it makes it much easier to read and we will require it in this course.

```racket
(define <identifier>
  (lambda (<parameters>)
    <expression>))
```

You've already seen the `define`; we use `define` to name things.
In this case, we're naming a procedure, rather than a value.

The `<identifier>` part is straightforward; it's the name we will use to refer to the procedure.
The "`lambda`" is a special keyword in Scheme to indicate that "_Hey! This is a procedure!_".
Lambda has a special place in the history of mathematical logic and programming language design and has meant "function" or "procedure" since the early days of formal logic.
Lambda is special enough that the designers of Scamper chose it for the icon.)

The `<parameters>` are the names that we give to the inputs.
For example, we might use the names `side-length` and `color` for the inputs to our "make a square of s certain color" procedure.  Similarly, we might use the name `x` for the input to the "square a number" procedure.

Finally, the `<expr>` is a Scheme expression that is the computation that the function performs when called.

Let's look at a simple example, that of squaring a number.

<pre class="scamper source">
(define square-number
  (lambda (x)
    (* x x)))
</pre>

Mentally, most Scheme programmers read this as something like

> `square-number` names a procedure that takes one input, `x`, and computes its result by multiplying `x` by itself.

Let's also look at some examples of using our new procedure.

<pre class="scamper source">
(define square-number
    (lambda (x)
      (* x x)))
(square-number 5)
(square-number 0.5)
(square-number (square-number 2))
square-number
</pre>

You may note in the last line that when we asked Scamper for the "value" of `square-number`, it told us that it's a function.
Compare that to other values we might define.

<pre class="scamper source">
(define x 5)
x
(define phrase "All mimsy were the borogoves")
phrase
(define multiply *)
multiply
</pre>

In every case, Scamper is showing us the _value_ associated with the name.
In some cases, it's a number.
In some cases, it's a string.
In some cases, it's an image.
And, in some cases, it's a procedure.

How does the procedure we've just defined work?
Here's one way to think about it: When you call a procedure you've defined with `lambda`, Scamper substitutes in the arguments in the procedure call for the corresponding parameters within the instructions.
After substituting, it evaluates the updated instructions.

For example, when you call `(square-number 5)`, Scamper substitutes `5` for `x` in `(* x x)`, giving `(* 5 5)`.
It then evaluates the `(* 5 5)`, computing 25.

What about a nested call, such as `(square-number (square-number 2))`?
As you may recall, Scheme evaluates nested expressions from the inside out.
So, it first computes `(square-number 2)`.
Substituting `2` in for `x`, it arrives at `(* 2 2)`.
The multiplication gives a value of `4`.  The `(square-number 2)` is then replaced by `4`.
Scamper is then left to evaluate `(square-number 4)`.
This time, it substitutes `4` in for the `x`, giving it `(* 4 4)`.
It does the multiplication to arrive at a result of `16`.

We might show the steps as follows, with the `-->` symbol representing
the conversion that happens at each step.

```racket
    (square-number (square-number 2))
--> (square-number (* 2 2))
--> (square-number 4)
--> (* 4 4)
--> 16
```

## Another example

The above example, `square-number` was relatively straight forward. Let's try something more complex.

A _z-score_ is a standard is a way of measuring how far a given piece of data is away from the mean (average) of a set of data.

`z-score = (x - mean) / (standard deviation)`

In this formula, x is the piece of data we want to measure and give a score. You'll notice that this formula requires us to know something about all of the data to start with: namely, the mean and the standard deviation. Don't worry if you're not sure what all these words mean (you can read [here](https://en.wikipedia.org/wiki/Standard_score) for more info if you'd like), we just need to understand that this a formula I'd like to compute.

Say there is some data with a mean of `5` and a standard deviation of `.4`. How far away is `x = 6` from the mean? We can use the z-score:

<pre class="scamper source">
(/ (- 6 5) .4)
</pre>

`x=6` has a z-score of 2.5.

What if we want to calculate the z-score for another piece of data? We could copy and paste the code and change the values. However, it might be more efficient to write a procedure that takes `x` as a parameter.

<pre class="scamper source">
(define zscore
  (lambda (x)
    (/ (- x 5) .4)))

(zscore 6)
(zscore 5.5)
</pre>


This works pretty well! Is it readable and understandable to an outside observer? Maybe. Could we improve it? Definitely. There are a number of ways we could do this. We could parameterize the mean and standard deviation, in addition to the piece of data we're trying to evaluate.

<pre class="scamper source">
(define zscore2
  (lambda (x mean std)
    (/ (- x mean) std)))

(zscore2 6 5 .4)
(zscore2 5.5 5 .4)
</pre>
This has the benefit of allowing the user to also use this code on other data sets (ones with different means and standard deviations). It also makes clear to the reader what two of the values represent, by naming them `mean` and `std`. 


## Zero-parameter procedures
We've written procedures so that they take one or more parameters. However, there are also advantages to writing procedures that take no parameters. For now, just remember it's a possibility. In the future, you'll see when it's useful.


## Some benefits of procedures

As you may have figured out by now, there are many benefits to defining your own procedures.
One of the most important is _clarity_ or _readability_.
Another programmer will likely spend less effort understanding `(zscore2 5)` than they will trying to understand the expression without any context.

As importantly, the other programmer may also find it easier to _write_ programs using `zscore2` than the much longer series of expressions.

By using a name for a set of code, we are employing the concept of _abstraction_.
That is, because the person calling the procedure knows _what_ the procedure does rather than _how_ it achieves that result, we have abstracted away some of the details.
Of course, for someone to know what the procedure does, you need to choose a good name for the procedure and for the parameters. 
`x` tells us very little.
`mean` or `std` gives us much more of a sense of what the procedure does.
Be thoughtful in your choice of names!


There are benefits to abstraction and the use of procedures other than readability.
For example, it may be that you discover a more efficient way to do a computation.
If you've written the same code for the computation throughout your program, you'll have a lot of code to update.
But if you've created a procedure, you need only update one place in your code, the place you've defined the procedure.

There are other ways in which procedures make us more efficient.  For example, if we decide to change what our houses are like---say, by making the roof wider than the body of the house---we only have one place in our program to update.

As these examples suggest, using procedures to parameterize and name sections of code provides us with a variety of advantages.
First, we can more easily _reuse_ code in different places. Rather than copying, pasting, and changing, we can simply call the procedure with new
parameters.
Second, others can more easily _read_ the code we have written, at least if we've chosen good names.
Third, we can more easily _update_ the procedures we've written, either to make them more efficient or to change behavior universally.

## Using `lambda` without `define`

Scheme and related languages differentiate themselves from most other languages in that you can use `lambda` (or, more generally, subroutines) to define a procedure without bothering to name the procedure.
Recall, for example, that `(lambda (x) (* x x))` represents "a procedure that takes one input, `x`, and computes `x` times `x`".
Since that's a procedure, Scheme permits us to write it in the "procedure slot" in an expression, as in

```racket
    ((lambda (x) (* x x)) 5)
```

What does that mean?
It means "take a procedure that takes one input, `x`, and computes `x` times `x` and apply it to `5`, substituting the `5` for the `x`.

```racket
    ((lambda (x) (* x x)) 5)
--> ((lambda (x) (* x x)) 5)
--> (* 5 5)
--> 25
```

That doesn't seem very useful, does it?
And it's *much* harder to read, at least for now.
But it's worth it.
The power comes in when we use these "anonymous" procedures along with other tools.
For example, the `map` procedure which we covered briefly and will return to applies a procedure to each element of a list.

```racket
    (map (lambda (x) (* 3 x)) (list 1 2 3))
--> (list ((lambda (x) (* 3 x)) 1)
          ((lambda (x) (* 3 x)) 2)
          ((lambda (x) (* 3 x)) 3))
--> (list (* 3 1)
          (* 3 2)
          (* 3 3))
--> (list 3 6 9)
--> '(3 6 9)
```

Don't worry if you don't quite get this section!
We'll return to the concepts in a week or two.

## Self Checks

### Check 1: A simple procedure

Write a procedure, `(subtract2 val)`, that takes a number as input and
subtracts 2 from that number.

```racket
> (subtract2 5)
3
> (subtract2 3.25)
1.25
> (subtract2 "hello")
-:  Runtime error:
    A number? was expected, but a str was found
    In program: "hello"
```

### Check 2: Exploring steps

Show the steps involved in computing `(square (subtract2 5))` and
`(subtract2 (square 5))`.



## Q&A

_These are questions gathered from previous reading responses._

Do we have to use they keyword `lambda` every time we want a procedure that takes in a parameter?

> Yes.  In fact, you have to use `lambda` if you want a
procedure with no parameters.

What would be the difference between a zero parameter procedure and defined variable?

> Right now, the biggest difference between a zero-parameter procedure and a defined variable are that you use them differently.  The variable you use with its name; the procedure you put in parentheses.

> Later in the semester, we'll see some differences.  One difference is when the associated code is executed.

## Acknowledgements

This section draws upon [a reading entitled "Defining your own
procedures"](https://www.cs.grinnell.edu/~rebelsky/Courses/CSC151/2018S/readings/procedures)
and [an earlier reading entitled "Writing your own
procedures"](https://www.cs.grinnell.edu/~rebelsky/Courses/CSC151/2017S/readings/procedures-rgb-reading.html)
from Grinnell College's CSC 151.

It was updated in Spring 2022 to remove much of the discussion of zero-parameter procedures and to add a short section on anonymous procedures.

The house drawing was inspired by a more sophisticated house drawing
from the [Scheme Image
Guide](https://docs.racket-lang.org/teachpack/2htdpimage-guide.html).