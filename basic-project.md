Basic Project
===

We are going to assume that your first project is a small standalone
program using one of the common libraries for Common Lisp. Since
Common Lisp is a general purpose high-level programming langugage, it
can handle any common high-level language task.

Common libraries are installed using Quicklisp.

http://www.quicklisp.org/ Go over there and install it!


Let's assume for the purpose of the starting project that you want to
recursively walk a web server and take some action based upon the
internal contents. We've supplied a minimal (not very robust or
general) solution in "web-trotter.lisp", available from <url>.

Without examining the details of the Trotter, notice that there's a
line:

`(ql:quickload '(:drakma :split-sequence :cl-ppcre :babel))`


This tells Quicklisp to ensure that the libraries DRAKMA,
SPLIT-SEQUENCE, CL-PPCRE, and BABEL are loaded.

In your favorite IDE, load up web-trotter.lisp and execute
`(run-trotter)`. It'll wander around the CLIKI for a bit printing out
the names of URLS it could visit.

The Trotter is a basic web crawler; some further work could produce a
tool that would feed in the data to a database for searching.

Note that there is a lack of a main function. Lisp has no specified
MAIN, unlike Java or C.