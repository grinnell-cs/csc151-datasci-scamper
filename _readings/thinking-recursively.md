---
title: Recursive Decomposition
---

In this course, we focus on the idea of _algorithmic decomposition_---solving a problem by solving relevant sub-problems. We realize the solution to these sub-problems primarily through definitions and functions.

However, we now begin the start of another perspective on how we can decompose a problem. Sometimes we can decompose a problem into a **smaller version of itself**, and this is called *recursion*.
Recursion is a cornerstone of algorithmic design in computer science.
Many problems are expressed beautifully and concisely using recursion.
However, recognizing that a problem can be decomposed using recursion requires substantial practice, so we will take our time working through and understanding this approach to problem solving.

## Decomposing Lists Recursively

We'll begin our study of recursion by revisiting the list datatype and explore how we can work with lists recursively.
For example, here is a picture that represents the list `(list 1 2 3 4 5)`.

![A list of the numbers 1 through 5.]({{ "/images/list-of-5-example.png" | relative_url }})

A *recursive interpretation* of a data structure involves being able to express that data structure in terms of a smaller version of itself.
In other words, where in this overall list do we see a small list lurking?
The interpretation that we use in functional languages like Scheme is the following:

![A list with the head element as 1 and the rest of the list unknown.]({{ "/images/list-of-5-example-head.png" | relative_url }})

Here, we identify the *head element* of the list, `1`.
By doing this, we can see that the rest of the list, *its tail*, is simply the remainder of the elements---they form a smaller list!
We can then look at the remainder of the list under the same lens: the head element of this smaller list is `2` and the tail of that sublist is yet another list.
This continues until we reach the end of the list.
We say that the tail of the sublist whose head is `5` is the _empty list_, or `null`.

Taking a step back, we can use this perspective on lists to give a definition of a list in terms of its possible _shapes_.

> A list is either:
> +   The _empty list_.
> +   A _non-empty list_ consisting of a _head_ element and a sub-list, its _tail_.

Because the non-empty list case contains a list, we say that the this definition is _recursive_, _i.e._, it references itself.

In Racket, the `car` and `cdr` functions (pronounced "car" and "could-er", respectively) allow us to decompose a list in this manner, respectively:

<pre class="scamper source">
(car (list 1 2 3 4 5))
(cdr (list 1 2 3 4 5))
</pre>


Note that these functions only "make sense" when the list in question is non-empty.
If we try calling these functions with the empty list, `null`, we receive errors:

<pre class="scamper source">
(car null)
(cdr null)
</pre>

Note that these errors say that `pair` is expected instead of a `list`.
There's a specific reason why the error says this, but for now, just note that if you call `car` and `cdr` on empty lists, you'll receive these errors.

To ensure that we don't call `car` and `cdr` on an empty list, we can use the `null?` function which takes a list as input and returns `#t` if and only if the list is empty, *i.e.*, *null*.
As an example, here is a use of `car`, `cdr`, and `null?` in combination to define a function `singleton?` that returns `#t` if the input list contains exactly one element.

<pre class="scamper source">
(import test)

(define singleton?
  (lambda (lst)
    (if (null? lst)
        #f
        (null? (cdr lst)))))

(test-case "singleton example"
  equal? #t
  (lambda () (singleton? (list 5))))

(test-case "non-singleton example"
  equal? #f
  (lambda () (singleton? (list 3 1 5 2))))

(test-case "empty list example"
  equal? #f
  (lambda () (singleton? null)))
</pre>

We can read the definition of `singleton?` as follows:

+   If the list is empty, then it *is not* a singleton.
+   Otherwise, the list is a singleton if the tail of the list is empty.
    We know this because in the else-branch of the conditional, we know the list contains at least one element, its head.
    So it is sufficient to check to see if the tail is empty which would imply there are no more elements other than the first.

Those who have embraced the Zen of Boolean might express `singleton?` as:

<pre class="scamper source">
(import test)

(define singleton?
  (lambda (lst)
    (and (not (null? lst))
         (null? (cdr lst)))))

(test-case "singleton example"
  equal? #t
  (lambda () (singleton? (list 5))))

(test-case "non-singleton example"
  equal? #f
  (lambda () (singleton? (list 3 1 5 2))))

(test-case "empty list example"
  equal? #f
  (lambda () (singleton? null)))
</pre>

Both versions align with our *recursive definition of a list*:

> A list is either:
> +   *Empty* or
> +   *Non-empty* with a *head* element and the rest of the list, called its *tail*.

`car`, `cdr`, and `null?` allow us to *use* with lists using this particular decomposition in mind.

