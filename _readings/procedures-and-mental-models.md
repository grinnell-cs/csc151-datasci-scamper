---
title: Procedures and mental models of computation
summary: |
  We apply our mental model of computation to procedures.
mathjax: true
---

So far, we have introduced a number of features of the Scheme programming language including top-level definitions, procedure declarations, and procedure applications.
We have also focused nearly exclusively on how to *author* programs using these tools, appealing to your intuition about these constructs to explain how they work.

We've also recently learned about the _substitutive model of evaluation_.
Basically, to evaluate an expression, we evaluate all of the arguments to the function and then apply the function.
For convenience, we've been doing this left-to-right.
The self-referential nature of the model also means that we end up evaluating expressions from inner to outer.

As you might expect, procedures complicate matters.
Our intuition and the model might not be enough when we run into some special situations (some folks call these "corner cases") that we may run into when writing Scheme programs.

For example, consider the following procedure definitions:

```racket
(define f (lambda (x) (+ x 1)))

(define g (lambda (y) (+ y 1)))
```

Are these two procedures equivalent?
Textually, the procedures `f` and `g` are nearly identical, but the names of the parameters are different.
Does this difference matter?
Our intuition says no: parameter names don't seem to matter in this regard.
For example, if we try out these procedures in the Interactions pane:

```racket
> (f 5)
6
> (g 5)
6
> (f -1)
0
> (g -1)
0
```

There's too many integers to test in this manner, but after a few checks of this sort, we feel pretty confident in our intuition.

However, what happens if we have the following situation:

```racket
(define x 100)

(define f (lambda (x) (+ x 1)))
```

What will `(f 10)` produce?
Two possible answers are:

+  `101` if the `define`ed version of `x` is used in the computation of `f`.
+  `11` if the value of `10` that is passed to the procedure is used.

But maybe the code produces an error because there are two different `x`'s, and the computer gets confused.
Or even more bizarre, but not out of the realm of possibility: maybe the `define`ed `x` is now `10` or `11`!

Which of these is the correct answer?
We can, of course, run this code to find out:

```racket
> (f 10)
11
> x
100
```

But *why* is this the case?
What rules govern the execution of Scheme programs and how can they explain this behavior?

Before going too much further, let's try a similar pair of procedures.

```racket
(define eff (lambda (x) (+ x x)))

(define gee (lambda (y) (+ x y)))
```

Once again, we have a pair of procedures that seem to differ primarily in the name of the parameter.
Both add the parameter to `x`.
But is it the same `x`?  What do you expect to happen for each of the following?

```
> (eff 10)

> (gee 10)

```

Before reading on, come up with a hypothesis.

Did you do so?

Great.
Try it in your Scheme interpreter (DrRacket or Scamper or ...).
You may also want to look at our notes at the end.

(_Pause inserted in document so that you can check your answer by entering it in a Scheme interpreter, looking at the notes, or both._)

Since `x` does not always have a value, `(gee 10)` results in an error that `x` is undefined.

However, if `x` is defined, things will work fine.
The two functions will just be a bit inconsistent.

```racket
> (define x 100)
> (eff 10)
20
> (gee 10)
110
```

As you've likely concluded, understanding all that is going on is a bit complex.

In this reading, we'll consider a set of rules to help us better understand Scheme programs using our mental model of computation.
This mental model will allow us to interpret many Scheme programs and accurately predict their results.
Note that the mental model does not completely follow the implementation used in most Scheme interpreters; life is a bit too complex for that.
However, it will help you understand most small programs.
And we will extend the model throughout the semester.


## Procedures and the substitutive model


We've already studied how to apply our mental model to built-in procedures such as this one:

```
    (+ (+ 1 1) 8)
--> (+    2    8)
--> 10
```


However, what happens when our procedures are those we have defined ourselves?
For example, something simple like `double`:

```racket
(define double
  (lambda (n) 
    (* 2 n)))
```

How does an expression like `(double (/ 6 3))` evaluate?
As a first order of business, we should evaluate its argument to a value.

```
    (double (/ 10 2))
--> (double 5)
```

Good!
Now how does `(double 5)` evaluate?
We proceed as follows:

1.  We *substitute* the *body* of the procedure for the procedure call in question.
    The body of `double` is `(* 2 n)` so we would replace `(double 5)` with `(* 2 n)`.
2.  Note that, on its own, the parameter `n` is not defined!
    To patch this up, we also substitute each argument for its associated parameter in the body of the procedure.
    We pass `5` for `n` so we ultimately replace `(double 5)` with `(* 2 5)`.

All of this occurs in one step of evaluation and afterwards, we continue evaluation of the expression as normal.
So the complete evaluation of our original expression is:

```
    (double (/ 10 2))
--> (double    5)
--> (* 2 5)
--> 10
```

While this rule is simple, it covers almost *all occurrences* of procedures we'll see in Scheme!
This is the beauty of a programming language at its core: a small set of rules governs a near, unimaginable set of behavior we can author in a computer program!

## Definitions, tables, and procedures

We've separately considered models for the definitions that let us evaluate variables for procedures.
Let's also consider them together.
We know that `(define var exp)` evaluates the expression and the pairs it with the variable in a table.
So what happens when we write `(define var (lambda (params) body))`?

It turns out that Scheme does something a bit special with lambda expressions (expressions that begin with lambda).
Instead of evaluating them further, Scheme stops evaluating until you need to apply the lambda expression.
Then, and only then, does it do what we described above: We substitute it in for the name and then replace its named parameters (the "formals", in CS parlance) with the values of the corresponding arguments (the "actuals", in CS parlance).

It turns out that these model of operation means we can use lambdas without defining them.
We'll leave that issue for a bit later in your education.

## Self-checks

### Check 1: Code tracing (‡)

Assume the existence of the following Scheme definitions:

```racket
(define add-3
  (lambda (x y z)
    (+ (+ x y) z)))

(define triple
  (lambda (n)
    (add-3 n n n)))
```

With these definitions, give the step-by-step evaluation (*i.e.*, evaluation traces) for each of the following expressions.
Please do this by hand; don't rely on the tools that might be part of your Scheme interpreter.
Make sure to write down *all* steps of evaluation as required by our substitutive model of computation!

{:type="a"}
1.  `(add-3 (* 2 3) (+ 8 3) (/ 1 2))`
2.  `(triple (+ 5 0.25))`

Make sure to check your work by entering these expressions into your Scheme interpreter!

## Appendices

### Appendix A: `eff` and `gee`

What should we get for `(eff 10)`?  Presumably, `x` gets the value `10`, we add the two `10` values together, and end up with `20`.

Let's check.

```
> (eff 10)
20
```

But what happens when we try `(gee 10)`?  In that case, `y` gets the value 10.  What value does `x` have?  Unless we've defined `x` with `define`, it has no value.  Perhaps we'll get an error.

```
> (gee 10)
. . x: undefined;
 cannot reference an identifier before its definition
```