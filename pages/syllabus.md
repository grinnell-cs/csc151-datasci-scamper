---
title: Functional Problem Solving
permalink: /syllabus/
---

# CSC-151 (Functional Problem Solving, Fall 2025)

## About

<dl class="dl-horizontal">
  <dt>Instructors</dt>
  <dd>
  <ul class="list-unstyled">
    {% for item in site.instructor %}
      <li>{{ item | markdownify | remove: "<p>" | remove: "</p>"  }}</li>
    {% endfor %}
    </ul>
  </dd>

  <dt>Class Meeting Times</dt>
  <dd>
    <ul class="list-unstyled">
      {% for item in site.meeting_times %}
        <li>{{ item | markdownify | remove: "<p>" | remove: "</p>" }}</li>
      {% endfor %}
    </ul>
  </dd>

  <dt>Instructor Office Hours</dt>
  <dd>
    <ul class="list-unstyled">
      {% for item in site.office_hours %}
        <li>{{ item | markdownify | remove: "<p>" | remove: "</p>" }}</li>
      {% endfor %}
    </ul>
  </dd>

  {% if site.review_sessions %}
    <dt>Review Sessions</dt>
    <dd>
      <ul class="list-unstyled">
        {% for session in site.review_sessions %}
          <li>{{ session }}</li>
        {% endfor %}
      </ul>
    </dd>
  {% endif %}

  {% if site.textbook %}
    <dt>Textbook</dt>
    <dd>
      {{ site.textbook | markdownify | remove: "<p>" | remove: "</p>" }}
    </dd>
  {% endif %}

  {% if site.mentor %}
    <dt>Class Mentor</dt>
    <dd>{{ site.mentor }}</dd>
  {% endif %}

  {% if site.mentors %}
    <dt>Mentors</dt>
    <dd>
      <ul class="list-unstyled">
        {% for mentor in site.mentors %}
          <li>{{ mentor }}</li>
        {% endfor %}
      </ul>
    </dd>
  {% endif %}

  {% if site.mentor_sessions %}
    <dt>Mentor Sessions</dt>
    <dd>
      <ul class="list-unstyled">
        {% for session in site.mentor_sessions %}
          <li>{{ session | markdownify | remove: "<p>" | remove: "</p>" }}</li>
        {% endfor %}
      </ul>
    </dd>
  {% endif %}

  {% if site.tutors %}
    <dt>CS Tutors</dt>
    <dd>
      <ul class="list-unstyled">
        {% for tutor in site.tutors %}
          <li>{{ tutor }}</li>
        {% endfor %}
      </ul>
    </dd>
  {% endif %}

  {% if site.tutor_sessions %}
    <dt>Evening Tutor Sessions</dt>
    <dd>
      <ul class="list-unstyled">
        {% for time in site.tutor_sessions %}
          <li>{{ time }}</li>
        {% endfor %}
      </ul>
    </dd>
  {% endif %}
</dl>

Welcome to CSC 151! In this class, you will learn computer programming using the Scamper programming language. You do not need any prior knowledge of computer science or programming. All sections this semester will focus on data science.


## Learning Objectives

This course covers 16 learning objectives (LOs). 

1. **Primitive types**. Express basic computations over primitive values and their associated standard library functions.
2. **Procedural abstraction**. Take a concrete implementation in Racket and create a procedure that generalizes that behavior.
3. **Tracing.** Trace the execution of a Racket program using a substitutive model of computation.
4. **Conditionals**. Use Boolean expressions and conditional operations to produce conditional behavior.
5. **Lists**. Manipulate lists with fundamental higher-order list functions.
6. **Decomposition**. Decompose a computational problem into smaller sub-problems amendable to implementation with functions.   
7. **Testing**. Test programs according to good software engineering principles.   
8. **Documentation**. Document programs according to good software engineering principles.   
9. **Local bindings**. Refactor redundancy and add clarity in computations with let-bindings.   
10. **List recursion**. Design and write recursive functions over lists.   
11. **Numeric recursion**. Design and write recursive functions over the natural numbers.   
12. **Higher-order programming**. Write procedures that take procedures as parameters and return procedures as results.   
13. **Lambda-free anonymous procedures**. Use section and composition to simplify computations.   
14. **Dictionaries**. Design and write functions that use dictionaries.   
15. **Vectors**. Design and write functions (potentially recursive functions) that use vectors.   
16. **Data abstraction**. Design data structures to separate interface from implementation.   