We can *build* lists using this head-tail distinction with the `cons` function.
`(cons x xs)` creates a new list by appending the element `x` to the front of the list `xs`.

<pre class="scamper source">
(cons 1 (list 2 3 4 5))
</pre>

Because the second argument to `cons` is a smaller list, we can use `cons` repeatedly to obtain the same effect as our list literal syntax:

<pre class="scamper source">
(import test)

(test-case "list and cons produce the same results"
  equal? (list 1 2 3 4 5)
  (lambda () (cons 1
               (cons 2
                 (cons 3
                   (cons 4
                     (cons 5 null)))))))
</pre>

Note that `null` itself is a list, but since it is empty, it effectively ends this chain of calls to `cons`.

## A First Example: Summation

With our new list functions, let's define a procedure called `sum` that takes one argument, a list of numbers, and returns the result of adding all of the elements of the list together.
You already know one way to compute `sum`: You just `fold` the list with the `+` function.
Recall that `(fold f init l)` is identical to `(reduce f l)` except that we start with initial value `init` in our "summary" computation rather than the first element of `l`.

<pre class="scamper source">
(define sum
  (lambda (numbers)
    (fold + 0 numbers)))
(sum (list 91 85 96 82 89))
(sum (list -17 17 12 -4))
(sum (list 9.3))
(sum null)
</pre>

But let's try to implement `sum` not with `reduce` but recursive decomposition instead!

How can we decompose the problem of implementing `sum` using our recursive definition of a list?
We first recognize that `null?` allows us to easily express the *two cases* we outlined in the definition:

+ `null?` is `#t`: how do we `sum` an empty list?
+ `null?` is `#f`: how do we `sum` a non-empty list?

This leads us to the following initial skeleton for `sum`:

~~~racket
(define sum
  (lambda (numbers)
    (if (null? numbers)
        ; The sum of an empty list
        ; The sum of a non-empty list
    )))
~~~

The sum of the empty list is easy---since there's nothing to add, so the total is 0.
However, what about the non-empty list case?
Well, we know that since the list is non-empty that `car` and `cdr` work on the list.
Let's revisit the concrete list from before: a list containing `1` at the head with an unknown set of elements as its tail:

![A list with the head element as 1 and the rest of the list unknown.]({{ "/images/list-of-5-example-head.png" | relative_url }})

