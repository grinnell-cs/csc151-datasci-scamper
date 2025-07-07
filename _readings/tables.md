---
title: Representing tables
summary: |
  We start to consider how to represent and manipulate
  tables of data.  We consider, in particular, some of what is possible
  when we represent tables as lists of lists.
---

## Introduction: Compound data

One of the foci of this course is techniques for processing collections
of data computationally and reproducibly, which is one aspect of the field
known as data science.  But how do we think of the data that we are 
processing?  You've seen one way: We can have a list of numbers or strings
or other kinds of values.

However, we more frequently handle *compound* data, collections of data
in which each entry contains multiple values.  In representing a UFO
sighting, we might have a short description, the location, the date,
and perhaps some notes as to whether or not important aspects of a
UFO sighting were present.  In representing capital cities in the US,
we might have the state, the name of the capital, the city's latitude,
and the city's longitude.  For example,

<table class="table table-hover">
  <tr><td>Alabama</td><td>Montgomery</td><td>32.361538</td><td>-86.279118</td></tr>
  <tr><td>Alaska</td><td>Juneau</td><td>58.301935</td><td>-134.419740</td></tr>
  <tr><td>Arizona</td><td>Phoenix</td><td>33.448457</td><td>-112.073844</td></tr>
  <tr><td>Arkansas</td><td>Little Rock</td><td>34.736009</td><td>-92.331122</td></tr>
  <tr><td>California</td><td>Sacramento</td><td>38.555605</td><td>-121.468926</td></tr>
  <tr><td>Colorado</td><td>Denver</td><td>39.7391667</td><td>-104.984167</td></tr>
  <tr><td colspan="4" halign="center">...</td></tr>
</table>
 
What do we do with tables of data?  The process we've been starting
to explore: We *clean* the table to get rid of entries that may not
make sense; we *filter* the table to extract entries of interest;
we *transform* the entries to put them in a more useful form; and we
*process* or *visualize* the data to extract insight.  To do all that,
we need the table data in a form we can use.

## Representing tables

As you might expect, we represent tables as lists of lists.  Each list
contains one row of the table.  For example, we might represent the
entry for Iowa as

```
'("Iowa" "Des Moines" 41.590939 -93.620866)
```

We could represent the whole list of states with a list of those
lists.

```
'(("Alabama" "Montgomery" 32.361538 -86.279118)
  ("Alaska" "Juneau" 58.301935 -134.41974)
  ("Arizona" "Phoenix" 33.448457 -112.073844)
  ...
  ("Wisconsin" "Madison" 43.074722 -89.384444)
  ("Wyoming" "Cheyenne" 41.145548 -104.802042))
```

## Ordering data in tables

What can we do with these data?  As we saw with simpler lists, one of
the simple techniques we do with data are to sort or order the data 
according to some principle.  We sorted lists of numbers from smallest
to largest or largest to smallest.  We sorted lists of strings from
alphabetically first to alphabetically last or vice versa.

Suppose we want to see the list of capitals ordered by city name
rather than state name.  We'll need a way to compare two entries
that says "The row with the alphabetically first city name comes first".
That comparator will need to extract the city names and then compare
them alphabetically.  We can extract city names with `cadr` and
compare using `string-ci<?`.

```
;;; Procedure:
;;;   city-city<?
;;; Parameters:
;;;   city1, a city
;;;   city2, a city
;;; Purpose:
;;;   Compare two cities based on the city name.
;;; Produces:
;;;   first?, a Boolean value
;;; Preconditions:
;;;   city1 and city2 are lists of the form 
;;;     (state:string, city:string, latitude:real, longitude:real)
;;; Postconditions:
;;;   * If the city field of city1 alphabetically precedes the city
;;;     field of city2, first? is #t.
;;;   * Otherwise, first? is #f.
(define city-city<?
  (lambda (city1 city2)
    (string-ci<? (cadr city1) (cadr city2))))
```

Let's see how well this works.

```
> (sort capitals city-city<?)
'(("New York" "Albany" 42.659829 -73.781339)
  ("Maryland" "Annapolis" 38.972945 -76.501157)
  ("Georgia" "Atlanta" 33.76 -84.39)
  ...
  ("Florida" "Tallahassee" 30.4518 -84.27277)
  ("Kansas" "Topeka" 39.04 -95.69)
  ("New Jersey" "Trenton" 40.221741 -74.756138))
```

