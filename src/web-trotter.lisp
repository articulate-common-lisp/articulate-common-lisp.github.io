;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; website-trotter.lisp
;;;;
;;;; License: AGPL3
;;;; Author: Paul Nathan
;;;;
;;;; Example code for a web spider. Doesn't handle unicode correctly.

(ql:quickload '(:drakma :split-sequence :cl-ppcre :babel))


(defparameter *url-regex* "(\\w+://[-\\w\\./_?=%&]+)"
  "Hacked up regex suitable for demo purposes.")

;; We can download http sites without issues. HTTPS may need to be
;; certified. FTP, Gopher, other URIs are not really in our purview.
(defun http-p (url)
  (cl-ppcre:all-matches "\\bhttp://" url))

(defun ascii-p (data)
  "A not terribly great way to determine if the data is ASCII"
  (unless (stringp data)
    (loop for elem across data do
	 (when (> elem 127)
	   (return-from ascii-p nil))))
  t)


(defun known-binary (url)
  "Given a URL, returns a truthy value if its a binary.

A poor way to determine if we want to go grab something for link
examination. Really needs to be a regex or a smart substring chop."
  (or (search ".png" url)
       (search ".bmp" url)
       (search ".jpg" url)
       (search ".exe" url)
       (search ".dmg" url)
       (search ".package" url)
       (search ".css" url)
       (search ".ico" url)
       (search ".gif" url)
       (search ".dtd" url)
       (search ".pdf" url)
       (search ".xml" url)
       (search ".tgz" url))
)

(defun find-links (url)
  "Scrapes links from a URL. Prints to STDOUT if an error is caught"
  (when (and (http-p url)
	     (not (known-binary url)))
    (handler-case
	(let ((page (drakma:http-request url)))
	  (when page
	    (when (ascii-p page)
	      (cl-ppcre:all-matches-as-strings
	       *url-regex*
	       (if (stringp page)
		   page
		   (babel:octets-to-string page))))))

      ;; errors...
      #+sbcl(sb-int:simple-stream-error (se)
	      (format t "Whoops, ~a didn't work. ~a~%" url se))
      (DRAKMA::DRAKMA-SIMPLE-ERROR (se)
	(format t "Error? ~a threw ~a~%" url se))
      (USOCKET:TIMEOUT-ERROR (se)
	(format t "timeout error ~a threw ~a~%" url se))
      (USOCKET:NS-HOST-NOT-FOUND-ERROR (se)
	(format t "host-not-found error ~a threw ~a~%" url se))
      (FLEXI-STREAMS:EXTERNAL-FORMAT-ENCODING-ERROR (se)
	(format t "~a threw ~a~%" url se)))))


(defun walk-page (top-url action depth)
  "BFS walk through the web, depth levels deep. Note that this *will*
eat memory."
  (let ((seen-list))
    (labels ((walker (url depth)
	       (unless (zerop depth)
		 (push url seen-list)
		 (dolist (link (find-links url))
		   (unless (member link seen-list :test #'string=)
		     (progn
		       (push link seen-list)
		       (funcall action link depth)
		       (walker link (1- depth))))))))
      (walker top-url depth))))

;; entry point
(defun run-trotter ()
  (walk-page "http://cliki.net/"
	     #'(lambda (url depth)
		 (format t "~a: ~a~%" depth url))
	     2))
