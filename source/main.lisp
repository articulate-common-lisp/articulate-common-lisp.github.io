(ql:quickload '( :hunchentoot :local-time))

(defvar *acceptor* nil "the hunchentoot acceptor")
(format t "Articulating Common Lisp...~%")

(hunchentoot:define-easy-handler (release :uri "/api/release/") ()
    (setf (hunchentoot:content-type*) "text/plain")
  (format t "A release of articulate-common-lisp is present!")
  (with-open-file (stream "/tmp/articulate-common-lisp.release" :direction :output :if-exists :overwrite :if-does-not-exist :create)
    (format stream "begin release @ ~a" (local-time:now)))
  "Release acknowledged. Grimoires under consultation.")

(defun start(&optional (fake-daemon t) &key (path nil) (port 80))
  (format t "Starting web server...~%")

  (setf hunchentoot:*dispatch-table*
        (append
         hunchentoot:*dispatch-table*
         (list
          (hunchentoot:create-static-file-dispatcher-and-handler
           "/" (if path
                   (concatenate 'string path "/index.html")
                   #p"/opt/articulate-common-lisp/www/static/index.html"))
          (hunchentoot:create-folder-dispatcher-and-handler
           "/"
           (if path
               path
               #p"/opt/articulate-common-lisp/www/static/")))))

  (setf *acceptor* (make-instance 'hunchentoot:easy-acceptor :port port))
  (hunchentoot:start *acceptor*)

  (when fake-daemon
    (loop while t
          do
             (format t "~&~a - heartbeat...~%" (local-time:now))
             (sleep 5))))