It looks pretty well, indeed.  

## Filtering data

While we are not yet ready to write complex filters, we do know some
simple ways to filter, such as what we can achieve with `take` or `drop`.

What if we want to find the five Northernmost capitals (that is, those
that have the highest latitude).  We can write another comparator.

```
;;; Procedure:
;;;   city-latitude>?
;;; Parameters:
;;;   city1, a city
;;;   city2, a city
;;; Purpose:
;;;   Compare two cities based on the latitude
;;; Produces:
;;;   first?, a Boolean value
;;; Preconditions:
;;;   city1 and city2 are lists of the form 
;;;     (state:string, city:string, latitude:real, longitude:real)
;;; Postconditions:
;;;   * If the latitude field of city1 is greater than the city
;;;     field of city2, first? is #t.
;;;   * Otherwise, first? is #f.
(define city-latitude>?
  (lambda (city1 city2)
    (> (caddr city1) (caddr city2))))
```

Once again, a relatively simple expression allows us to extract the
information we need.

```
> (take (sort capitals city-latitude>?) 5)
'(("Alaska" "Juneau" 58.301935 -134.41974)
  ("North Dakota" "Bismarck" 48.813343 -100.779004)
  ("Washington" "Olympia" 47.042418 -122.893077)
  ("Montana" "Helena" 46.595805 -112.027031)
  ("Minnesota" "Saint Paul" 44.95 -93.094))
```

As this example suggests, although we think of filtering as something
that happens early in the data analysis process, we can also use filtering
as we compute summaries.

## Detour: Anonymous procedures

You may recall that when we first used `map`, we sometimes defined 
procedures using `o` and used them directly without naming them.  We
can do the same with comparators defined using `lambda`.  How?  
Instead of using the name of a comparator, just use the body.  After
all, that's all Scheme is doing when you give it a procedure name.

Here's an instruction that finds the five Westernmost capitals.

```
> (take (sort capitals (lambda (city1 city2) (< (cadddr city1) (cadddr city2)))) 5)
'(("Hawaii" "Honolulu" 21.30895 -157.826182)
  ("Alaska" "Juneau" 58.301935 -134.41974)
  ("Oregon" "Salem" 44.931109 -123.029159)
  ("Washington" "Olympia" 47.042418 -122.893077)
  ("California" "Sacramento" 38.555605 -121.468926))
```

We can even put those in alphabetical order by state name.  (Remember:
Scheme works from the inside out.)

```
> (sort 
   (take (sort capitals (lambda (city1 city2) (< (cadddr city1) (cadddr city2)))) 5)
   (lambda (city1 city2) (string-ci<? (car city1) (car city2))))
'(("Alaska" "Juneau" 58.301935 -134.41974)
  ("California" "Sacramento" 38.555605 -121.468926)
  ("Hawaii" "Honolulu" 21.30895 -157.826182)
  ("Oregon" "Salem" 44.931109 -123.029159)
  ("Washington" "Olympia" 47.042418 -122.893077))
```

## Transforming

What if we don't like the order in which the data in a row are presented
to us?  For example, we might prefer to have capital names precede
state names, particularly when we are listing them alphabetically by
capital name.  You probably already know the answer: We'll write a procedure
that swaps the data in one row and then apply it to every row with `map`.

Let's see ... How do we swap the first two elements?  We can grab the
city name with `cadr`.  We can grab the state name with `car`.  We can
grab the latitude and longitude as a list with `cddr`.  A few calls to
`cons` will let us put everything back together.

```
;;; Procedure:
;;;   swap-first-two
;;; Parameters:
;;;   lst, a list
;;; Purpose:
;;;   Create a new list by swapping the first two elements of lst.
;;; Produces:
;;;   newlst, a list
;;; Preconditions:
;;;   (length lst) >= 2
;;; Postconditions:
;;;   * (length newlst) = (length lst)
;;;   * (list-ref newlst 0) = (list-ref lst 1)
;;;   * (list-ref newlst 1) = (list-ref lst 0)
;;;   * For all i, 2 <= i < (length lst),
;;;     (list-ref newlst i) = (list-ref lst i).
(define swap-first-two
  (lambda (lst)
    (cons (cadr lst) (cons (car lst) (cddr lst)))))
```

Let's try that on a single capital.

