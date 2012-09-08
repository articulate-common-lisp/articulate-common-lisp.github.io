;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; website-trotter.lisp
;;;;
;;;; License: AGPL3
;;;; Author: Paul Nathan
;;;;
;;;; Example code to walk a website.

(ql:quickload '(:drakma :split-sequence))

(defun find-links (url)
  )

(defun walk-page (url action)
  (dolist (link (find-links url))
    (funcall action url)
    (walk-page url action)))

(defun run-trotter ()
  )
