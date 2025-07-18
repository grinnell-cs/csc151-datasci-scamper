---
title: Getting started with GNU/Linux
summary: |
  This laboratory reviews some mechanics related to the use of the Computer
  Science GNU/Linux Network for CSC 151.
link: true
---

## Introduction

This lab gives you the opportunity to explore (or at least configure):

* Logging In
* The Xfce window environment
* Firefox
* Working with multiple desktops
* Finishing up and logging out 

*Please don't be intimidated!* Although this lab contains many details
which may seem overwhelming at first, these mechanics will become familiar
rather quickly.  Feel free to talk to the instructor or with a CS tutor
if you have questions or want additional help!

## Logging in

### Short version

* On the computer in front of you, you should see a small window that asks 
  you to log in.  If you don't see such a window, try hitting a key on the
  keyboard or clicking the power button on the monitor.
* Enter your user name.  Press the <kbd>Enter</kbd> key.
* Enter your password (which won't appear on the screen).  Press the
  <kbd>Enter</kbd> key.
* Get help if those previous two steps don't work.

### Detailed version

To use any of the computers on Grinnell's GNU/Linux network, one
must *log in*, identifying oneself by giving a *user name* and a
*password*.  MathLAN workstations are configured to use the same
username and password as other Grinnell services. If you do not
know your Grinnell username or password please tell the instructor
soon; we will need to contact ITS to reset your account information.

When a GNU/Linux workstation is not in use, it will display a *login
screen* with a space into which one can type one's user name and,
later, one's password.  (If the workstation's monitor is dark, move
the *mouse* a bit and the login screen will appear.) This window
belongs to xdm, the Xwindows Display Manager.  Now, move the pointer
onto any part of the box containing the login box. Type in your
user name, in lower-case letters, and press the <kbd>Enter</kbd>
key. The login screen will be redrawn to acknowledge your user name
and to ask for your password; type it into the space provided and
press <kbd>Enter</kbd>. (Because no one else should see your password,
it is not displayed on screen as you type it.)

At this point, a computer program that is running on the workstation
contacts the College's authentication server to validate the user
name and password.  If it does not find the particular combination
that you have supplied, it prints a brief message saying that the
attempt to log in was unsuccessful and then returns to the login
screen -- inviting you to try again. Consult the instructor or the
system administrator if your attempts to log in are still unsuccessful.
(Make sure that you don't have any spaces before your username; that's
one of the most common errors.)

## The Xfce window environment

### Short version

* You'll see something that looks somewhat like Microsoft Windows, but also somewhat different.
* Icons at the bottom of the screen can be used to start programs.

### Detailed version

Once you have logged in, a _panel_ will appear at the bottom of the
screen. Some other windows also may be visible in other parts of
your screen. All of these areas are managed by a special program,
called a _window manager_. On our network, login chores and other
administrivia are handled by a program or _operating system_, called
GNU/Linux, and the primary user interaction is handled by a window
manager (GUI), called Xfce.

## Firefox

### Short version

* Start Firefox by clicking on the picture of the small red creature grasping a blue sphere.  If Firefox doesn't work, feel free to use Chrome.
* Agree to any dialog boxes that appear. They shouldn't appear again.
  You also may not see any dialog boxes.
* Navigate to the course website, available at <{{ site.url }}>.

### Detailed version

While some materials for this course will be available in paper, almost
everything for this course (including electronic versions of paper materials)
will be available on the internet. To use Firefox to view materials, such as
this course's syllabus and this lab, you may follow these steps:

Click the Firefox icon on the panel, next to the Applications menu. The
Firefox icon is a small red creature (presumably a fox) holding a bluish sphere.

If you do not see the Firefox icon, then move the pointer onto the
**Applications Menu** icon at the bottom left of the panel (in Xfce,
it looks like a creature on a blue X) and click once with the left mouse
button. The applications menu will pop up. Move the mouse over **Internet**,
then **Firefox**.  Click the left mouse button once to launch Firefox.

Some students have discovered that Firefox doesn't launch.  If that
happens, it may be that the launcher references the wrong version
of Firefox.  Ask one of the class staff to change the launcher
from `firefox-esr %u` to just `firefox`.  Or just do it yourself.

The materials for this course will walk you through using the Firefox
web browser, but a version of Google Chrome is available on MathLAN
workstations as well in the Applications menu under the *Internet*
section. You can add this browser your panel if
you prefer.  (You can add something to your panel by dragging it
from the menu to the panel.)

The first time you run Firefox on our network, two message boxes *might* appear.

* One box might ask you to consent to the terms of a licensing agreement.
* One box might request permission to create some configuration files in your home directory.

You should approve of any requests by clicking on the appropriate
word. The pop-up boxes then disappear; you should not see them on
subsequent uses of Firefox.  It's also okay if the boxes don't appear;
Firefox's behavior keeps changing.

Initially, Firefox displays a document containing some default
information. You should navigate to the course website at <{{ site.url }}>.

We expect that most of you are already familiar with a Web browser. If not,
please consult with one of us or with one of your colleagues.

### Firefox options

#### Short version

* Click on the menu icon (a set of three lines) in the upper-right-hand corner of the screen.
* Click on the **Settings** menu. 
* Click on **Home**.
* Next to "Homepage and new windows", click on **Firefox Home (Default)**.
* Select **Custom URLs...**.
* Update your home page to something reasonable like this course's website at or [the Grinnell Office365 page](https://office365.grinnell.edu).
* Quit and restart Firefox to verify that your new home page appears. If you see something other than your home page (e.g., the Grinnell College home page), then ask for help.

#### Detailed version

