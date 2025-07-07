---
title: Reading data from files
summary: |
  We begin our consideration of ways to store data in files
  and how to work with data once they are stored in files.  Along the
  way, we consider some of the complexities of representing data.
---

## Introduction: Storing data

In our recent exploration of tables we found that it is possible
to work with tables of data when they are represented as lists of lists.
And that makes sense if we're working in Scheme.  However, people work
with data in many languages, so we should not store it in Scheme format.
Fortunately, there are a variety of formats that computer scientists
use to store data.  We will explore a few such formats and the procedures
we use to work with data in those formats.

## Comma-separated values

The most common file format for tables of data are comma-separated
value files, most typically referred to by the initials "CSV" or "csv".
Each line of a csv file contains one row of a table, with the entries
separated by commas (hence the name).  In general, the assumption in
csv files is that something that looks like a number is a number and
everything else is a string.  For example, here is an entry in our
"state capitals" file for Des Moines.

```nohighlight
Iowa,Des Moines,41.590939,-93.620866
```

At first glance, the basic rules seem simple and straightforward:
(1) values are separated by commas, (2) numbers represent numbers,
(3) everything else is a string.  But when we start to probe the
details, things get a bit more complicated.

What if we want to include a comma in one of the entries, such as "The
Roswell, New Mexico Crash" from our UFO table?  The designers of csv
sensibly decided that we should be able to put strings that include
commas in quotation marks.  Hence, we might write the following.

```nohighlight
1947,"The Roswell, New Mexico Crash","July, 1947",USA,Yes,Yes,Yes,No 
```

Quotation marks are also useful when we want to represent something that
looks like a number, but should be treated verbatim.  For example,
zip codes look like numbers.  However, we typically want the leading
zeros, such as `02158` rather than `2158`.  In representing our
data that includes zip codes, we would therefore put each zip code
in quotation marks.

```nohighlight
"02158",42.385096,-71.208399,"Newton","MA","Middlesex"
```

There are a few other subtleties, such as how you represent a string
that includes both a comma and a double-quotation mark.  But those are
rare enough that we'll leave them as an appendix.  

## Reading from csv files

The `csc151` package provides one primary procedure for reading from
csv files, `read-csv-file`.  It takes as its parameter a string that
describes the location of the file on the filesystem.  For example,
we might write

```
> (read-csv-file "/home/rebelsky/share/csv/courses.csv")
'(("Rebelsky" "2017F" "CSC-151" 1 4)
  ("Klinge" "2017F" "CSC-151" 2 4)
  ("Rebelsky" "2017F" "CSC-151" 3 4)
  ...
  ("Rebelsky" "2018S" "CSC-321" 1 2)
  ("Rebelsky" "2018S" "CSC-322" 1 2)
  ("Klinge" "2017F" "CSC-341" 1 4))
```

As this example suggests, we are likely to get a lot of data.  So we
almost always use `read-csv-file` in conjunction with a definition.

```
> (define courses (read-csv-file "/home/rebelsky/share/csv/courses.csv"))
> (take courses 3)
'(("Rebelsky" "2017F" "CSC-151" 1 4)
  ("Klinge" "2017F" "CSC-151" 2 4)
  ("Rebelsky" "2017F" "CSC-151" 3 4))
```

Once we've read a csv file, we can treat it just as we've been treating
any other list of lists.

You may also find files that are much like csv files but that use a
different character as a separator.  The most common separator other
than comma is a tab.  To read such files, you use the awkwardly named
`read-csv-file-w/sep`, which takes two parameters: the file name and
the character used for separating entries.

## Naming files

Racket is surprisingly clueless about finding files.  We might say "It's
right *there*."  But *there* is not clear to the computer.  Hence, we will
generally identify files by their full path name.  As the example above
suggested, when we are working on a Unix/Linux system, we most typically
use a path name of the form `"/home/`*`username`*`/path/to/file"`.  For
example, if `us-zip-codes.csv` is sitting on your desktop, you would
write `"/home/`*`username`*`/Desktkop/us-zip-codes.csv"`. Some version of Racket will be able to find a file that is in the same folder as your code just by the file name, but not all versions support this feature.

If you are working on a Mac, you start the path with `/Users` rather than
`/home`, as in `"/Users/`*`username`*`/Desktkop/us-zip-codes.csv"`.

