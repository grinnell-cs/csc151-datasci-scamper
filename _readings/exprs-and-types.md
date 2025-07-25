---
title: Expressions and types
summary: |
  We have learned that a Scheme program consists of a collection of expressions, program fragments that evaluate to values.
  In this reading, we focus on the different kinds of *primitive values* that we can manipulate in our Scheme programs.
preimg: true
---

From our exploration so far. we know that Scheme programs are composed primarily of *expressions*, program fragments that evaluate to values.
What are the different kinds of values that expressions can evaluate to?
In other words, what kinds of *data* can our Scheme programs manipulate?
We've seen some examples already, *e.g.*,

+   Numbers:

    <pre class="scamper source">
    (* 3 (- 1 5) (+ 2 4))
    <pre>

+   Strings:

    <pre class="scamper source">
    (string-append "hello" "world!")
    </pre>

But are there others?
What are the different categories of data we might operate over and how are they organized?

## Primitive vs. compound data

In computer programming, we can categorize the wide-range of data into two sorts:

+   **Compound data**: data that is made up of other, smaller pieces of data.
+   **Primitive data**: "indivisible" data, *i.e.*, data that cannot be broken up into smaller pieces.

For example, consider representing a student in a computer program.
A student has many *potential* pieces of data associated with them, *e.g.*,

+   Name,
+   Email,
+   Student ID,
+   Age,
+   Hometown,
+   Current GPA, and
+   Current classes for the fall.

In this sense, students are examples of compound data.
An individual student, from the perspective of a computer program, is made up of these parts.

In contrast, consider just the student's age.
The student's age compromises of a single number, usually just a *natural number*, zero or a positive integer (non-fractional) quantity.
At the level of abstraction we're working at, we think of numbers as indivisible units---unlike a student, a number isn't made up of small data.
In this sense, numbers are examples of primitive data.
Another term for primitive data are *atomic* data because they cannot be broken up any further.

## Types

We intuitively recognize that these values:

<pre class="scamper-output">
3
0
-1
47
</pre>

Are different from these values:

<pre class="scamper-output">
"hello!"
"csc151"
"world"
"47"
</pre>

The primitive versus compound distinction allows us to categorize groups of data based on their "atomicity."
However, within these buckets are different categories of data.
We call such a category a *type*.
For example, the first set of values are all *numbers* whereas the second set of values are all *strings*.
We say that each of the values are *instances* of these types, *e.g.*, `3` is an *instance of* the *number* type or `3` *has type* number.

**Types of expressions**

We assign types to particular values, *e.g.*, `5` has type "number" (or, more
precisely, "exact integer").
Recall that a value is an expression that takes no further steps of evaluation.
We can define the type of any expression, not just values, as follows:

> The type of an expression is the type of the value that the expression evaluate to.

**Types of functions**

For example `(+ 1 1)` is a non-value expression that has type number.
We know this because `(+ 1 1) --> 2` and `2` is a number.

When we perform operations over data, *e.g.*, addition through the `+` function, we must provide values of the appropriate type.
Here, `+` expects to be given at least one argument, all of which must be numbers:

<pre class="scamper source">
(+ 1 3 5 7 9)
</pre>

When a function is provided values of an appropriate type, a *type error* occurs when trying to run that function on those values.
For example:

<pre class="scamper source">
(+ 1 "hello")
</pre>

Scheme realizes these type errors as *contract violations* when trying to execute the function.
Intuitively, we can think of `+` as specifying the following contract:

> If you provide me with values that are *all* numbers, I will give you back a number that is the sum of those input numbers.

From this contract, we say that the *type of the function* is the expected type of its inputs and output.
For `+` the expected types of the inputs as numbers and the expected type of the output is a number.
Type mismatches of this sort are a common error in programming, especially whenyou start out.
Whenever you write code, try to keep in mind:

> What is the *intended* type of the expression that I am trying to write?

This mentality will bring you one step closer towards truly writing code in an intentional, purposeful fashion and not simply throwing random stuff at the wall and seeing if it works!

For function types, the types of the inputs and outputs don't have to be the same, *e.g.*,

+   `(string-length "hello world")` evaluates to `11`.
    The type of the input to `string-length` is a string and the output is a number (exact integer).
+   `(substring "hello world" 2 5)` evaluates to `"llo"`---`substring` returns the portion of the string starting with the character at the index (inclusive) denoted by the first argument and ends with the character at the index (exclusive) denoted by the last argument. 
    `substring` takes a string and two numbers as input and produces a string as output.
    (*Note*: the indices of a string start at 0, so `l` is indeed the character at index 2!)


## Primitive data in Scheme

The remainder of today's readings are broken up into readings for two of the major primitive types we see in Scheme:

+ [Numbers]({{ "/readings/numbers.html" | relative_url }})
+ [Characters and Strings]({{ "/readings/strings.html" | relative_url }})

For each of these primitives, we introduce the following concepts:

1.  What does a datum of this type represent?
2.  How do we make values of this type?
3.  What library functions are available for manipulating values of these types?

You do not have to memorize all of this information in one go as it is a lot of stuff!
Instead, you should look initially to get the *big picture*: what broad sorts of operations are possible with each type of data and what can I expect to do?
From there, you can always refer back to these readings and Scamper reference found in VSCode to find particular functions to achieve the effect you are looking for.

## Self-checks

The readings on primitive data have a number of self-checks.
Please complete the following self-checks for your reading question set for this collection:

+ (‡) [Numbers]({{ "/readings/numbers.html" | relative_url }}): Check 1 (Exploring exponentiation)
+ (‡) [Collating Sequences]({{ "/readings/strings.html" | relative_url }}): Check 2 (Collating sequences)