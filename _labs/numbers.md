---
title: Numbers
summary: |
  We explore the numeric types that Racket supports.
link: false
---

## Useful functions and notation

In the reading, we introduced a score of new functions for processing the basic types of Racket.
Think of them as an *essential vocabulary* for expressing basic computation in Racket, similar to the new vocabulary you might encounter when learning a foreign language.
However, unlike a foreign language, there isn't an expectation that you get a deck of flash cards and memorize these function names.
Instead, the expectation is that you will eventually memorize these functions by *consistently building programs* that use these functions, *i.e.*, practice.

To this end, we'll try to provide concise references to the functions that we introduce in the reading to aid you in your task.
Feel free to note the location of these sections and use them to quickly look up the appropriate functions when needed.
(Also feel free to write them down on flash cards for easy reference.)

### Numbers

Basic numeric operations: `+`, `-`, `*`, `/`, `quotient`, `remainder`,
`expt`.

Numeric conversion: `exact->inexact`, `inexact->exact`, `floor`,
`ceiling`, `round`, `truncate`.

Numeric type predicates: `exact?`, `inexact?`, `integer?`, `real?`,
`rational?`, `complex?`

### Lists

Constant notation: `'(val val val)`

List operations: `take`, `drop`, `list-ref`, `length`

## The lab

{% if site.online %}
Your team should decide who will take the A-side and B-sides of the lab.
Each member should download the appropriate code:

+ [numbers-a.rkt]({{ "/code/labs/numbers-a.rkt" | relative_url }})
+ [numbers-b.rkt]({{ "/code/labs/numbers-b.rkt" | relative_url }})

**After you've downloaded the code, follow the instructions in your respective files!**

When you are done, combine the files, rename the result to `numbers.rkt`, and upload the completed lab to Gradescope.
{% else %}
The person closer to the screen is the A-side.  The person further from the screen is the B-side.

Download the appropriate code.

+ [numbers.rkt]({{ "/code/labs/numbers.rkt" | relative_url }})

**After you've downloaded the code, follow the instructions in the file.**

When you are done, upload your `numbers.rkt` file to Gradescope.
{% endif %}

## Notes

### Notes on From reals to integers {#anchor-real2int-notes}

Here are the ways we tend to think of the four functions:

`(floor r)`{:.signature} finds the largest integer less than or equal to `r`{:.signature}. Some would phrase this as "`floor` rounds down".

`(ceiling r)`{:.signature} finds the smallest integer greater than or equal to `r`{:.signature}. Some would phrase this as "`ceiling` rounds up".

`(truncate r)`{:.signature} removes the fractional portion of `r`{:.signature}, the portion after the decimal point.

`(round r)`{:.signature} rounds `r`{:.signature} to the nearest integer. It rounds up if the decimal portion is greater than 0.5 and it rounds down if the decimal portion is less than 0.5. If the decimal portion equals 0.5, it rounds toward the even number.

```
> (round 1.5)
2
> (round 2.5)
2
> (round 7.5)
8
> (round 8.5)
8
> (round -1.5)
-2
> (round -2.5)
-2
```

It's pretty clear that `floor` and `ceiling` differ: If `r`{:.signature} has a fractional component, then `(floor r)`{:.signature} is one less than `(ceiling r)`{:.signature}.

It's also pretty clear that `round` differs from all of them, since it can round in two different directions.

We can also tell that `truncate` is different from `ceiling`, at least for positive numbers, because `ceiling` always rounds up, and removing the fractional portion of a positive number causes us to round down.

So, how do `truncate` and `floor` differ? As the previous paragraph implies, *they differ for negative numbers*. When you remove the fractional component of a negative number, you effectively round up. (After all, -2 is bigger than -2.2.) However, `floor` always rounds down.

Why does Scheme include so many ways to convert reals to integers? Because experience suggests that if you leave any of them out, some programmer will need that precise conversion.

[Return to the problem](#anchor-real2int)

### Notes on Exploring rational numbers {#anchor-rationals-notes}

The underlying Scheme implementation seems to represent the fractional part of many numbers as the ratio of some number and 4503599627370496, which happens to be 2<sup>52</sup>. (Most computers like powers of 2.) By using a large denominator, it helps ensure that representations are as accurate as possible.

If you are energetic, you might scour the Web to find out why they use an exponent of 52.

[Return to the problem](#anchor-rationals).

## Acknowledgements

This laboratory is based on [a similar laboratory from a prior version of CSC
151](https://www.cs.grinnell.edu/~rebelsky/Courses/CSC151/2018S/labs/basic-types).
At some point, it included problems on lists and files.  It no longer does.

In Spring 2024, we split the numeric problems and the string problems into separate labs.