Windows path names are much more complicated.  Read [the Racket 
documentation](https://docs.racket-lang.org/reference/windowspaths.html)
if you want to deal with files on Windows.

## Working with plain text files

While csv files are the most common form of tabular data, there are 
certainly other kinds of data we might want to work with.  One of the
simplest is what we would call a "plain text file", a file that just
contains words.  Plain text files often have a `.txt` suffix, although
you'll also find variants.

Computer scientists and data scientists work with text files in a
variety of ways.  They might, for example, search for particular words or
attempt to rewrite the text in a file into a new form or a new language.
They might look for some statistical properties of the text to try to gain
some insight.  We might (and will) also consider similar issues.

The `csc151` package provides three basic operations for working with
text files: `file->chars`, which reads the contents of a text file and
presents the contents as a list of characters; `file->words`, which
reads the contents of a text file and presents the contents as a list
of strings, each of which represents one "word" in the file (using a
simple metric for "word"); and `file->lines`, which reads the contents
of a text file and presents the contents as a list of strings, each
of which represents one line of the input file.

Suppose we had the previous paragraph in a file.  Here's what we
might get reading it each way.

```
> (take (file->chars "/home/rebelsky/share/text/csc151-textfile-procs.txt") 20)
'(#\T #\h #\e #\space #\` #\c #\s #\c #\1 #\5 #\1 #\` #\space #\p #\a #\c #\k #\a #\g #\e)
> (take (file->words "/home/rebelsky/share/text/csc151-textfile-procs.txt") 10)
'("The" "csc151" "package" "provides" "three" "basic" "operations" "for" "working" "with")
> (take (file->lines "/home/rebelsky/share/text/csc151-textfile-procs.txt") 5)
'("The `csc151` package provides three basic operations for working with"
  "text files: `file->chars`, which reads the contents of a text file and"
  "presents the contents as a list of characters; `file->words`, which"
  "reads the contents of a text file and presents the contents as a list"
  "of strings, each of which represents one \"word\" in the file (using a")
```

We can then process those lists in different ways.  We will begin in the
lab by exploring tallies.

## Finding data in a table

Once we have our data out of a file and into a table, or list of lists, we may want to be able to find a particular entry by the first item in it, which is often called a *key*. This way of storing our data, with each list starting with a key that we can use to find that entry, is called an *association list*. 

## `assoc`, Scheme's built-in lookup procedure

Since applications in which we need to extract data from tables are
very common, Scheme provides procedures to retrieve from an association
list the entry containing a specified key. The most frequently used
procedure of this kind is `assoc`. Given a key and association list,
`assoc` returns the first entry with the given key. If the key does not
occur in the association list, then `assoc` returns `#f`. For example, if we had a directory:

```
;;; Value:
;;;   grinnell-directory
;;; Type:
;;;   List of lists.
;;; Note:
;;;   * Each sublist is of length at least four and contains a last
;;;     name, a first name, a username, a phone number, and an
;;;     optional sequence of attributes.
;;;   * The
;;; Contents:
;;;   A list of people at Grinnell with contact information and some
;;;   useful attributes.
(define grinnell-directory
  (list
    (list "Rebelsky" "Samuel" "messy-office" "4410")
    (list "Klinge" "Titus" "cauldron" "3271")
    (list "Weinman" "Jerod" "map-reader" "9812")
    (list "Osera" "PM" "type-snob" "4010")
    (list "Curtsinger" "Charlie" "systems-guy" "3127")
    (list "Vostinar" "Anya" "cache" "4306")
    (list "Dahlby-Albright" "Sarah" "cheery-coach" "4362")
    (list "Rodrigues" "Liz" "vivero" "3362")
    (list "Barks" "Sarah" "stem-careers" "4940")
    (list "Kington" "Raynard" "the-prez" "3000")))
```

we could look up people from their last name:

```
> (assoc "Barks" grinnell-directory)
'("Barks" "Sarah" "stem-careers" "4940")
> (assoc "Reisch" grinnell-directory)
#f
```

## Self checks

### Check 1: Your own csv file

a. Create a csv file that represents your schedule for the semester.
For example, a line of your file might read

```
CSC-151,01,MWF,2:30,3:50,Professor Rosseforp
```

b. Confirm that you can read the file using `read-csv-file`.

### Check 2: Reading text

a. What do you expect to happen if you call `file->chars`, `file->words`,
and `file->lines` on the csv file you created in the first self check?

b. Check your answer experimentally.
