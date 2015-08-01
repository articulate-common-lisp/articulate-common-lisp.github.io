;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; cheese.lisp
;;;;
;;;; Example code for storing data to a database to "wrap" the data up.
;;;;
;;;; Author: Paul Nathan
;;;; License: AGPL3

;;; cheese.lisp provides a Lispy database layer to mongo and postgres.
(defpackage :cheese
  (:use :common-lisp)
  (:export))

(in-package :cheese)
