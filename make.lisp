(ql:quickload '(:cl-ppcre
                :external-program
                :osicat
                :alexandria
                :split-sequence))

(use-package :cl-ppcre)


(defun generate-command (fn)
  (list "-B" "banner.html"
    "-B" "content-begin.html"
    "-A" "begin-footer.html"
    "-A" "content-footer.html"
    "-A" "version.html"
    "-A" "end-footer.html"
    "-A" "quantcast.html"
    "-A" "footer-js.html"
    "-T" "Articulate Common Lisp"
    "--template=pandoc-data/templates/default.html5"
    "--ascii"
    "--smart"
    "--normalize"
    "--highlight-style=haddock"
    "-f" "markdown"
    "-t" "html5"
    (format nil "~a.md" fn)
    "-o" (format nil "site/~a.html" fn)))


(defun build-git-hash-file ()
  (let ((hash (first
               (split-sequence:split-sequence
                #\Space
                (with-output-to-string (s)
                  (external-program:run "git"  '("show" "-s" "--oneline")
                                        :output s))))))
    (with-open-file (stream
                     "version.html"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
      (format stream
              "~&<div>~%
<center style=\"font-size=x-small; color:lightgrey\">
 ~%version: ~a~%
</center>~%
</div>" hash))))

(defun determine-name (fn)
  (subseq fn (1+ (position #\~ fn))))

(defun build-banner (active-filename file-list)
  (let ((initial-html
    "<div class=\"navbar navbar-inverse navbar-fixed-top\">
      <div class=\"navbar-inner\">
        <div class=\"container\">
          <a class=\"btn btn-navbar\" data-toggle=\"collapse\" data-target=\".nav-collapse\">
            <span class=\"icon-bar\"></span>
            <span class=\"icon-bar\"></span>
            <span class=\"icon-bar\"></span>
          </a>
          <a class=\"brand\" href=\"index.html\">articulate-lisp.com</a>
          <div class=\"nav-collapse collapse\">
            <ul class=\"nav\">")
        (final-html
"
            </ul>
          </div>
        </div>
      </div>
    </div>")

        (kinds (find-dropdowns file-list)))

    (let ((dropdowns (first kinds))     ; hash table
          (no-dropdowns (second kinds))
          (toplevel "<li ~a><a href=\"~a.html\">~a</a></li>~%"))

      (format
       nil
       "~{~a~%~^~}"
       (remove
        nil
        (append
         (list initial-html)
         (remove nil
                 (loop for file in no-dropdowns
                       collect
                       (if (string= file active-filename)
                         (format nil toplevel "class=\"active\"" file file)
                         (format nil toplevel "" file file))))
         (when (> (hash-table-count  dropdowns) 0)

           (loop for toplevel in (alexandria:hash-table-keys dropdowns)
                nconc
                (append
                 (list (format nil
                               "<li class=\"dropdown\">
                <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"> ~a
                <b class=\"caret\"></b></a>
                <ul class=\"dropdown-menu\">" toplevel))
                 (loop for filename in (gethash toplevel dropdowns)
                       collect
                       (let ((html-filename (format nil "./~a:~a.html" toplevel filename)))
                         (format nil "<li><a href=\"~a\">~a</a></li>" html-filename filename)))
                 (list
                  (format nil "~%</ul>~%</li>~%")))))
         (list final-html)))))))

(defun find-dropdowns (prefix-list)
  (let ((dropdown-table (make-hash-table :test #'equal))
        (no-dropdown (list)))

    (loop for filename in prefix-list
          do
             (if (position #\~ filename)
                 (let ((tuple (split-sequence:split-sequence #\~ filename)))
                   (setf (gethash (first tuple) dropdown-table (list))
                         (append
                          (gethash (first tuple) dropdown-table (list))
                          (list (second tuple)))))
                 (push filename no-dropdown)))
    (list dropdown-table no-dropdown)))

(defun ls ()
  (mapcar
   #'(lambda (s)
       ;; trim the ./ off.
       (subseq (namestring s) 2))
   (osicat:list-directory ".")))

(defun find-file-prefixes (path-list)
  (remove nil
          (mapcar
           #'(lambda (path)
               (let ((candidate-value
                       (multiple-value-bind
                           (filename part)
                           (cl-ppcre:scan-to-strings "\(\.+\).md$" path)
                         part)))
                 (when candidate-value
                   (aref candidate-value 0))))
           path-list)))

(defun find-markdowns (path-list)
  (remove nil
          (mapcar
           #'(lambda (path)
                       (multiple-value-bind
                           (filename part)
                           (cl-ppcre:scan-to-strings "\(\.+\).md$" path)
                         filename))
           path-list)))

(defun build-a-file(filename)
  (with-open-file (stream
                   "banner.html"
                   :direction :output
                   :if-exists :supersede
                   :if-does-not-exist :create)
    (write-sequence (build-banner filename (find-file-prefixes (ls)))
                    stream))

  (external-program:run
   "pandoc"
   (generate-command filename)))


(defun build-files ()
  (build-git-hash-file)
  (loop for file in (find-file-prefixes (ls))
        do
           (format t "~&articulating ~a into the final form...~&" file)
           (build-a-file file))
  (when (find :unix *features*)
    (dolist (file (find-markdowns (ls)))
      (external-program:run "cp" (list file
                                       (cl-ppcre:regex-replace-all
                                        "~"
                                        file
                                        ":")) )))
  (format t "~&final reticulation...~&")
  (external-program:run "cp" '("-r" "src" "site/") ))
