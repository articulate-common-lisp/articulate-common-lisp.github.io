% Snippets
%
%

One of the great resources we can have as developers is snippets and
example code to understand how the idiom of a language is spoken and
written.



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

### Defining a class

~~~~Commonlisp
(defclass my-class (list-of-superclasses) 
  ((variable
      :accessor accessor-function
      :initarg  key-to-pass-in
      :initform form-initialization)
   Another-variable))
  (:documentation "a class snippet!"))
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

(loop for i from 0 upto 10
   do
      (side-effect i))

(loop for ele in list
   collect
      (operate-on ele))

(loop for ele in list
   collect
      (operate-on ele))
~~~~

### Lambda functions

The lambda functions is an anonymous function, i.e., unnamed.

Here we map over `numeric-list` and increment each element in it by 1
with `INCF`, returning the incremented list.

~~~~Commonlisp

(mapcar
   #'(lambda (x)
       (incf x))
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


