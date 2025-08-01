---
title: Recursion over Numbers
mathjax: true
---

The heart of our recursive functions so far is our recursive definition of lists:

> A list is either:
> +   Empty (`null`) or
> +   Non-empty (`(cons head tail)`) with a `head` element and a sub-list, its `tail`.

Our recursive functions mirror this recursive definition.
So it stands to reason that if we are able to give a recursive definition for _any_ type, then we can perform recursion over that type similarly!

Many kinds of data admit recursive definitions, and you will encounter many of them throughout your computer science journey.
However, there is one datatype that trumps them all---perhaps even more so than a list!
It is the _natural number_.
Recall that the natural numbers are the _non-negative integers_.
This includes the numbers \\( 0 \\), \\( 1 \\), \\( 2 \\), \\( 3 \\), ..., _etc_.

Our definition of a list was recursive because at least one of the cases included a smaller list inside itself.

~~~
head [     tail     ]
 ^           ^
 |           |
 element     sublist
~~~

We can see via the picture where the smaller list is located: it's the tail of the list!
However, now let's consider a natural number, say \\( 5 \\):

~~~
5
~~~

Ugh.
Unlike lists, it is not immediately obvious what the "smaller" natural number is in this situation.
Where is it hiding?

One way to discover where the smaller natural number exists inside of \\( 5 \\) is to answer the following question: how can we express \\( 5 \\) in terms of some small natural number?
This perspective opens up many possibilities!
For example, the following expressions all evaluate to \\( 5 \\):

+   \\( 4 + 1 = 5 \\).
+   \\( 2.5 * 2 = 5 \\).
+   \\( 1 + 1 + 3 = 5 \\).

And so forth.
Of these options, addition-by-one is most like the head-tail relationship for lists.
Let's compare the two perspectives:

+   Consider the list `(list 1 2 3 4 5)`.
    We can express this list as `(cons 1 (list 2 3 4 5))` where `1` is the head and `(list 2 3 4 5)` is the tail.
    We join the head and tail to form the overall list with `cons`.
+   Consider the natural number \\( 5 \\).
    We can express this natural number as `(+ 1 4)` where \\( 4 \\) is the smaller natural number.
    We add one to this number to obtain the natural number \\( 5 \\).

In general, we call \\( 5 \\) the _successor_ of the smaller natural number \\( 4 \\).
We can see that almost every natural number has a successor:

+   \\( 5 \\) is the successor of \\( 4 \\).
+   \\( 13 \\) is the successor of \\( 12 \\).
+   \\( 1 \\) is the successor of \\( 0 \\).

However, because natural numbers are _non-negative integers_, \\( 0 \\) is not a successor of any other number.
It is the _base case_ for our recursive natural number definition!
Combining these two ideas, we arrive at our _recursive definition for the natural numbers_:

> A natural number is either:
> +   Zero or
> +   The successor or "plus one" of a smaller natural number.

With this definition, we can solve problems using recursive decomposition on natural numbers!

## Example: Factorial

A classical example of a mathematical function with a recursive definition is _factorial_, written \\( n! \\).
\\( n! \\) is the product of the numbers from \\( 1 \\) to \\( n \\), _e.g._, \\( 5! = 1 \times 2 \times 3 \times 4 \times 5 = 120 \\).
In general, \\( n! = 1 \times \cdots \times n \\).

Suppose we were to go to implement a `factorial` function that returns \\( n! \\) when given an natural number argument `n`.
We can't implement the "⋯" in Scheme directly, so we need to find some alternative way of expressing this computation.
Let's see if we can find a recursive decomposition for `factorial` in terms of our recursive definition for the natural numbers:

> To compute the factorial of some natural number `n`:
> +   When `n` is zero... (a)
> +   When `n` is non-zero... (b)

{:type="a"}
1.  When `n` is zero, we should return `0!`.
    But what is `0!`?
    It turns out that the factorial function is _defined_ so that \\( 0! \\) is 1.
    This seems arbitrary since asking the question "multiply the numbers from 1 to 0" is a malformed question!
    Indeed, we define \\( 0! = 1 \\) _by convention_ because it makes our mathematical formulae work without the need for special cases.
