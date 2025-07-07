;; CSC 151 (SEMESTER)
;; Lab: Data From Files
;; Authors: YOUR NAMES HERE
;; Date: THE DATE HERE
;; Acknowledgements:
;;   ACKNOWLEDGEMENTS HERE



; +-------------+----------------------------------------------------
; | Preparation |
; +-------------+

; 1. Make sure to discuss the self-check questions with your lab partner.
; 2. Make sure to save this file as tables.scm.
; 3. Make sure you've saved a copy of the files given on the lab page 
; 4. Update the following code so that username is replaced with your name

(define zips (read-csv-file "/home/username/Desktop/us-zip-codes.csv"))


; 5. Confirm that the first few lines of the file contains zip code entries
; of the form you expect. DO NOT OPEN THE FILE! 
; Doing so will likely alter the zipcode values. Instead, check with:

; (take zips 5)



; +-----------------------------------------+--------------------------------
; | Exercise 1: Simple explorations of data |
; +-----------------------------------------+

; (a)
; Determine how many entries there are in the zip code table.

; Write your expression and answer below


; (b)
; Determine the last few entries in the zip code table.  

; Hint: Use `drop`.

; Write your expression and answer below


; (c) 
; Find the middle five elements of the zip code table.  (You need not
; be exact, just close.)

; Hint: Use `drop` and `take` with appropriate values.

; Write your expression and answer below


; +-----------------------------+--------------------------------
; | Exercise 2: Sorting by city |
; +-----------------------------+
; (a) 
; In the tables lab, you wrote a procedure,
; `sort-by-city`, to sort zip-code entries by city name.  Copy that
; procedure (and any other associated procedures) here
; Add a citation to your prior partner or partners.

(define sort-by-city
  {??})

; (b)
; Create a copy of the zip code data sorted by city.

(define zips-by-city 
  {??} )


; (c)
; Verify that the sorting worked by examining the first few lines,
; the last few lines, and some lines in the middle.

  
; +-------------------------+--------------------------------
; | Exercise 3: Finding Data|
; +-------------------------+
; With more than 42,000 lines in the zip code file, it will be hard for
; us to manually find any particular city.  But that's why we have
; computers.

; As you know from the reading, the `assoc` procedure will search a list of lists based on the
; first value in each element list.  For example, we can find the
; entry for zip code 40506 with the instruction `(assoc "40506" zips)`.

; (a)
; Using that command, find the entry for zip code 40506.

; (b)
; There is no city with a zip code of 00000.  Verify what `assoc`
; does when you try to search for that value.

; (c)
; `assoc` only works when we're using the first value, in this case
; the zip code.  What if we want to search by city?  Write a sequence of
; Scheme instructions to find the entry for Grinnell.

; Hint: You've previously thought about rearranging lists.  You should
; use a similar approach here.


; +-------------------------------+--------------------------------
; | Exercise 4: Reflecting on data|
; +-------------------------------+

; (a) 
; In the tables lab, we identified a potential problem 
; for working with the zip code data. What was that problem?

; (b)
; Determine whether we are likely to have the same problem when working
; with the larger data set. 


; +-------------------------------+--------------------------------
; | Exercise 5: Cleaning Data     |
; +-------------------------------+
; We will have to clean these data before we can move on.  Here's a magic
; incantation that removes all of the entries that have no latitude.

(define zips-clean (filter (negate (o string? cadr)) zips))

; Confirm that this approach works.


; +-------------------------------+--------------------------------
; | Exercise 6: Extreme cities    |
; +-------------------------------+
; (a)
; Find the entries for the five northernmost cities in the zip code
; database.

; (b) 
; Find the entries for the five southernmost cities in the zip code
; database.

; (c)
; Write instructions to provide those cities in more human-friendly
; form (just the city and state, not the zip, latitude, or longitude).


; +-------------------------------+--------------------------------
; | Exercise 7: Tallying states   |
; +-------------------------------+
; (a)
; Write an instruction to extract just the states from the cleaned
; list of zip codes.