If this list is `numbers` then `(car numbers)` produces `1` and `(cdr numbers)` produces the tail of the list (filled in to represent the fact that we don't immediately know its contents).

How can we decompose the sum of `numbers` in terms of these components?
If we had a way to sum up the tail of the list, we could simply add the head of the list to the result.
In code, this is expressed as:

```racket
(+ (car numbers) {??})
```

Where `{??}` is the hole we need to fill in with "sum the tail."
The tail is expressed with `(cdr numbers)`; we just need a function to that sums up the elements of a list for us.
Luckily, *that is exactly the function we are defining right now*:

~~~racket
(+ (car numbers) (sum (cdr numbers)))
~~~

Here, the `sum` function is being called in its own definition.
This is called a *recursive function call*.
If we believe that such a function call works, then we see that our decomposition is valid:

> The sum of the elements of a list is the head of list added to the sum of the tail.

Here is the complete recursive definition of `sum`.
Observe how the definition of `sum` mirrors our decomposition:

> Numbers is either an empty list or a non-empty list.
> +   The sum of an empty list is `0`.
> +   The sum of a non-empty list is the head of the list added to the sum of the tail.

<pre class="scamper source">
(define sum
  (lambda (numbers)
    (if (null? numbers)
        0
        (+ (car numbers) (sum (cdr numbers))))))

(sum (list 91 85 96 82 89))
(sum (list -17 17 12 -4))
(sum (list 9.3))
(sum null)
</pre>

### Recursion and our mental model of computation

At first, this may look strange or magical, like a circular definition: if Scheme has to know the meaning of `sum` before it can process the definition of `sum`, how does it ever get started?
Our mental model can show us how this function computes!

Let's consider a simple example: `(sum (list 5 8 2))`.
(We'll skip a few intermediate steps along the way to highlight the relevant parts of the derivation.)

1.  The argument to `sum` is a value, so we go ahead and substitute for the body of the function:

    ```racket
        (sum (list 5 8 2))
    --> (if (null? (list 5 8 2))
            0
            (+ (car (list 5 8 2)) (sum (cdr (list 5 8 2)))))
    ```

2.  The list `(list 5 8 2)` is non-empty, so `null` evaluates to `#f`.
    This means the conditional evaluates to its else-branch:

    ~~~racket
        (if (null? (list 5 8 2))
            0
            (+ (car (list 5 8 2)) (sum (cdr (list 5 8 2)))))
    --> (if #f
            0
            (+ (car (list 5 8 2)) (sum (cdr (list 5 8 2)))))
    --> (+ (car (list 5 8 2)) (sum (cdr (list 5 8 2)))))
    ~~~

3.  `(car (list 5 8 2))` evaluates to `5` and `(cdr (list 5 8 2))` evaluates to `(list 8 2)`.
    This leads to the following simplified expression:

    ```racket
        (+ (car (list 5 8 2)) (sum (cdr (list 5 8 2)))))
    --> (+ 5 (sum (cdr (list 5 8 2)))))
    --> (+ 5 (sum (list 8 2)))
    ```

4.  Now, we substitute for the body of `sum` again but this time passing the argument `(list 8 2)`:

    ```racket
        (+ 5 (sum (list 8 2)))
    --> (+ 5 (if (null? (list 8 2))
                 0
                 (+ (car (list 8 2)) (sum (cdr (list 8 2))))))
    ```

5.  Note that the `(+ 5 ...)` from the original call to `sum` is waiting to be evaluated, but we must first deal with this new conditional!
    Also note that we're in a similar situation as step 2 except that the list in question is `(list 8 2)` instead of `(list 5 8 2)`.
    To proceed, we note that `(list 8 2)` is non-null, so we evaluate to the else branch.
    Evaluating `(car (list 8 2))` yields `8` and `(cdr (list 8 2))` yields `(list 2)`, the list containing just `2`.
    This gives us the following derivation:

    ```racket
        (+ 5 (if (null? (list 8 2))
                 0
                 (+ (car (list 8 2)) (sum (cdr (list 8 2))))))
    --> (+ 5 (if #f
                  0
                  (+ (car (list 8 2)) (sum (cdr (list 8 2))))))
    --> (+ 5 (+ car (list 8 2)) (sum (cdr (list 8 2))))
    --> (+ 5 (+ 8 (sum (cdr (list 8 2)))))
    --> (+ 5 (+ 8 (sum (list 2))))
    ```

6.  At this point, you can see a pattern---we'll peel off each element from the list going from left-to-right.
    That element becomes part of the overall sum.
    As an check, you will work through the derivation from the expression above to this state:

    ```racket
        (+ 5 (+ 8 (sum (list 2))))
    --> ...
    --> (+ 5 (+ 8 (+ 2 (sum null))))
    ```

    But what happens now when `sum` is passed the empty list?
    Let's substitute one more time and find out:

    ```racket
        (+ 5 (+ 8 (sum '())))
    --> ...
    --> (+ 5 (+ 8 (+ 2 (if (null? null))
                           0
                           (+ (car null) (sum (cdr null))))))
    ```

7.  Finally, the input list is the empty list, so our conditional goes into the if-branch:

    ```racket
        (+ 5 (+ 8 (+ 2 (if (null? null)
                           0
                           (+ (car null) (sum (cdr null)))))))
        (+ 5 (+ 8 (+ 2 (if #t
                           0
                           (+ (car null) (sum (cdr null)))))))
    --> (+ 5 (+ 8 (+ 2 0)))
    ```

    You may have been worried that `(car null)` and `(cdr null)` are invalid expressions.
    However, recall that `if` does not behave like a function call.
    We only evaluate the branch containing the offending code when the guard of the conditional is `#f`!
    In this case, the guard evaluated to `#t`, and so we never got to the invalid expressions.

8.  We see that the final call to `sum` yields 0.
    From here, we finally compute the sum, giving us the final result:

    ```racket
        (+ 5 (+ 8 (+ 2 0)))
    --> (+ 5 (+ 8 2))
    --> (+ 5 10)
    --> 15
    ```

## Self checks

### Check 1: Complete the missing part (‡)

Fill in the missing steps of the derivation from step 6 above:

```racket
    (+ 5 (+ 8 (sum (list 2))))
--> ...
--> (+ 5 (+ 8 (+ 2 (sum '()))))
```

### Check 2: To infinity and beyond (‡)

Consider the following erroneous definition of `sum`:

<pre class="scamper source-only">
(define awesum
  (lambda (lst)
    (if (null? lst)
        0
        (+ (car lst) (awesum lst)))))
</pre>

The only difference between `awesum` and `sum` is that we passed `lst` rather than `(cdr lst)` to the recursive call.

What happens if we call `(awesum (list 5 2))`?
Use your mental model to predict the result, and then check your result in Scamper.
Explain your findings in a few sentences.

**(Warning: make sure you save your work before checking!)**