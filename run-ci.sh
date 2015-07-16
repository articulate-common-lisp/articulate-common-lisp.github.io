#!/usr/local/bin/sbcl

(require "sb-posix")

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(defparameter *pwd* (concatenate 'string (sb-posix:getcwd) "/"))

(push *pwd* asdf:*central-registry*)

(load "make.lisp")
(build-files)