```
> des-moines
'("Iowa" "Des Moines" 41.590939 -93.620866)
> (swap-first-two des-moines)
'("Des Moines" "Iowa" 41.590939 -93.620866)
```

Yup, that works pretty well.  Let's see if we can use it with sorting.

```
> (map swap-first-two (sort capitals city-city<?))
'(("Albany" "New York" 42.659829 -73.781339)
  ("Annapolis" "Maryland" 38.972945 -76.501157)
  ("Atlanta" "Georgia" 33.76 -84.39)
  ("Augusta" "Maine" 44.323535 -69.765261)
  ...
  ("Tallahassee" "Florida" 30.4518 -84.27277)
  ("Topeka" "Kansas" 39.04 -95.69)
  ("Trenton" "New Jersey" 40.221741 -74.756138))
```

What do you expect to happen if we swap before sorting, as in the
following?

```
> (sort (map swap-first-two capitals) city-city<?)
```

## Tallying

Let's consider one additional way to explore tables.  (We'll see more
in future readings, but this is our last for this reading.)  Sometimes,
we have lists of simple values and want to see how many times each value
appears.  The `tally-all` procedure gives us such tallies.

```
> (tally-all (list 'a 'b 'a 'c 'c 'd 'b 'a 'q 'r 'r 'a 'd))
'((a 4) (b 2) (c 2) (d 2) (q 1) (r 2))
```

What did it do?  It counted the number of times each value appeared
and gave you back a list of `(value count)` lists.  Here's the 6P-style
documentation.

```
;;; Package:
;;;   csc151/tables
;;; Procedure:
;;;   tally-all
;;; Parameters:
;;;   lst, a list of values
;;; Purpose:
;;;   Tallies all of the values in lst
;;; Produces:
;;;   tallies, a list of (key count) lists.
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   * If val appears k times in lst, then (val k) appears in tallies
;;;   * If (val k) appears in tallies, then val appears k times in lst
;;;   * Each value in lst is the car of exactly one list in tallies.
```

What can we do with tallies?  Lots of things.  For example, we might
explore common starting letters for state capitals.  We'll look at
the steps we've used to think through the problem.

```
; Remind ourselves of the list of capitals
> (take capitals 5)
'(("Alabama" "Montgomery" 32.361538 -86.279118)
  ("Alaska" "Juneau" 58.301935 -134.41974)
  ("Arizona" "Phoenix" 33.448457 -112.073844)
  ("Arkansas" "Little Rock" 34.736009 -92.331122)
  ("California" "Sacramento" 38.555605 -121.468926))
; Extract the first letter of each city
> (define first-letters (map (o (section string-ref <> 0) cadr) capitals))
> (take first-letters 5)
'(#\M #\J #\P #\L #\S)
; Tally all of those
> (define first-letter-tallies (tally-all first-letters))
> (take first-letter-tallies 5)
'((#\M 3) (#\J 3) (#\P 3) (#\L 3) (#\S 6))
; Sort by number of appearances
> (define sorted-tallies 
    (sort first-letter-tallies 
          (lambda (t1 t2) (> (cadr t1) (cadr t2)))))
> (take sorted-tallies 5)
'((#\S 6) (#\C 6) (#\A 5) (#\H 4) (#\B 4))
```

Fascinating, isn't it?

Let's try one more tally.  Suppose we want to figure out the frequencies
of all letters in state capital names, not just the frequencies of 
starting letters.  What do we need to do?  Here's one approach.

* Extract all of the capital names.
* Combine them into one big string.
* Convert the string into a list of characters.
* Convert all of the letters to lowercase.
* Tally.
* Sort.

What do our results look like?  Let's see.

```
> (sort (tally-all
         (map char-downcase
              (string->list (reduce string-append (map cadr capitals)))))
        (lambda (t1 t2) (> (cadr t1) (cadr t2))))
'((#\a 43)
  (#\n 39)
  (#\o 36)
  (#\e 36)
  (#\i 29)
  (#\l 28)
  (#\r 26)
  (#\s 26)
  (#\t 25)
  (#\c 18)
  (#\m 13)
  (#\u 13)
  (#\h 12)
  (#\p 10)
  (#\space 10)
  (#\d 10)
  (#\y 8)
  (#\b 8)
  (#\g 7)
  (#\k 7)
  (#\f 7)
  (#\v 4)
  (#\j 3)
  (#\x 1))
```

