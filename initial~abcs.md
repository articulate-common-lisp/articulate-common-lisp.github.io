% ABCs of Lisp
%
%

This file summarizes a few of the key concepts of working with Common
Lisp and some common nomenclature. It also gives you a quick and easy
set of "template" copy and paste forms for early use.

## Concepts and Comments

Common Lisp (let's just call it Lisp for the rest of the file) is
designed around the idea of having a *REPL* (read evaluate print loop).

Typically, what occurs is the Lisper injects *forms* (the text between
parentheses) from the editor into the REPL directly. E.g., in the
author's emacs configuration, `C-x e` evaluates the text in the buffer
in the operating Lisp instance, immediately available for inspection
and testing. This is in strong contrast to languages like C where a
recompile of the project/file is required to check correctness of the
code.

It is also feasible to develop in a more traditional style, where
there is an edit/compile/revise cycle based upon files. In order to do
that, use the LOAD form from the repl or the particular system's
automatic load command-line option. `(LOAD "lispfile.lisp")`.

Modern Lisp systems commonly provide on-the-fly compilation of the
forms entered into it. This will slow down the boot process if the
compilation happens every time; interpreted programs will run slower
but boot faster. One common deployment strategy involves saving a
preloaded *image* and executing it on demand.


Most Lisp work is done within the Emacs/SLIME mileau; however,
IDE's like LispWorks or Allegro Common Lisp offer similar
functionality.

Typically the Lisp forms such as `LET`, `DEFUN`, and
`MULTIPLE-VALUE-BIND` contain something known as an "implicit
progn". The implicit progn denotes a list of commands in a block
structure (see
[PROGN](http://www.lispworks.com/documentation/lw61/CLHS/Body/s_progn.htm)
for details). However, `IF` does not have this, which routinely is a
gotcha to the author.

Common Lisp contains a macro facility - `DEFMACRO`. Generally, newbies
are not advised to write their own macros, as they are powerful and
can cause unexpected results.

When setting a variable, use SETF, not SETQ or SET. Those commands
operate at a lower level of abstraction and are not designed for
everyday use.

## Standard packages.

Some of these packages are community-recognized standards; others are
simply the best the author has found. All are available on Quicklisp..

* Alexandria - a library of standard common functions.

* bordeaux-threads - a os threading library.

* drakma - http client

* cl-ppcre - regular expression library

* yason - a json reader

* closer-mop - a library for managing metaobjects

* metabang-bind - a more sophisticated LET

* anaphora - standard package of exotic macros

* babel - management of text encodings

* osicat - operating-system interface routines

* external-program - runs external programs.

* ironclad - encryption

* cl-csv - csv-parsing

* local-time - datetime library

* lhstats - statistics library

* log4cl - a logging library

* postmodern - postgres integration

* wu-decimal - decimal management

* split-sequence - splitting sequences

Popular libraries that the author have not used include:

* iterate - a "more lispy" loop facility.

* log5 - a log facility

* parentscript - a CL -> javascript emitter

* lparallel  - a library for parallel programming

* usocket - TCP socket libary


## Snippets

Common templates for modifying to your needs.

### Defining a function:

~~~~Commonlisp
(defun function-name (param1 param2 &key (keyword1 default-value))
    ;; implicit progn
  )
~~~~

### Defining a method on a type:


~~~~Commonlisp
(defmethod method-name ((object class-name)
   ;; implicit progn
  )
~~~~


### Defining a constant:

Note that the convention is that constants are surrounded with +

```Commonlisp
(defconstant +name+ value "docstring")
```

### Defining a global variable:

Note that the convention is that globals are surrounded with *

~~~~Commonlisp
(defparameter *name* value "docstring")
~~~~


### Creating local variables.

~~~~Commonlisp
(let ((variable1 value-form)
      (variable2 value-again))
  ;; implicit progn where variable[12] are valid
   )

~~~~

### Writing a text file


```Commonlisp
(defun write-file (filename data)
 (with-open-file (stream
                    filename
                    :direction :output
                    :if-exists :supersede
                    :if-does-not-exist :create)
    (write-sequence
         data
         stream)))
```

### Reading a text file

```Commonlisp

(defun read-file (filename)
  "Reads `filename` as a sequence of unsigned 8-bit bytes, no
encoding"
  (with-open-file (fin filename
                   :direction :input
                   :if-does-not-exist :error)
    (let ((seq (make-array (file-length fin)
                           :fill-pointer t)))
      (setf (fill-pointer seq)
            (read-sequence seq fin))
      seq)))

```

Please feel free to contribute your examples or library information to
this page! Send in those pull requests and file those bugs!
