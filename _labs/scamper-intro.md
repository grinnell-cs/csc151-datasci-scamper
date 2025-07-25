---
title: An introduction to Scamper
summary: |
  In this laboratory, you will begin to type Scamper expressions.
  Scamper is the language in which we will express many of our algorithms this semester.
  Scamper is a particular implementation of Scheme (which varies a bit from the Scheme standard).
link: true
---

## Introduction

Many of the fundamental ideas of computer science are best learned by reading, writing, and executing small computer programs that illustrate those ideas.
One of our most important tools for this course, therefore, is a *program-development environment*, a computer program designed specifically to make it easier to read, write, and execute other computer programs.
The [Scamper](https://github.com/slag-plt/scamper) language that we use in the course is _also_ an in-browser integrated development environment (IDE for short).
Scamper is a dialect of a language called [Scheme](https://en.wikipedia.org/wiki/Scheme_(programming_language)), which is itself a dialect of a language called [Lisp](https://en.wikipedia.org/wiki/Lisp_(programming_language)).
Although Scamper is a dialect of Scheme, we will often refer to our language of choice as either "Scamper" or "Scheme."
(And you may hear us also mistakenly refer to the language as "Racket" which is a more full-featured dialect of Scheme that was used in previous version of the course!)

In this lab, we explore the Scamper language and its associated program development environment.

## Preparation

Scamper is available online and works on any machine with access to a modern web browser (_i.e._, Chrome, Firefox, Safari, or Edge):

+ <https://scamper.cs.grinnell.edu>

Unlike many other web applications you have encountered, Scamper exists as a pure _front-end web application_.
This means that your files are saved locally in your browser rather than on a server.
The corollary to this fact is that if you move between web browsers or machines, you will need to manually shuffle your programs around!

Right now, this isn't an issue, but later in the course once we have writte a number of programs, we'll talk about backing up and transferring your work between machines.

## Exercises

For many of our in-class lab activities, you will work with a partner.
To help you manage the work between yourself and your partner, the lab instructions will specify how you should work with your partner for each exercise.

+   When working collaboratively, make sure to actively engage your partner.
    Ask questions, share thoughts, and come to a common consensus on the problem.
    We will have more to share about productive collaborative work in future labs.
    For now, keep in mind the golden rules of collaborative learning:

    > **Create an environment where your partner feels comfortable sharing, failing, and ultimately learning.**
    > **You will find that you will also learn better in this environment, even if you think you know the answers already!**

The technique we use in this class is a variant of "pair programming", a commonly used technique for programming and for learning computer science.
In pair programming, we designate the person at the keyboard as the "driver" and the person working with them as the "navigator".
As in most driver/navigator situations, both driver and navigator play important roles.
You should designate one of the two of you "A" and one of you as "B".  Each problem will designate whether A or B drives.

You should plan to spend about five minutes on each exercise, perhaps a little less.
If you begin to exceed this estimated time for an exercise, grab your instructor or class mentor and ask for help.

In this lab, you will work in a Scamper source file that you create and save called `intro.scm`.
When turning in your work for this lab, you only need to turn in one copy of this file to Gradescope.
However, you should make sure to include both your name and your partner's name in the Gradescope submission!

### Exercise 1: Writing Scamper code

**Driver: A**

In Scamper, programs exist as text written in a source file, _i.e._, a program.
The Scamper IDE let's you create and manage source files entirely within the web browser.
As we shall see by the end of this lab, these files are separate from the files on your computer and must be downloaded to be submitted to Gradescope, sent to your partner, _etc._

+   Navigate to the Scamper IDE: <https://scamper.cs.grinnell.edu>
+   Click on "Create a new program" to create a new source file and name it `intro.scm`.
    `.scm` is the filename extension traditionally associated with Scheme program files.

This will open up the Scamper editor pointed at your new file `intro.scm`.

Next, let's write a few examples in our new source file.
Type each of the following code snippets, called _expressions_, into `intro.scm`.
After you type each expression, run your program by clicking on the run button (▶) in the toolbar.
See if you get the same values as us!

(_Note_: make sure to _type_ these snippets rather than copy-pasting them in.
It is important to get a programming language, literally speaking, _in_ you fingertips rather than just in your head!)

<pre class="scamper source">
(sqrt 144)

(+ 3 4)

(+ 3 (* 4 5))

(* (+ 3 4) 5)

(string-append "Hello" " " "World!")

(string-split "Twas brillig and the slithy toves" " ")

(length (string-split "Twas brillig and the slithy toves" " "))
</pre>

Of course, one should not just thoughtlessly type expressions and see what value they get.
Particularly as you learn Scamper, it is worthwhile to think a bit about the expressions and the values you expect.
The self-check in the reading asked you to predict some values.
Determine whether your prediction matches what Scamper computes.

```racket
(* (+ 4 2) 2)

(- 1 (/ 1 2))

(string-length "Snicker snack")

(string-split "Snicker snack" "ck")

(circle 50 "solid" "teal")
```

If you get an unexpected error message in one or more cases, that may be part of the intent of this exercise!
Feel free to go on to the next exercise, but if you are confused by any of the output that you get, ask the instructor!

### Exercise 2: Libraries

**Driver: A**

As you may have noted, you get an error when you try to make a circle.

<pre class="scamper source">
(circle 50 "solid" "teal")
</pre>

Why do you get an error?
Because the `circle` procedure is not immediately available in Scheme!
Some library functions are automatically included in every program.
The set of these functions is typically called the language's _prelude_ or _standard library_.
Instead, `circle` and other image-drawing functions are part of the `image` library.
We need to tell Scamper that we would like to *include* this module with a `import` statement.
At the top of your `intro.scm` file, add the following line:

```
(import image)
```

Click the run button and try making the circle again.
If you get an error message still make sure to ask for help!


### Exercise 3: Reflection: How do you know a result is correct?

**Driver: B**

Of course, the computer is using some algorithm to compute values for the expressions you enter.
How do you know that the algorithm is correct?
One reason that you might expect it to be correct is that Scheme is a widely-used programming language (and one that we've asked you to use).
However, there are bugs even in widely-used programs.
For example, a number of years ago, a bug was discovered that was causing a [common computer chip to compute a few specific values incorrectly](https://en.wikipedia.org/wiki/Pentium_FDIV_bug#:~:text=The%20Pentium%20FDIV%20bug%20is,in%201994%20by%20Thomas%20R.) triggering a costly recall of the silicon.
Another bug in Microsoft Excel produced the [wrong output for a few values](https://www.joelonsoftware.com/2007/09/26/explaining-the-excel-bug/).
And you may have some evidence that your faculty like to trick you.
Hence, you might be a bit suspicious.

Each time you do a computation, particularly a computation for which you have designed the algorithm, you should consider how you might verify the result.
(You need not verify every result, but you should have an idea of how you might do so.)
When writing an algorithm, you can then also use the verification process to see if your algorithm is right.

Let's start with a relatively simple example.
Suppose we ask you to ask Scamper to compute the square root of 137641.
You should be able to do so by entering an appropriate Scheme expression:

```racket
(sqrt 137641)
```

Scamper will give you an answer.
How can you test the correctness of this answer?
What if you don't trust Scamper's multiplication procedure?

Discuss this question with your partner and come up with common definition of how to test your answer in this context.
Once you have a common definition, check your answer with a member of the course staff.

(_Note_: Write a sentence or so to explain of your answer in your source file. You can write text that should be *ignored*, ie not treated as code, by putting a `;` at the front of the line. We call this a *comment*.) 

### Exercise 4: Writing Scheme source code

**Driver: B**

So far, we have written singular expressions into our source file, each of which produce a single output.
More generally, our programs contain a collection of _definitions_ that can be used in a top-down fashion.
In other words, earlier definitions can be used in later definitions.

{:type="a"}
1.  Copy the following definitions into your program:

    ```racket
    (define trial01 11.2)
    (define trial02 12.5)
    (define trialO3 8.5)
    (define trial04 10.6)
    ```

2.  Now, let's use these definitions in an expression.
    Add the following expression to your program.
    What do you think will happen?
    Try to predict the result before hitting <kbd>Enter</kbd>!

    ```racket
    (* 0.25 (+ trial01 trial02 trialO3 trial04))
    ```

3.  It is likely that you got an error message.
    Discuss with your partner why this might be the case.

4.  As you've likely hypothesized, the definition for `trial03` was mistakenly typed as `trialO3`.
    (That is, it contains the letter "`O`" rather than the numeral "`0`".)
    Correct the definition in your file, reopen the exploration panel, and try entering the expression again.

8.  Congratulations, you've successfully computed the average trial score!  (At least you should have.)
    If not, review the error and try to fix it on your own with your partner's help.
    If you get stuck, hail down an instructor or mentor!

9.  Observe that you've copied code from elsewhere!
    That means that you have a responsibility to insert a _comment_ that cites the original authors.
    A comment is a part of a program that has no effect on the execution of the program.
    We use comments in programs to _explain_ our code or _document_ different aspects of it, an important part of the software engineering process that we will discuss in more detail later in the semester.

    In Scamper comments start with a semicolon and extend to the end the line.
    Here's one possible citation.

    ```racket
    ; From the CSC 151 course materials:
    ;   _URL_.
    ```

    Insert that citation into `intro.scm`, using the appropriate URL for this webpage.

_Note:_ You may encounter different expectations about the appropriate form of citations.
Make it a habit to start by copying and pasting the URL of a document whenever you copy and paste code.
Doing so shows that you have the appropriate intent.
If you are expected to provide a full citation, you can go back later and add it.

### Exercise 5: Definitions, revisited

**Driver: A**

Let's try another definition. Define `name` as your name in quotation marks. For example,

<pre class="scamper source">
(define name "Student")
</pre>

(Replace `Student` with your own name for the proper effect.)
Enter the expression below in your file and run your program to determine what this expression does with your name.

```racket
(string-append "Hello " name)
```

Next, find the number of characters in the string with the following expression.

```
(string-length name)
```

Note how this definition acts as shorthand: where ever `name` appears in the code, the string `"Student"` is substituted instead.
We'll discuss these definitions---which define *variables*---in detail in a subsequent class!

### Exercise 6: Other notations

**Driver A**

<a name="anchor-starting-scheme-10"></a>

As you've learned, Scheme expects you to use parentheses and prefix notation when writing expressions.
What happens if you use more traditional mathematical notation? Let's explore that question.

Type each of the following expressions at the Scheme prompt and see what reaction you get.

+   `(2 + 3)`
+   `7 * 9`
+   `sqrt(49)`
+   `(+ (87) (23))`

You may wish to read the [notes on this problem](#anchor-starting-scheme-10-notes) for an explanation of the results that you get.


### Exercise 7: Exporting files

**Driver: B**

Let's make sure that you can save your work and export your program to turn in, share with your partner, etc. Clicking the "Scamper" link in the top-left corner of the Scamper IDE will send you back to your list of files. From this list, you can save your program as a file on disk by hovering over the `intro.scm` file and clicking on the download icon (the left-most icon).

By default, this file is saved to the Downloads folder of your home directory.
Use Linux's file explorer to navigate to this file and verify that it has been downloaded.
At the end of this lab, you should donwload your completed file and email it to your partner, so they have a copy of your work.


## Turning it in

Turn in the `intro.scm` file to Gradescope under the appropriate lab assignment.
When doing so, please make sure that you submit the assignment as a group assignment and *include your partner's name* in the submission!

## For those with extra time

_If you find that you have finished this laboratory before the end of class, you should continue on with the following exercises._

### Extra 1: Definitions, revisited

**Driver: B**

As you observed in the primary exercises for this laboratory, you can use the definitions pane to name values that you expect to use again (or that you simply find it more convenient to refer to with a mnemonic).
So far, the only numbers we've named are simple values.
However, you can also name the results of expressions.

{:type="a"}
1.  In `intro.scm`, write a definition that assigns the name `seconds-per-minute` to the value 60.

2.  In `intro.scm`, write a definition that assigns the name `minutes-per-hour` to the value 60.

3.  In `intro.scm`, write a definition that assigns the name `hours-per-day` to the value 24.

4.  In `intro.scm`, write a definition that assigns the name `seconds-per-day` to the product of those three values.
    Note that you should use the following expression to express that product.

    ```drracket
    (* seconds-per-minute minutes-per-hour hours-per-day)
    ```

5. Run your definitions and confirm in the exploration panel that
`seconds-per-day` is defined correctly.

## Notes on the exercises

<a name="anchor-starting-scheme-10-notes"></a>

### Notes on Exercise 6: Other notations

When entering an arithmetic expression in the "natural way," _i.e._, `(2 + 3)`, Scamper reports the following error:

<pre class="scamper source">
(2 + 3)
</pre>

When Scamper sees the left parenthesis at the beginning of the expression `(2 + 3)`, it expects the expression to be a procedure call, and it expects the procedure to be identified right after the left parenthesis. But `2` does not identify a procedure; it stands for a number. (A "procedure application" is the same thing as a procedure call.) Instead, Scamper tries to interprets the `2` as a variable, but a number cannot be a variable!

Parentheses in Scamper (and Scheme) are surprisingly important! Observe the following code snippet, `7 * 9`, similar to the snippet above but without parentheses. 

<pre class="scamper source">
7 * 9
</pre>

In the absence of parentheses, the Scamper sees `7 * 9` as
three separate and unrelated expressions -- the numeral `7`; `*`, a name
for the primitive multiplication procedure; and `9`, another numeral. It
interprets each of these as a command to evaluate an expression:
"Compute the value of the numeral `7`! Find out what the name `*`
stands for! Compute the value of the numeral `9`!" So it performs the
first of these commands and displays `7`; then it carries out the second
command, reporting that `*` is a function;
and finally it carries out the third command and displays the result,
`9`. This behavior is confusing, but it's strictly logical if you look
at it from the computer's point of view (remembering, of course, that
the computer has absolutely no common sense).

For example, consider how you might call the `sqrt` function in other languages, `sqrt(49)`:

<pre class="scamper source">
sqrt(49)
</pre>

As in the preceding case, Scamper sees `sqrt(49)` as two separate
commands: `sqrt` means "Find out what `sqrt` is!" and `(49)` means
"Call the procedure `49`, with no arguments!" Scamper responds to
the first command by reporting that `sqrt` is the primitive procedure for
computing square roots and to the second by pointing out that the number
`49` is not a procedure.

[Return to the problem](#anchor-starting-scheme-10)