Hmmm ... ten capital names have a space in them.  

We hope this last example inspired you to think of new ways of combining
the operations and techniques you've learned so far.

## Self checks

### Check 1: Revisiting examples

In DrRacket, verify that all of the examples work as advertised.  Note
that you may need to update the `csc151` library and that you'll need to
require `(csc151)`.

Here's are some definitions that might help.

```
(define des-moines
  '("Iowa" "Des Moines" 41.590939 -93.620866))

(define capitals
  '(("Alabama" "Montgomery" 32.361538 -86.279118)
    ("Alaska" "Juneau" 58.301935 -134.41974)
    ("Arizona" "Phoenix" 33.448457 -112.073844)
    ("Arkansas" "Little Rock" 34.736009 -92.331122)
    ("California" "Sacramento" 38.555605 -121.468926)
    ("Colorado" "Denver" 39.7391667 -104.984167)
    ("Connecticut" "Hartford" 41.767 -72.677)
    ("Delaware" "Dover" 39.161921 -75.526755)
    ("Florida" "Tallahassee" 30.4518 -84.27277)
    ("Georgia" "Atlanta" 33.76 -84.39)
    ("Hawaii" "Honolulu" 21.30895 -157.826182)
    ("Idaho" "Boise" 43.613739 -116.237651)
    ("Illinois" "Springfield" 39.78325 -89.650373)
    ("Indiana" "Indianapolis" 39.790942 -86.147685)
    ("Iowa" "Des Moines" 41.590939 -93.620866)
    ("Kansas" "Topeka" 39.04 -95.69)
    ("Kentucky" "Frankfort" 38.197274 -84.86311)
    ("Louisiana" "Baton Rouge" 30.45809 -91.140229)
    ("Maine" "Augusta" 44.323535 -69.765261)
    ("Maryland" "Annapolis" 38.972945 -76.501157)
    ("Massachusetts" "Boston" 42.2352 -71.0275)
    ("Michigan" "Lansing" 42.7335 -84.5467)
    ("Minnesota" "Saint Paul" 44.95 -93.094)
    ("Mississippi" "Jackson" 32.32 -90.207)
    ("Missouri" "Jefferson City" 38.572954 -92.189283)
    ("Montana" "Helena" 46.595805 -112.027031)
    ("Nebraska" "Lincoln" 40.809868 -96.675345)
    ("Nevada" "Carson City" 39.160949 -119.753877)
    ("New Hampshire" "Concord" 43.220093 -71.549127)
    ("New Jersey" "Trenton" 40.221741 -74.756138)
    ("New Mexico" "Santa Fe" 35.667231 -105.964575)
    ("New York" "Albany" 42.659829 -73.781339)
    ("North Carolina" "Raleigh" 35.771 -78.638)
    ("North Dakota" "Bismarck" 48.813343 -100.779004)
    ("Ohio" "Columbus" 39.962245 -83.000647)
    ("Oklahoma" "Oklahoma City" 35.482309 -97.534994)
    ("Oregon" "Salem" 44.931109 -123.029159)
    ("Pennsylvania" "Harrisburg" 40.269789 -76.875613)
    ("Rhode Island" "Providence" 41.82355 -71.422132)
    ("South Carolina" "Columbia" 34.0 -81.035)
    ("South Dakota" "Pierre" 44.367966 -100.336378)
    ("Tennessee" "Nashville" 36.165 -86.784)
    ("Texas" "Austin" 30.266667 -97.75)
    ("Utah" "Salt Lake City" 40.7547 -111.892622)
    ("Vermont" "Montpelier" 44.26639 -72.57194)
    ("Virginia" "Richmond" 37.54 -77.46)
    ("Washington" "Olympia" 47.042418 -122.893077)
    ("West Virginia" "Charleston" 38.349497 -81.633294)
    ("Wisconsin" "Madison" 43.074722 -89.384444)
    ("Wyoming" "Cheyenne" 41.145548 -104.802042)))
```

## Check 2: Working with slightly different data

Suppose it turns out that someone has provided us with the data in
a somewhat different form.  For example, we recently found zip code
data of the form `'(zip:string latitude:real longitude:real city:string
state-abbrev:real county:real)`.  How would the instructions above
change if we wanted to use data in this form?  (You need not redo
all of the instructions; just think about the changes.)

