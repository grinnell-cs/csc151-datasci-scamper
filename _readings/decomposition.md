---
title: Decomposition
summary: |
  We discuss one of the fundamental problem solving techniques in computing: algorithmic decomposition
preimg: true
mathjax: true
---

As we learned in [a previous reading]({{ "/readings/algorithm-building-blocks.html" | relative_url }}), an algorithm is a step-by-step procedure for solving a problem.
These problems vary in scope from simple one-off tasks to complicated, generalized tasks that form the core of large, complex systems.
For example, consider the problem of going through a web page and finding the links it contains.
It turns out that a web page is plain text in a format known as *hypertext markup language* (HTML), so we can search the web page source file for occurrences of the text `<a href="...">...</a>` which correspond to links.
For example, the beginning of this paragraph is rendered with the following HTML:

~~~html
<p>As we learned in <a href="/csc151/readings/algorithm-building-blocks.html">a previous reading</a>, an algorithm is a step-by-step procedure for solving a problem.
These problems vary in scope from simple one-off tasks to complicated, generalized tasks that form the core of large, complex systems.
For example, consider the problem of going through a web page and finding the links it contains.
It turns out that a web page is plain text in a format known as hypertext markup language (HTML), so we can search the web page source for for occurrences of the text <code class="language-drracket highlighter-rouge"><span class="nv">&lt;a</span> <span class="nv">href=</span><span class="s">"..."</span><span class="nv">&gt;&lt;/a&gt;</span></code> which correspond to links.
For example, the beginning of this paragraph is rendered with the following HTML:</p>
~~~

The paragraph contains one link corresponding to the text `yesterday's reading`.
We will eventually learn how to do operations like this in Scheme, but even though we can't write a program to do this yet, we can imagine that with proper library support that this is a simple task.

In contrast, the task of scraping web pages for links forms the basis of the algorithms that search engines use to rank webpages.
For example, Google's famous [PageRank](https://en.wikipedia.org/wiki/PageRank) algorithm ranks the relevance of a webpage by the number of webpages that link to it.
In order to do this, Google's servers comb the Internet for webpages and scrapes their links, recording where they point to in a database.

PageRank itself is a complicated algorithm with many parts.
However, what we should take away from this example is the fact that this complicated algorithm boils down to a simple task: scraping webpages for links.
The process by which we take a complicated problem like ranking all webpages and distill it into a collection of smaller, easier-to-solve problems is called *algorithmic decomposition*.

Algorithmic decomposition is the *lifeblood* of a computer scientist.
It is the primary skill that we employ to manage complexity in the problems that we solve.
As such, we introduce this concept in this first week of the course to start getting you thinking with this mindset:

> The problem that I am trying to solve can be decomposed into these smaller problems...


Algorithmic decomposition is our primary problem solving strategy for systematically tackling complex problems.
Rather than blundering into a solution, we proceed by:

1.  Breaking up the original, complex problem into smaller, easier *sub-problems to* solve.
2.  Solving each of those sub-problems in turn if they are easy enough to tackle directly, or
    further decomposing the sub-problems if they themselves are too complex!
3.  Taking the solutions to each of those sub-problems and *composing them together* to form a solution to the original problem.

For example, we might decompose the problem of computing a student's average assignment grade for a course as follows:

+   Compute the sum of the student's assignment grades (assuming they are all out of the same point total).
+   Count the number of total assignments.
+   Combine the two quantities via division to arrive at the final average.

We perform this process naturally in many situations, almost without thinking about it.
However, when put into a novel situation, *e.g.*, computer programming, you might neglect to go through these steps.
It is therefore instructive to be explicit about your decomposition---luckily, this coincides with *excellent programming practices*, so your diligence is well-rewarded in this context.

We can approach decomposition in either a *bottom-up* or *top-down* style of design.
In a bottom-up style, we first implement the individual of pieces of the program and then we combine them to form the complete program.
In a top-down style of design, we first *partially* implement the complete program and then implement the individual pieces.

We'll illustrate both styles of design below on the problem of computing an average student grade.

## Bottom-up Design

Let's start with computing the sum of student's assignment grades, say they are `50, 39, 45, 42`. 


<pre class="scamper source">
(define gradesum
  (+ 50 39 45 42))
</pre>

The practical effect of the `define` command is to make `sum` an *alias* for the sum of the values, so we can simply type in `sum` as an additional statement to check our work:

<pre class="scamper source">
(define gradesum
  (+ 50 39 45 42))

gradesum
</pre>

Next, we'll define `num` to be the total number of assignments. In this case it's easy to see that there are 4. However, in the case of longer lists of items (or ones which are changing length!) we would like to use a less error prone method than using our eyeballs.

<pre class="scamper source">
(define num
  (length (list 50 39 45 42)))
  
</pre>

And we can again check our work.

<pre class="scamper source">
(define	num
  (length (list 50 39 45 42)))

num
</pre>

Finally, let's put it all together.
The overall average is obtained by dividing the sum of grades by the number of graded items. 

<pre class="scamper source">
(define gradesum
  (+ 50 39 45 42))

(define	num
  (length (list 50 39 45 42)))

(define averagegrade
  (/ gradesum num))

averagegrade
</pre>

## Top-Down Design

With top-down design, rather than starting with `gradesum` and `num`, we start with the overall program `averagegrade`.

We have identified that `averagegrade` is the division of two numbers, so we know that the definition of `averagegrade` will involve `/`.
However, we have not defined `gradesum` and `num` yet---what do we fill in for the arguments to `above`?

<pre class="scamper source">
(define averagegrade
  (/ {??} {??}))
</pre>

Scamper defines a special value `{??}` which represents an undefined value in the program.
`{??}` acts as a syntactically valid *placeholder*, reminding us that we should replace `{??}` with an eventual implementation. Of course, when we run this code, we the `Hole encountered! Fill me in!` error,but we at least know that we have all the keywords and parentheses in the right place.

Let's do that for `gradesum` first.

<pre class="scamper source">
(define gradesum
  {??})
</pre>

Note that we can use our hole value as a placeholder to be able to write out the syntax of a define correctly and ensure that we get it right.

<pre class="scamper source">
(define gradesum
  {??})

(define averagegrade
  (/ gradesum {??}))
</pre>


Once we define `gradesum` as before, we can see the program coming together:

<pre class="scamper source">
(define gradesum
  (+ 50 39 45 42))

(define averagegrade
  (/ gradesum {??}))
</pre>


Finally, we can define `num` just like before and then complete the definition of `averagegrade`:

<pre class="scamper source">
(define num
  (length (list 50 39 45 42)))

(define gradesum
  (+ 50 39 45 42))

(define averagegrade
  (/ gradesum num))

averagegrade
</pre>

## Top-down vs. Bottom-up Design

You might wonder which sort of design---top-down or bottom-up---to use when writing your programs.
The short answer is that *it depends* on the kind of problem you are tackling and your own personal preference.
Sometimes you might see how to immediately implement the smaller pieces of a program in which you can start with those pieces and then build up to the overall program.
In other cases, you might not see the pieces and want to essentially outline how the program ought to behave in code.
In this case, you can use top-down design to write this outline and then fill it in incrementally.
Either strategy is valid---be willing to experiment early on with both styles to discover your preferences and be flexible in how you design your code!

## Decomposition In Code

Finally, let's look at the big picture.
Take a look at the complete program that we wrote in the definitions pane:

<pre class="scamper source">
(define num
  (length (list 50 39 45 42)))

(define gradesum
  (+ 50 39 45 42))

(define averagegrade
  (/ gradesum num))
</pre>

Note how our decomposition strategy has been *enshrined in the code*.
That is, our approach to solving the problem is evident in the code:

> `averagegrade` is defined to be the division of `gradesum` and `num`.

By employing algorithmic decomposition in our problem solving and programming, we not only gain the able to make tangible progress in solving the problem; our code is much more readable as a result!
As we move forward in the course, *always* approach problems with decomposition in mind even if they are easy to solve at first.
Honing this skill early on in your programming journey will prepare you well for the complex problems will encounter later in the semester!

## Self Checks

### Check 1: Readability (‡)

Here is an alternative version of the code to produce the image of this reading.

~~~racket
(define averagegrade
  (/ (+ 50 39 45 42) (length (list 50 39 45 42))))
~~~

Paste this code into a fresh `.scm` source file and verify that `averagegrade` produces the same result as before.

Compare and contrast the final version of the code the reading with this version.
Answer each of the following questions in a few sentences each.

+   Which version is more concise?
    Why?
+   Which version do you find more understandable?
    Why?
+   Which version allows you to better predict the results *without* running the program?
    Why?

