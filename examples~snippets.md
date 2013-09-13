% Snippets
%
%

One of the great resources we can have as developers is snippets and
example code to understand how the idiom of a language is spoken and
written.



### Defining a function:

~~~~Commonlisp
(defun function-name (param1 param2 &key (keyword1 default-value))
    ;; keywords are optional; optional positional parameters are also available. 
    ;; implicit progn
  )
~~~~

### Defining a method on a type:


~~~~Commonlisp
(defmethod method-name ((param1 class-name))
   ;; implicit progn
  )
~~~~

### Defining a class


Note that `DEFCLASS` accessor functions for slots can be `SETF`'d and serve as both getters and setters for the slot.

`:INITARG` is the keyword used in `MAKE-INSTANCE` to denote the value of the initial argument (see below).

`:INITFORM` is the form used to initialize the slot. Without this, it defaults to `nil`. I favor using `nil`, `0`, `""`, or 
`(error "You must set slot <slotname> to a value")` as the usual initform set.

Note that `(:documentation ...)` is the standard documentation mechanism, which can be viewed in the running image with 
`DESCRIBE` (at least in SBCL).

~~~~Commonlisp

;; no superclass, no slots.
(defclass superclass-1 nil nil)

(defclass my-class (superclass-1) 
  ((variable
      :accessor accessor-function
      :initarg  :variable
      :initform form-for-initializition.)
   another-variable)
  (:documentation "a class snippet!"))
~~~~



### Creating an instance

~~~~Commonlisp
(make-instance 'my-class :variable value)
~~~~


### Adding a constructor 

This function runs after the instance is initialized.

~~~~Commonlisp
(defmethod initialize-instance :after ((obj my-class) &key)
  (setf (accessor-function obj) 10))
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

### LOOP

LOOP is a contentious form in Common Lisp: some people love its
imperative style, others hate it. Regardless, its really handy! Here
are my favorite LOOPs

~~~~Commonlisp

(loop for i from 0 upto 10
   collect i)
   
(loop for i from 0 below 10
   collect i)

(loop for i from 0 upto 10
   do
      (side-effect i))

(loop for ele in list
   collect
      (operate-on ele))

(loop for ele across array
   collect
      (operate-on ele))
~~~~

### Lambda functions

The lambda functions is an anonymous function, i.e., unnamed.

Here we map over `numeric-list` and increment each element in it by 1
with `1+`, returning the incremented list.

~~~~Commonlisp

(mapcar
   #'(lambda (x)
       (1+ x))
   numeric-list)

~~~~

### Macro

Note that Lisp macros should be used with care: they read source code
and emit source code.

~~~~Commonlisp
(defmacro with-resource ((resource) &body body)
   (allocate-resource ,resource)
   (unwind-protect
      (progn
         ,@body)
      (deallocate-resource ,resource)))
~~~~

See [UNWIND-PROTECT](http://www.lispworks.com/documentation/HyperSpec/Body/s_unwind.htm)
for details on this very useful form.

### Writing a text file

More complete reading and writing of text files can be done by using the ALEXANDRIA library; these
routines are great for starting to customize your own routine.

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