## Communication

Course Website
: This website contains all courses policies. Course materials and homework deadlines will be posted here as they become available. Familiarize yourself with the website so you know where to find everything.

Email
: Your instructor will send course announcements via email. You are responsible for reading all email from your instructor.

Microsoft Teams
: Our class has a Teams site for Q&A shared by all four sections. If you have a question and others in the class could benefit from its answer, please post in the relevant teams channel.

Getting in touch with your instructor
: If you need to get in touch with your instructor privately, use email or teams. We try to reply to messages within about 24 hours, excluding weekends and holidays. If you do not hear back within that amount of time, please send a reminder.

Gradescope
: You will submit assignments via gradescope. Please confirm that you have been added to this class on gradescope.

## Class meetings and help resources

Class meetings
: Most days of class are lab days. Your instructor will make announcements and might briefly present concepts. Most of the time, you will collaborate with your lab team on programming practice problems. 

Evening tutors
: 5 days per week, peer educators will be available in our classroom during certain hours to help you with homework questions. You can drop in at any time to work on your homework or ask a question.

Mentor sessions
: 3 times per week, a peer educator will hold a supplementary session where they might offer a review of concepts from class or practice problems. You should show up at the start of the session and stay until the end.

Informal time
: You are encouraged to come to our classroom to study and work at any time that the room is not reserved for class or a meeting. This is an opportunity to study with peers and form community.

Office hours
: Your instructor will hold office hours each week. This time is for you to meet with your instructor and talk about any course related matter that you like\!

Individual tutors
: If you are taking advantage of the resources above and need more help, contact your instructor to request an individual tutor to meet with you one-on-one.