; (b) 
; Create a tally of the states using `tally-all`.

; (c) 
; Order that tally from largest to smallest.

; (d)
; Determine which three states appear most often in this list.

; +-------------------------------+--------------------------------
; | Exercise 8: Text Data         |
; +-------------------------------+
; Project Gutenberg (https://www.gutenberg.org/) provides an extensive
; collection of public domain books in a variety of forms, including 
; "plain text".

; (a) 
; Navigate to the Project Gutenberg Web site and download a few books 
; in plain text format.  Strive for short- to medium-length books.  
; JaneEyre (https://www.gutenberg.org/ebooks/1260) is okay.  
; The Complete Works of William Shakespeare(https://www.gutenberg.org/ebooks/100)
; is not.



;(b)
; Pick one of the books you've downloaded and write instructions
; to read the characters, words, and lines from the book. For example:
; (define book-letters (file->chars "/home/rebelsky/Desktop/pg1260.txt"))
; (length book-letters)
; 1070329

(define book-letters
  {??})

(define book-words
  {??})

(define book-lines
  {??})

; (c) 
; Grab the first 20 characters, 10 words, and 5 lines from the book.

; Note: You may discover that Project Gutenberg adds a header.

; +-------------------------------+--------------------------------
; | Exercise 9: Tallying          |
; +-------------------------------+
; Unfortunately, the `tally-all` procedure is slow.  It works fine for 
; moderate sized data sets, but poorly for large data sets.

; (a)
; Write code  to tally the first 10,000 words in your chosen text. 

(define tally-first-10k
  {??})

; (b) 
; Find the five most-frequently-used non-trivial words. 
; You don't need to write expressions to get these, you can 
; look at the first part of the sorted list to identify them. 
; The definition of non-trivial is up to you.


  
; +---------------+--------------------------------
; | Extra problems|
; +---------------+

; If you find that you have extra time, you may try any of the following.
; (That is, you need not do them in order from first to last.)

; +-----------------------------------+--------------------------------
; | Extra 1: The beginning and the end|
; +-----------------------------------+
; In an earlier exercise, you found the five most-frequently-used
; non-trivial words in the first 10,000 words of the text.  Determine
; how frequently each of those words is used in the last 10,000 words of
; the text.

; +-----------------+--------------------------------
; | Extra 2: Digrams|
; +-----------------+
; In analyzing texts, it is often useful to create "digrams", pairs
; of neighboring elements in the text.  

; (a)
; Create a list of the first 1001 words in your text.

; (b)
; Using that list, create a list of the first 1000 word digrams in the
; text. 

; Hint: Use `(map (string string_apppend <> " " <>) ... ...)`.

; (c)
; Can you figure out which word most frequently follows "the"?

; (d) 
; Is your answer different if your first convert the words to
; lowercase using `string-downcase`?

(define sample-words (map string-downcase (take book-words 1000)))


; +-------------------------------+--------------------------------
; | Extra 3: Why generate digrams?|
; +-------------------------------+
; We've seen one use of generating digrams: Digrams can tell us a bit
; more about the author, such as what words the author uses immediately
; after or before another word.  

; But digrams (or their extensions) can also be used to generate 
; text.  Read this blog post:
; https://blog.algorithmia.com/playing-with-n-grams/
; and reflect on possibilities.

; +--------------------------------+--------------------------------
; | Extra 4: Who needs punctuation?|
; +------------------------------=-+

; While the list of characters we've received from `file->chars` is 
; comprehensive, it contains a lot of characters we might not want.  
; Let's consider a way to get a more "useful" set of characters.

; (a) 
; Write instructions to create a single string that consists of the
; first five hundred or so words of the text, separated by spaces.

; (b)
; Convert that string to a list of characters using `string->list`.

; (c)
; Using those characters, create a list of two-letter digrams.

; (d)
; Reflect on how those digrams might be useful