Each GNU/Linux user can configure Firefox to reflect her, his, zir, or
their own preferences. Between logins, these preferences are stored in
a file in the user's home directory; when Firefox is started during
a later session, they are reinstated from that file.

Every user of Firefox in this class should establish a base page, a
starting point for browsing. Here are the _Uniform Resource Locators_
or URLs of some good choices:

* The main page for this course: <{{ site.url }}>
* The computer science department website: <https://www.cs.grinnell.edu>
* Grinnell College's main page: <https://www.grinnell.edu>
* Grinnell's Office365 website: <https://office365.grinnell.edu>
* GrinnellShare: <https://grinco.sharepoint.com>
* A page you create.

To establish your base page within Firefox, bring up the primary
Firefox menu from the menu bar by clicking on the icon with three
lines in the upper-right-hand corner of the window. Then select the
**Settings** operation. You should then see a new screen that permits
you to configure many aspects of Firefox.  Click the **Home** button
on the left.  In the home settings screen, you should see a section
labeled **New Windows and Tabs**, the first entry of which is
"Homepage and new windows".  Click on **Firefox Home (Default)**.
Select **Custom URLs...**.  Paste in one of the recommended URLs.
(This does not have to be a permanent change; you can change your
mind about this configuration at any time within Firefox.)

To erase the current contents of the Home Page Location(s) box,
move the mouse pointer to the left of the first character in the
box, press the left mouse button and hold it down, and drag the
mouse pointer rightwards until the entire URL is displayed in
_reverse video_, white letters on a black background. Then release
the left mouse button and type the new URL; the old one will vanish
as soon as you start typing. Once you have entered the new URL,
move the mouse pointer onto the button marked OK at the bottom of
the pop-up window and click on it with the left mouse button.

You can, of course, simply navigate to the page you want to use as
your home page and then click on **Use Current Pages**.

You may note that the button says "Pages" (plural) rather than "Page"
(singular). Since Firefox permits tabbed browsing (that is, you can have
"tabs" within the same window that you switch between), you can have a
home set of tabs. Particularly obsessive people might want to set up a
sequence of tabs with say, links to labs, readings, and beyond.

Note that some folks have a default launcher for Firefox that is
configured to start the web browser on a specific page, regardless
of the home page you choose. If you don't see your new home page
when you restart Firefox, then ask for help.

## Working with multiple desktops

If you've kept all those windows open, you'll notice your screen is
getting a bit crowded. Fortunately, a tool called the _workspace switcher_
lets you uncrowd your windows by moving them among multiple desktops.

### Short version

* Find the workspace switcher icon in the workspace toolbar.
* Click on the switcher to move to a different desktop.
* Drag windows within the switcher to move them to other desktops.

### Detailed version

In the toolbar at the bottom of the screen, you should see an icon that
looks like a box containing four smaller boxes. (If you don't see it,
ask for help.) This is the _workspace switcher_, a tool that lets you
keep your application windows on several different desktops or workspaces.

The upper-left-hand box represents the desktop you are working on right
now. It contains a number of still smaller boxes of varying shapes and
sizes, which represent the windows you have open. When you move or resize
the a window on the desktop, you should see the window's representation
in the switcher move as well. Give it a try by wiggling one of your
windows around.

Now, click in one of the other three boxes. You should see a new,
blank desktop with no windows on it. Where did they go? If you look
at the switcher, you'll see they are still in the desktop you started
on. Switch back to that desktop.

You can also use the switcher to move windows from one desktop to
another. Find the switcher again and identify the box that corresponds
to your Firefox window. Click that box and drag it a little ways to
the right, onto the next desktop. The window should disappear from the
first desktop. If you click onto the desktop to the right, you should
see it there.

In this class, you'll usually need to work with multiple windows: The
DrRacket window for your programs, a terminal window or two, and a Web
browser to read the laboratory exercises and reference materials. As
you get settled in over the next few weeks, consider how you might use
the switcher to help you organize your workspace efficiently.

By default, the workspace switcher presents four workspaces arranged
in two rows of two each. If you want to change this configuration,
right-click on the workspace switcher and select Properties to change
the number of rows. Clicking on **Workspace settings...** will let you
change the number of workspaces.

***Caution:*** If you use the mouse scroll wheel while your cursor is over the
empty desktop area, you will switch workspaces. This sometimes alarms students
as it appears to have closed all of your running applications. You can switch
back to the correct workspace by clicking in the workspace switcher. If this
bothers you, you may want to reduce the number of workspaces to just one.

## Finishing up and logging out

If you've successfully logged in, started Firefox, selected your home page,
tried DrRacket, configured your account, and played with multiple desktops,
you've completed the lab and you can _finally_ stop.

### Short version

* To log out, click on the icon at the lower right corner of the screen, 
  and select **Log Out**.
* Do _not_ turn off the monitor or computers.

### Detailed version

When you are done using a workstation, you must _log out_ in order to allow
other people to use it. To log out, move the pointer onto your username, at the
lower right corner of the screen, and click the left mouse button. A menu will
pop up giving several options. Move the pointer onto the words Log Out at the
bottom of the menu and click the left mouse button. A _confirmation dialog_
will appear, giving you 30 seconds to change your mind. Click the Log out to
log out immediately. The Xfce window manager vanishes, and after a few seconds
the login screen reappears; this confirms that you're really logged out.

Please do _not_ turn off the workstation when you are finished. The GNU/Linux
workstations are designed to operate continuously; turning them off and on
frequently actually shortens their life expectancy. Modern computers use very
little power when they are sitting idle, so this is not a significant waste of
resources.

