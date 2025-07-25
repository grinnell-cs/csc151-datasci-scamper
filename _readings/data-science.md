---
title: A computer scientist's perspective on data science
summary: |
  The subject of this course is "data science".  But what *is*
  data science, anyway?  We consider some perspectives, particularly the
  algorithmic perspective we emphasize in this course.
---

## What is data science?

Although the field of data science is rapidly gaining in popularity,
its definition is tenuous, at best.  As one of the statistics faculty
noted when talking to us about possible ways to design a data science
curriculum, "if you ask a dozen statisticians to define data science,
you'll get at least a half-dozen different answers".  In this course,
we take an algorithmic approach to data science.  Let's consider what
we mean by that.

Data science, like statistics, is a way of exploring sets of information.
Data science distinguishes itself from statistics by focusing more on
providing a wide variety of mechanisms for gaining potential insights from
existing data sets.  In addition, to a computer scientist, data science
is an opportunity to think about a progression of ways to work with data.
For example, here is an "algorithmic" data science pipeline: Starting with
a data set that is typically in a somewhat unstructured, less-than-usable
form, one *wrangles* the data into a usable form, *cleans* the data to
remove less applicable data points (e.g., incomplete entries), *filters*
the data to extract the data points of interest, *processes* the data
to put it in a common form, *merges* the data with other data sets, and
finally *analyzes* or *visualizes* the data which may lead to insight.
Admittedly, this approach relegates much of the interesting statistics and
mathematics to "analyzes".  However, for the purposes of an this course,
it allows you to focus on concepts from computer science in the context
of data science.

Importantly, one does all these steps *programmatically*, so that it is
possible to replicate the steps on a new or modified data set.  It is
the replicability that helps distinguish data science from other more ad
hoc techniques for exploring data.  When a data scientist removes data
from their data sets, you know it because the instruction to do so is
in the program.

## A narrative example

It may help to consider those steps in context.  Let us consider a
situation in which a student, Bari, is interested in exploring how
much people spend on coffee.  Bari may be doing so because they drink
coffee and want to think more about their spending habits, because they
are considering opening a coffee service, because they are lobbying the
institution's financial aid office to change its claimed "expected living
costs", or just they need to come up with some data set of the class.

After a Web search, Bari finds a report on common coffee purchases at
a local Stellaclams and a 'blog in which someone describes their daily
drinking habits (including prices).  They also convince a classmate who
works at The Joe (a local coffee shop) to surreptitiously write down
purchases for a week.  (Of course, they first have this study
approved by the College's Institutional Review Board, which considers
all studies involving human subjects.)

While Bari can download the Stellaclams and 'blog pages, they cannot use
those pages in the current form.  Hence, they must extract the data from
those pages.  We term that task *wrangling* the data.  While wrangling
is important, it is not a core focus of the course.  You will generally
work with data that has already been wrangled into a more useful form.

While examining the data, Bari discovers that some of the prices make
no sense---no one spends more than $10 for a cup of coffee and it seems
unlikely that coffee has a negative price.  After ensuring that the
wrangling did not introduce spurious information, Bari must therefore
clean the data to get rid of the non-sensical data.  In our class, you
will sometimes clean data that is missing fields, such as a location
that has a name, but not a latitude or longitude.

Bari may also have more data than they can (or want to) use.  For example,
they may want to focus on the past month's data from the 'blog or
Stellaclams.  Or they may want to look only at the basic "cup of joe",
rather than on other less-pure genres of coffee drink.  We call the
process of extracting the entries of interest *filtering*.

Note that we distinguish cleaning the data from filtering the data to
clarify that there is a difference between removing data that can't be
used and removing data that we choose not to use.  However, you may find
that you use similar processes, such as the `filter` procedure, for both
activities.

In further exploring the data, Bari realizes that the three sets provide
different units.  Stellaclams reports in terms of dollars and cents
(as in $3.10).  For some reason, the author of the 'blog has decided
to record prices in pieces of eight.  (Here's an example from the blog:
"I went to Stellaclams today.  They raised their prices.  I can't believe
that I had to spend 25 pieces of eight on a plain old cup of joe!").
Because they wanted to surreptitiously record the data, Bari's friend
rounded all prices to the nearest whole dollar amount.  After consulting
with their professor, Bari decides that for the sake of comparison,
all three data sets should use whole-dollar prices.  Bari then writes a
program that *processes* or transforms the data into a common form and
*merges* the three data sets together.

Bari can then visualize the data or compute summary values, such
as the average cost or the variability in prices.

As you might expect, throughout the semester we will explore ways to
wrangle, clean, filter, process, merge, analyze, and even visualize
data.  Along the way, we will start to build our own tools to make
it easier for us to do all of these processes.

## Additional responsibilities

Although we are approaching data science algorithmically, we have one
additional set of responsibilities in our work as data scientists and
as computer scientists: We must treat the data ethically.  For better
or for worse, the analyses that data scientists do may influence the
behavior of others.  While data science is not a profession in the
sense of law, medicine, or engineering, data scientists have the ethical
responsibilities associated with the professions.

In particular, we must consider the data itself and the reliability of
our conclusions.  In some cases, the consideration may take into account
the data we have gathered: Are there possibly missing entries or columns
that might lead us to come to a different conclusion?  For example,
if we are looking for extreme places in a messy set of location data,
might some of the more extreme locations be more likely to be lacking
their latitude or longitude, or have less precise latitude or longitude.
In the coffee example, are we giving the data from the 'blogger too much
weight and what might Bari's associate be missing as they record data?

We also have an obligation to consider our processes themselves.  Would
different processes have led to slightly or completely different result?
If so, we should lend little credence to our results, and should discourage
others from making use of those results.

It is easy to forget these responsibilities, particularly as we are just
developing skills for analyzing data algorithmically.  Nonetheless, we
will do our best as a class to reflect back on these issues with some
regularity.
