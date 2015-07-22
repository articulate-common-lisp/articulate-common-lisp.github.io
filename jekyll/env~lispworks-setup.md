% LispWorks
%
%

Lispworks is a popular commercial Lisp system, sold by LispWorks Ltd.

The Personal version is free for personal use and has several
limitations. However, the author has had a reasonably good experience
with the LispWorks IDE and recommends it for new learners who are from
the GUI side of life (Of course, this should not be taken to denigrate
other Lisp IDEs such as Allegro, just the author's personal experience).

Installation is reasonably simple - navigate to
[LispWorks Personal Edition](http://www.lispworks.com/downloads/),
fill out the form, and download it.

It installs in the usual way for an OSX or Windows application.

The user is recommended to review the LispWorks manual for operation of
the system.

Notes
---

I've found that Lispwork's Personal 6.0 doesn't appear to respect the
Lispworks init file, so the init file (used for Quicklisp) has to be
loaded manually with the form `(LOAD "~/.lispworks")`. I'm not sure
why this happens, but I wish it wouldn't!