2.  When `n` is non-zero, it is the successor of some smaller number, call it `k` with \\( k + 1 = n \\).
    How can I express factorial of \\( n \\) in terms of factorial of \\( k = n - 1 \\)?
    Let's look at a concrete example: suppose \\( n = 5 \\) so \\( k = 5 - 1 = 4 \\).
    We have:

    \begin{align}
    5! =&\; 1 \times 2 \times 3 \times 4 \times 5 \\\\ 4! =&\; 1 \times 2 \times 3 \times 4
    \end{align}

    In terms of recursive design, our recursive assumption says we can compute \\( 4! \\).
    How can we then compute \\( 5! \\) in terms of \\( 4! \\)?
    We can see above that \\( 5! = 4! \times 5 \\).
    We can then generalize this idea to conclude that when \\( n \\) is non-zero, \\( n! = (n-1)! \times n \\).

This gives us a final recursive decomposition for factorial:

> To compute the factorial of some natural number `n`:
> +   When `n` is zero, the factorial of `0` is `1` by definition.
> +   When `n` is non-zero, the factorial of `n` is the factorial of `n-1` times `n`.

We can then translate this decomposition directly into our desired function:

<pre class="scamper source">
(import test)

(define factorial
  (lambda (n)
    (if (zero? n)
        1
        (* n (factorial (- n 1))))))

(test-case "factorial zero"
  = 1
  (lambda ()
    (factorial 0)))

(test-case "factorial non-zero"
  = 120
  (lambda ()
    (factorial 5)))
</pre>

Note that we use the `zero?` function to test whether `n` is zero which works only because we assume as a precondition that `n` is a natural number, _i.e._, non-negative.
We could also instead choose to use a comparison operator, _e.g._, `(= n 0)` or `(> n 0)` (and flip the order of the conditional branches), to achieve the same effect.
To access the predecessor of `n` (_i.e._, the number of which `n` is a successor), we use subtraction.

Alternatively, we can also use pattern matching, passing in an appropriate _numeric literal_ for the base case:

<pre class="scamper source">
(import test)

(define factorial
  (lambda (n)
    (match n
      [0 1]
      [_ (* n (factorial (- n 1)))])))

(test-case "factorial zero"
  = 1
  (lambda ()
    (factorial 0)))

(test-case "factorial non-zero"
  = 120
  (lambda ()
    (factorial 5)))
</pre>

In the recursive case, we can't use a pattern to bind the number "one less than `n`."
So instead, we use a _wildcard pattern_, `_` to match _anything_ that reaches the second branch.
Note that `match` expressions are consumed in top-down order, so if `n` is not `0`, then---assuming `n` is a natural number---it is non-zero, so the second branch should always apply.
For _numeric recursion_, _i.e._, recursion over the natural numbers, you should feel free to use either pattern matching or an appropriate `if` or `cond` expression.

One final thing to observe is that the standard recursive definition of factorial typically presented as:

\begin{align}
0! =&\; 1 \\\\ n! =&\; n \times (n-1)!
\end{align}

Aligns very closely with the pattern matching version of our code.
Indeed, pattern matching in programming comes from the use of pattern matching to elegantly define functions in mathematics.
Because programming draws on mathematics so much, we typically find that pattern matching allows us to concisely describe mathematical algorithms.

# Applying Numeric Recursion

We can use numeric recursion to implement recursively defined mathematical functions.
However, what elevates numeric recursion to such importance is that we can express many recursive patterns in terms of the natural numbers!
Indeed, the natural numbers form an ordering:

\\[
0, 1, 2, 3, 4, 5, \ldots
\\]

So we expect that if a data structure or algorithm can be expressed in some "ordered" fashion, we can use numeric recursion!

More examples will be explored on the lab.


# Self-checks

## Problem: The Termial

If factorial is the operation that performs repeated multiplication, then we call the operation that performs repeated addition the [terminal](https://proofwiki.org/wiki/Definition:Termial).
For example:

~~~racket
(terminal 10)
> 55
(terminal 0)
> 0
~~~

{:type="a"}
1.  Follow the example of `factorial` and give a recursive decomposition for `terminal`.
2.  Implement the `terminal` function based on this decomposition.

