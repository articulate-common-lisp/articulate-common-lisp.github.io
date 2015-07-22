% SLIME
%
%

One of Lisp's biggest contributions to the world of software
development is the idea of an interactive development environment. 
This was later taken up by other languages (Smalltalk et al) and continues
to make inroads today. 

In this tutorial we'll assume that you've configured your Lisp
environment correctly and now are trying to write Lisp code
(Congratulations)!


Let's say that you have your `emacs` and `SLIME` set up. Then, open a
file and load our SLIME - run `M-x slime` when the file is opened.
This will create a REPL buffer for you associated to the file.

Here's a function to put in the file (or write your own):

```Commonlisp
(defun heads (&rest lists)
  "Gets the first elements of the lists"
  (mapcar #'car lists))
```

Then place the cursor in the function and keyboard in the combination
`C-cC-c`.

In my REPL window the annotation `; compiling (DEFUN HEADS ...)`
appears. We then can run `heads` and see its output, just as if we had
written heads on the prompt.

Not only that, the SLIME REPL offers lookup of symbol completion based
upon what exists in the Lisp image: typing `hea` and then `TAB` in the
REPL will attempt to complete heads (or present you with a list of
possible completions).

I frequently use `M-x slime-eval-buffer` to reload everything in my
file (just checking to ensure that it works correctly).

Let's invert this and use our actual file as a sort of REPL. Put an
invocation of `heads` in your source file and run `C-xC-e` - this
actually evaluates the form and outputs the result to the
minibuffer. If you instead run `C-cC-j`, SLIME copies the form into
the REPL and executes it. And, if you run `M-x
slime-eval-print-last-expression`, then the expression will be
evaluated and printed out into your executing buffer. This is very
handy for scratch calculations and [experimentation](1).

If you're working with large amounts of data, then the dynamic
variables at global scope `*print-length*` and `*print-depth*` are
very handy. When set to `nil`, then the length and recursive depth of
data objects are printed to infinite length and depth; when given an
integer, the Common Lisp printer obeys that integer as a limit on the
length and depth of the printing.


[1] P.s., an elisp snippet to make that command easier is:

```elisp
(define-key slime-mode-map
    "\C-x\C-j"
    'slime-eval-print-last-expression)
```