[**Academic advising**](https://www.grinnell.edu/about/leadership/offices-services/academic-advising)
: Grinnell offers academic coaches available to you as a resource to help you develop learning strategies and support you in your learning.

## Deliverables

Reading responses
: Prior to each class meeting, you will read an online reading assignment about computing concepts, work through code examples in a programming environment, and answer a few questions about the reading

Labs
: During each class meeting, you will work with a partner to complete programming exercises to practice the concepts from the readings

Coding Challenges
: About once per week you will complete an individual programming assignment where you apply and extend concepts from readings and labs. 

Final project
: The final programming assignment will be more open ended and completed in teams.

Quizzes
: About once per week, you will complete an individual quiz in class on paper.

Misc activities
: Miscellanious activities, usually aimed at meta-cognitive learning. For example you may be asked to reflect on how a particular assessment went, to help you understand what went well and what went poorly. 

## Collaboration and Resources

Computer science is collaborative, and we encourage much collaboration in your learning. However some of your course work is intended to assess individual knowledge and must be completed individually. When you do collaborate, make sure to collaborate in ways that support, rather than undermine, your learning.

Here are the collaboration policies for each type of coursework:

Reading responses
: 
- You are encouraged to work with others to understand the readings
- Write your own answers to the reading response 
- You may get help from course staff and peers 
- Make sure you are able to explain all submitted answers yourself

Labs
: 
- Typically completed in teams of 2 (might be a team of 1 or 3 under certain circumstances)
- All team members should contribute equally to all parts of the lab
- You may get help from course staff and peers outside your team
- Make sure every team member can explain your team's answers

Coding Challenges
: 
- Completed individually
- As help resources, you are highly encouraged to use the following:
  - the course website
  - your own class notes (those you have written yourself)
  - your own lab solutions (written by you and your lab partners)
  - help from course staff, including evening tutors, mentors and instructors
- The following are allowed, but not recommended in order to get as much learning as possible from the course:
  - You may discuss the assessment with peers, inside or outside the class. However, every student should write their own solution in code.
  - You are allowed to use other resources (maybe most top of your mind: the internet and all its resources).
  - ANY resource used under this category ("not recommended") **MUST** be appropriately cited. This includes: Any person, any website, any text, etc. If you used Generative AI to write code and/or text you must include in your citation the name of the model you used, the exact prompt you used, and the exact results given by the GenAI. 

 
Quizzes 
: 
- Completed individually in class
- No form of collaboration is permitted

Final project
: 
- Completed in groups of 3–4
- All members should contribute equally to the project
- You may get help from course staff and peers outside your team
- You are allowed to use other resources, with the same policy as Coding Challenges. 

## Grading

Here is the grading policy for each type of coursework:

Reading responses 
: 
- Graded **S/N** based on whether you answered the assigned questions with a good faith effort  
- **S** = Satisfactory
- **N** = Not satisfactory  

Labs
: 
- Graded **S/N** based on whether you answered the assigned questions with a good faith effort  
- **S** = Satisfactory
- **N** = Not satisfactory  

Coding Challenges and the Final Project
: 
- Graded **EMRN** based on correctness and following instructions  
  * **E** = Exceeds expectations  
  * **M** = Meets expectations  
  * **R** = Needs revision  
  * **N** = Not complete (did not make a good faith effort)  
- Criteria for each letter grade are given on the instructions for each assessment.
- Each Coding Challenge is worth 1 assignment point in the table below, and the final project is worth 2 assignment points. 

Learning Objectives (Quizzes)
: 
* You will demonstrate your mastery of each Learning Objecive (LO) in quizzes.
* Each quiz problem gives you an opportunity to demonstrate mastery of **one** LO.  
* Each problem is graded **S/N**
  * **S** = Satisfactory (demonstrated mastery)  
  * **N** = Not _Yet_ Satisfactory (did not yet demonstrate mastery)  
* Once you have demonstrated mastery of a certain LO, you do not need to be assessed on that LO again. On the flipside, if you receive **N** on a quiz problem, you'll have the opportunity to demonstrate your mastery of that topic on a future quiz. 

### Final grade

This class uses different ideas of "ungrading" and "specifications based grading". It is our hope that these methods of evaluation will remove stress and focus all of our attention on learning as much as possible.

|   	| &nbsp;   &nbsp; Coding Challenges and Final Project &nbsp; &nbsp; &nbsp; &nbsp;   &nbsp;	| Quizzes (LOs) &nbsp; &nbsp;	| &nbsp;   &nbsp; &nbsp;   &nbsp; Labs, Readings, and Misc. 	|
|---	|:-------------------:	|:---------------:	|:---------------------------:	|
| **C** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;	| at most 2 *R*'s, the remaining *M* or higher      	| at least 11 *S*           	| at most 12 *NS*                  	|
| **B** 	| 10 *M*'s or higher            	| at least 13 *S*           	| at most 6 *NS*                   	|
| **A** 	| at most 2 *M*'s, the remaining 8 *E*       	| 16 *S*           	| at most 4 *NS*                   	|

<br>


Let's walk through the table on how to get an A in the course. Over the course of all of the coding challenges and final project, you must earn at least 8 grades of *E* - coding challenges each count for 1, and the final project counts for 2. The remaining two grades must be at least an *M*. Next, you must receive an *S* on all 16 of the quiz problems (learning outcomes). Finally, you may have at most 4 grades of *NS* accross all reading problems, labs, or other miscellaneous assignments. 


Other grades are possible as well (A-, B+, B-, C+, D, F). You may earn an **A-** or **B+** by meeting all of the requirements of the **B** grade, and one (**B+**) or two (**A-**) requirements from the **A** grade. You may earn a **B-** or **C+** by meeting all of the requirements of the **C** grade and one (**C+**) or two (**B-**) of the requirements of the **B** grade. Earn a **D** if two of the requirements of a **C** are met. Earn an **F** if zero or one of the requirements of a **C** are met.

*Important Note*
Be aware that if you are at an A tier for one deliverable category but at a C tier for another, then you fully qualify for the C tier and partially meet the requirements of the B tier and thus would be considered for plus/minus grades in the B/C range.

**Attendance Policy**

In class attendance is important to your learning this semester, thus attendance is required. Receiving a positive note on attendance includes:
- Arriving to class on time
- Staying until the end of class
- Acting as a respectful class member to peers
- Actively engage and participate in class

When you miss a class day (excused or unexcused) you are still responsible for the material covered in class. You should review readings, labs, and notes from class and consult with peers who were in class the day you missed to catch up. You should complete the days lab individually. If you plan to miss a quiz, talk with the instructor as soon as possible. 

If you miss a significant number of class days (including via excused absences) it may be difficult for you to meet the expectations of the course. Additionally, if you miss more than one class period in a row without notice to me, you should expect to hear from me as well as student advising (via SAL). The goal here is not to scold you, but to make sure you’re aware of the situation and have the information you need to stay on track or withdraw from the course if completing it successfully is no longer feasible.

*Unexcused absences*: An excessive number of unexcused absences (including being marked as late or not participating) will impact your grade in the following manner. If you are unexcused for more than 3 days, you may not receive a grade higher than a B+ in our class. Similarly, if you are unexcused for more than 6 days you may not receive higher than a C+ in our class. Finally, if you are unexcused for more than 9 days, you may not receive a grade higher than a D.

*Excused absences*: You may be excused for a class under certain situations. If you plan to observe holy days that coincide with class meetings or assignment due dates to consult with your instructor in the first three weeks of classes so that we may reach a mutual understanding of how you can meet the terms of your religious observance and also the requirements for this course. Likewise, please discuss with me in the first three weeks of the semester if you will be absent due to athletic events.

You may also be excused from class in the even of an emergency or illness. I will not require proof or details, just please inform me as soon as you are able. If you attend class with respiratory symptoms, please consider wearing an N-95 mask to protect others.


### Deadlines and Late Policy

Check the schedule to see your assignments. Check Gradescope to see the time of day that each assignment is due. Due times are typically as follows:

Readings
: 10:30 pm the day BEFORE it appears on the schedule  

Labs
: 10:30 pm on the next lab day (except around breaks)  

Coding Challenges
: 10:30 pm the day it appears as "due" on the schedule  

Misc
: 10:30 pm the day it appears on the schedule, OR, in class depending on the assignment

**Late Policy**

* You may turn in any lab or coding challenge up to 48 hours late, with the use of a token (all about tokens [here](../handouts/tokens.html)). There will be no penalty to your grade if you use a token. You do not need prior approval to take advantage of this grace period. Your instructor does appreciate knowing if you plan to turn in things late.
* If you believe you will need an extension of more than 48 hours, please talk with your instructor as soon as possible. Assignments turned in more than two days late, without prior approval (before the original due date) of the instructor will not be accepted.
* Our course will move quickly, therefore it is in your best interest to always follow the posted deadlines. 
* Please keep in mind that if you turn in work late, even using the grace period, we may not be able to grade it as quickly as you (or your instructors) hope.


### Redo and Revision Opportunities

We offer redo and revision opportunities because we believe that your final grade should reflect what you know at the end of the semester rather than mistakes made along the way. 

Here are redo/revision policies for each type of coursework:

Quizzes
: 
    * When you earn an N on an LO, you can attempt to demonstrate mastery on that LO again on a future quiz.  
    * The final exam slot will be the final quiz, allowing you to redo past LOs but does not introduce new LOs, ensuring that you get a minimum of 2 tries to earn an S on every LO.  

Coding Challenges
: 
    * You may revise and resubmit coding challenges after receiving feedback.  
        * You may submit at most **2 revisions** in each weeklong revision period (Sunday to Sunday).
	* A revision costs you 1 token (more information [here](../handouts/tokens)).
    * When revised work is graded, the new grade, if higher, replaces the old grade. Submitting revised work cannot lower your grade.  
    * To be eligible for resubmission, you must have completed the coding challenge in good faith on your first attempt, earning at least an R. Revision opportunities _cannot_ be used as a way to skip coding challenges and doing them later.
    * Resubmit a coding challenge in the revelant location on Gradescope. 

Reading responses, labs, and misc
: 
These are graded based on good faith engagement with the assigned questions and cannot be revised for credit.

## Access Needs

To ensure that your access needs are met, I encourage individual students to approach me so we can have a discussion about your distinctive learning needs and how to meet them within the context of this course. In addition, Grinnell College makes formal accommodations for students with documented disabilities. Students with disabilities partner with the [Office of Disability Resources](https://www.grinnell.edu/about/leadership/offices-services/accessibility-disability/students) to make academic accommodation letters available to faculty via the accommodation portal. You can reach Disability Resources staff via email at access@grinnell.edu, by phone 641-269-3089, or by stopping by their offices on the first floor of Steiner Hall.

## Title IX and Pregnancy Related Conditions

Grinnell College is committed to compliance with Title IX and to supporting the academic success of pregnant and parenting students and students with pregnancy related conditions. If you are a pregnant student, have pregnancy related conditions, or are a parenting student (child under one-year needs documented medical care) who wishes to request reasonable related supportive measures from the College under Title IX, please email the Title IX Coordinator at titleix@grinnell.edu. The Title IX Coordinator will work with Disability Resources and your professors to provide reasonable supportive measures in support of your education while pregnant or as a parent under Title IX.
