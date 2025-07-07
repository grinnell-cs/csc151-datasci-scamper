---
title: Mental models of computation
summary: |
  We introduce a mental model of computation for Scheme programs that allows us to read code and predict its behavior without having to run the program.
mathjax: true
---


## Expressions

As we've seen, _expressions_ lie at the core of Scheme.
Expressions are syntactic constructs that evaluate to values.
We are intimately familiar with expressions already: they form the basis of computation in arithmetic!
For example, here is an arithmetic expression:

\\[
3 × (8 + 4 ÷ 2)
\\]

This expression evaluates to a final value, \\( 30 \\).
We say that \\( 30 \\) is a *value*: it is an expression that no longer takes any steps of evaluation.

The analogous Scheme code is also an expression:

```racket
> (* 3 (+ 8 (/ 4 2)))
30
```

This extends to Scheme code that doesn't involve numbers at all!

```racket
(> (string-upcase (string-append "hello world" "!!!"))
"HELLO WORLD!!!"
```

Here the expression produces a string as output---the upper-case version of the string resulting from gluing `"hello world"` and `"!!!"` together.

## A substitutive model of evaluation

The process of determining the value that an expression produces is called *evaluation*.
The evaluation of expressions is the primary way that we perform computation in Scheme!
But how do expressions evaluate?
We determine how expressions evaluate by applying two basic sets rules:

1. *Rules of precedence* that tell the order in which to evaluate operators.
2. *Associativity rules* that tell us how the arguments to operators *bind* when chained together.

For arithmetic, we know that division and multiplication are evaluated before addition and subtraction.
Furthermore, expressions in parentheses are evaluated first, irrespective of the operators involved.
Finally, we typically expect that the arithmetic operators are *left-associative* resulting in a *left-to-right* evaluation order.

```
  3 × (8 + 4 ÷ 2)
= 3 × (8 +   2  )
= 3 ×     10
= 30
```
At every step of evaluation,

1. We determine the sub-expression to evaluate next based off of our rules.
2. We evaluate that sub-expression to a value.
3. We *substitute* the resulting value for that sub-expression to create a new, slightly simplified expression.

We then repeat this process until we arrive at a final value.

While we may find Scheme's syntax arcane at first, it has one major benefit: There is only one rule for determining order-of-operations for expressions!
That rule is straightforward: *evaluate the arguments to a procedure before appling the procedure*!
(Some of us say "evaluate the innermost parenthesized expression first".)
There is nothing else to know.
Or almost nothing else to know.
Let's see how that works for the Scheme version of this arithmetic expression:

```
    (* 3 (+ 8 (/ 4 2)))
--> (* 3 (+ 8    2  ))
--> (* 3      10     )
--> 30
```

(Note that we use the symbol `-->` to denote that one expression in Scheme evaluates or *steps* to another expression.)

Perhaps it would've been better in grade school if you were introduced to Scheme-style infix notation for arithmetic operations first.
There are fewer rules to memorize, after all.

Okay, perhaps it's not quite that simple.
What happens if a a procedure is called with multiple arguments, each of which is an expression?

```
    (* (+ 1 2) (+ 4 1))
```

We need to evaluate the `(+ 1 2)` before we do the multiplication.
We need to evaluate the `(+ 4 1)` before we do the multiplication.
But which of those to should we do first?
Generally, *it doesn't matter*.
Let's check.

First, we'll evaluate the first argument first.

```
    (* (+ 1 2) (+ 4 1))
--> (* 3 (+ 4 1))
--> (* 3 5)
--> 15
```

Next, we'll evaluate the second argument first.

```
    (* (+ 1 2) (+ 4 1))
--> (* (+ 1 2) 5)
--> (* 3 5)
--> 15
```

You may not be surprised to discover that we got the same result in each case.
But it turns out that we can't guarantee that in all programming languages.
(We can't even guarantee it in Scheme, but we can guarantee it for most of the programs we write.)
Nonetheless, for the time being, you can assume that the order in which we evaluate arguments does not matter, provided you evaluate arguments before you apply a procedure.
And, even though the order does not matter, we will generally evaluate arguments left to right.

## Definitions

We have a starting point.
We know how to evaluate expressions.
But expressions often involve identifiers (names).
In Scheme, we bind values to identifiers using `define` statements.
How should we mentally model `define` statements and the names they define?

One easy way to think about them is in terms of a table that tells us what value to use for each name.
When we see a `define` statement, we first evaluate the expression and then we put the name and the value in the table.
We tend to write that as `name:value`.

```
    ; Table: []
    (define x 5)
    ; Table: [x:5]
    (define y 17)
    ; Table: [x:5, y:17]
    (define z (* 2 3))
--> (define z 6)
    ; Table: [x:5, y:17, z:6]
```

What good is the table?
The table informs how we evaluate expressions that consist only of variables (named values).
When evaluating an expression, when the next expression to evaluate is a variable, we look in the table to find the value associated with the variables.

```
    ; Table: []
    (define x 10)
    ; Table: [x:10]
    (define y 2)
    ; Table: [x:10, y:2]
    (+ (* x 4) y))
    ; We need to evaluate the (* x 4) before we add
    ; We need to evaluate the x before we multiply.
    ; We look x up in the table
--> (+ (* 10 4) y)
    ; We need to evaluate the (* 10 x) before we add
--> (+ 40 y)
    ; We need to evaluate the y before we add
    ; We look y up in the table
--> (+ 40 2)
--> 42
```

Seems pretty straightforward.  Right?
What happens if we write an expression that involves a variable not in the table?

```
    ; Table: [x:10]
    (+ (* x 4) y))
--> (+ (* 10 4) y)
--> (+ 40 y)
    ; y is not in the table
    y: undefined
```

Note that these tables are mostly a notational convenience, designed to make it easier for us to figure out the value of expressions when we're tracing.
However, most programming languages, including Scheme, also have a hidden form of table which basically does the same thing (that is, that associates values with variables names).

## Procedures and the substitutive model

When we evaluate procedures, we have implicitly "carried out the behavior of the procedures" in our head and replaced the procedure call with the value.
For example

```
    (+ 1 1)
--> 2
```

We know how addition works, so we can treat the evaluation of `+` as a single step.
Of course, if the arguments to `+` required evaluation first, we would need to carry that out according to our evaluation rules:

```
    (+ (+ 1 1) 8)
--> (+    2    8)
--> 10
```

The step-by-step evaluation of an expression to a final value is called the *execution trace* or just *trace* of a particular expression.


## Self-checks

### Check 1: Code tracing (‡)

Give the step-by-step evaluation (*i.e.*, evaluation traces) for the following expression.
Please do this by hand; don't rely on the tools that might be part of your Scheme interpreter.
Make sure to write down *all* steps of evaluation as required by our substitutive model of computation!


`(+ 3 (* 5 (/ 2 (- 10 5))))`


Make sure to check your work by entering these expressions into your Scheme interpreter!

