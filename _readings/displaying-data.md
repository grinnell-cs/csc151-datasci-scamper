---
title: Displaying data
summary: |
  The final phase of one round of data analysis is the creation
  of summaries or visualizations of the data.  In our preliminary experiences
  with data, we have focused on numeric or textual summaries.  In this
  reading and the corresponding lab, we turn our attention to ways to
  visualize data in DrRacket.
---

## Introduction: The potential power of visualization

While a select portion of the population is able to find trends and
ideas in numeric data and charts, many find that visual representations
of the data present allow them to more easily see possible trends,
clusters, and other characteristics of the data.  This experience is
particularly common when the data sets are too large to think about
individual lines of data.

As we explore the power of data science, we have some responsibility
to consider how to visualize data.  While there are a wide array of
visualization tools possible, both generally and in DrRacket, we will
focus on a few core types of visualization.  In particular, we will consider
histograms (aka "bar charts"), scatterplots, and line graphs.  Those
interested in exploring more capabilities can read [the DrRacket reference
manual](https://docs.racket-lang.org/plot/).

## Showing data in DrRacket

DrRacket provides a package called `plot` that supports a wide variety
of visualizations.  All of them can be created by a variant of a call
to the `plot` procedure.

The first parameter to that procedure is a description of the data to
be plotted and the way in which to plot those data.  For example, we
describe a scatterplot using `points`, a line plot using `line`, and
histograms with `discrete-histogram` or `stacked-histogram`.

Let's start with a simple call to `plot` to create a plot of a few points.
(In general, we will generate data from our program; this just gets you
started thinking about how things are shown.)

```
> (plot (points (list (list 0 0) (list 10 10) (list 3 5) (list 1 4)
                      (list 8 2))))
```

![A scatterplot of five points.  The x axis of the scatterplot runs from 0 to ten.  The y axis of the scatterplot also runs from 0 to ten.  The x axis is labeled "x axis" and the y axis is also labeled "y axis".  Circles are clearly visible at the points (1,4), (3,5), and (8,2).  Circles at (0,0) and (10,10) are much less visible.](../images/points00)

As the image suggests, this expression gives us a fairly simple diagram
with some potential flaws, such as the difficulty of seeing some of the
points or the default labels, which tell us very little about the data.
We will consider how to override these values in the subsequent sections.

## Getting started: Plotting points

As you've seen, if we have a collection of points stored as a list of
lists of x,y pairs, we can plot that collection with

```
(plot (points list-of-points))
```

Doing so creates a simple scatterplot with the labels "x axis" and "y axis",
the x axis running from the smallest x value to the largest x value, and
the y axis running from the smallest y value to the largest y value.  

There are at least five things we would likely want to customize about this
plot: We should add a title.  We should give a name to the x axis (typically,
the independent variable).  We should give a name to the y axis (typically,
the dependent variable).  We should expand the x axis so that it's easier
to see the smallest and largest x value.  We should expand the y axis so that
it's easier to see the smallest and largest y values.

We can do all of these things with so-called *optional* parameters.  In
DrRacket, an optional parameter has the form `#:NAME VAL`.  That is, a
point sign, a colon, the name of the optional parameter, a space (or as
much whitespace as we want) and a corresponding value.  For example, to
add a title to our plot, we add an optional parameter of the form 
`#:title`.

```
> (plot (points (list (list 0 0) (list 10 10) (list 3 5) (list 1 4)
                      (list 8 2)))
        #:title "This and That")
```

![The same scatterplot of five points, with the text "This and That" at
the top.](../images/points01)

We label the x axis and the y axis similarly, using `#:x-label` and
`#:y-label`

```
> (plot (points (list (list 0 0) (list 10 10) (list 3 5) (list 1 4)
                      (list 8 2)))
        #:title "This and That"
        #:x-label "This"
        #:y-label "That")
```

![The same scatterplot of five points, with the text "This" as a label of
the x axis and the text "That" as a label of the y axis.](../images/points02)

While those labels are associated with the plot as a whole, changes to the
ranges of the axes fall within the `points` command.  The optional arguments
are `#:x-min`, `#:x-max`, `#:y-min`, and `#:y-max`.  Let's expand the range
a bit to see the two extreme points.

```
> (plot (points (list (list 0 0) (list 10 10) (list 3 5) (list 1 4)
                      (list 8 2))
                #:x-min -1
                #:x-max 11
                #:y-min -1
                #:y-max 11)
        #:title "This and That"
        #:x-label "This"
        #:y-label "That")
```

![A scatterplot of five points.  The x axis of the scatterplot runs from negative 1 to eleven.  The y axis of the scatterplot also runs from negative 1 to eleven.  The x axis is labeled "This" and the y axis is labeled "That".  A title at the top reads "This and that".  Circles are clearly visible at the points (1,4), (3,5), (8,2), (0,0), and (10,10).](../images/points03)

We can choose a wide variety of symbols using the `#:sym` optional parameter
and can set the color of those symbols with `#:color` or `#:fill-color`.
You can find the list of symbols in [the Racket documentation](https://docs.racket-lang.org/plot/contracts.html#%28def._%28%28lib._plot%2Futils..rkt%29._known-point-symbols%29%29).  Here's one example.

```
> (plot (points (list (list 0 0) (list 10 10) (list 3 5) (list 1 4)
                      (list 8 2))
                #:fill-color "red"
                #:sym 'fullcircle6
                #:x-min -1
                #:x-max 11
                #:y-min -1
                #:y-max 11)
        #:title "This and That"
        #:x-label "This"
        #:y-label "That")
```

![The same scatterplot of five points.  This time, the points are represented by larger red circles.  Everything else is the same.](../images/points04)

What if we want to plot more than one set of points, perhaps in different
colors or with different shapes?  We can make a list of calls to points.

```
> (plot (list (points (list (list 0 0) (list 10 10) (list 3 5) (list 1 4)
                            (list 8 2))
                      #:fill-color "red"
                      #:sym 'fullcircle6
                      #:x-min -1
                      #:x-max 11
                      #:y-min -1
                      #:y-max 11)
              (points (list (list 5 10) (list 6 9) (list 8 7))
                      #:fill-color "black"
                      #:sym 'fullcircle6))
        #:title "This and That"
        #:x-label "This"
        #:y-label "That")
```

![The same plot, with the addition of three black circles at (5,10),
(6,9), and (8,7).](../images/points05)

## Line plots

The DrRacket `plot` package also supports line plots.  They act much like
pint plots except that you use `lines` rather than `points` and you don't
specify the symbols or colors.

```
> (plot (lines (list (list 0 0) (list 10 10) (list 3 5) (list 1 4)
                     (list 8 2))))
```

![A strange line plot.  The x axis of the lot runs from zero to ten.  The y axis of the scatterplot also runs from zero to ten.  The x axis is labeled "x axis" and the y axis is also labeled "y axis".  There is a line from (0,0) to (10,10),
from (10,10) to (3,5), from (3,5) to (1,4), and from (1,4) to (8,2).](../images/lines00)

We can also combine line plots and scatterplots.

```
> (define elements
    (list (list 0 0) (list 10 10) (list 3 5) (list 1 4) (list 8 2)))
> (plot (list (lines elements)
              (points elements #:sym 'fullcircle6)))
```

![The same line plot with large black circles at each of the five points.
The points at (0,0) and (10,10) are a bit harder to see.](../images/lines01).

## Histograms

DrRacket's `plot` package also supports two kinds of histograms:
discrete histograms, in which we have only one value associated with
each category, and stacked histograms, in which we might have multiple
values associated with each.  Here's a simple example.

```
> (plot (discrete-histogram (list (list "A" 5) (list "B" 8) (list "C" 3))))
```

![A histogram with three rectangles.  The x axis of the diagram has labels
of "A", "B", and "C" underneath the three rectangles.  The y axis runs from
zero to eight, with labeled ticks at 0, 2, 4, 6, and 8.  The bar over "A" is five units high.  The bar over "B" is eight units high.  The bar over "C" is three units high.](../images/histogram00)

Here's one using `stacked-histogram` and some optional parameters.  

```
> (plot (stacked-histogram (list (list "A" (list 6 12))
                                 (list "B" (list 5 10 7))
                                 (list "C" (list 15 5)))
                           #:labels (list "This" "That" "Other")
                           #:colors (list "black" "red" "gray")))
```

![A histogram with three columns.  The x axis of the diagram has labels
of "A", "B", and "C" underneath the three columns.  The y axis runs
from zero to a bit above twenty.  At the top-left corner is a legend
that has the word "This" next to a black rectangle, the word "That"
next to a red rectangle, and the word "Other" next to a gray rectangle.
The column over "A" has a black rectangle that runs from height 0 to
height 6 and a red rectangle that runs from height 6 to height 18.
The column over "B" has a black rectangle that runs from 0 to 5, a red
rectangle that runs from 5 to 15, and a grey rectangle that runs from
15 to 22.  The column over "C" contains a red rectangle that runs from
0 to 15 and red rectangle that runs from 15 to 20.](../images/histogram01).

## Other options

The `plot` package contains a wide variety of other plotting options and
opportunities, from additional parameters to each of the approaches we've
looked at already to other options for plotting data, including 3D plots
and vector fields.  We will leave you to explore those on your own.

## Applying these tools

As you might expect, we will apply each of these approaches to data from
our "standard" data sets, such as zip codes or public domain novels.
Our first goal will be to determine which visualization might be most
appropriate for each form of data.  Our second goal will be to turn the
data into a form that they can be used by these procedures.  Our third
will be to use `plot` to visualize the data.

## Self checks

### Check 1: Colors, labels, and more

a. Verify that the stacked histogram works as advertised.

```
> (plot (stacked-histogram (list (list "A" (list 6 12))
                                 (list "B" (list 5 10 7))
                                 (list "C" (list 15 5)))
                           #:labels (list "This" "That" "Other")
                           #:colors (list "black" "red" "gray")))
```

b. Try different values for the cell values, the labels, and the colors
to familiarize yourself with options.  

### Check 2: Ordering values

a. Does the order in which we present the points matter in a scatterplot?
Why or why not?

b. Does the order in which we present the points matter in a line plot?
Why or why not?
