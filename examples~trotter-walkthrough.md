% Trotter Walkthrough
%
%

The Trotter is an example web spider; it "trots" through a web page,
heuristically determining which links to follow and recursively
printing them.

The Trotter is designed to be a simple program to demonstrate what a
basic Common Lisp program looks like.

The raw file can be found at [web-trotter.lisp](src/web-trotter.lisp).

The first form in the code is loading the external libraries:


```Commonlisp
(ql:quickload '(:drakma
                :split-sequence
                :cl-ppcre
                :babel))
```

`DRAKMA` is the standard HTTP(S) client library in Lisp,
`SPLIT-SEQUENCE` does what you might think, `CL-PPCRE` is a
reimplementation of the PPCRE library in native Lisp (It's considered
one of the best modern CL libraries, go check the source out
sometime). `BABEL` is a encoding/decoding tool for strings. Note that
they are referred to here as "keywords".

The second form in the code defines a global that describes what an
URL looks like. Of course, it's not very precise, but it suffices for
our purpose. The key thing here is that `\` are doubled for the
special forms. This is part of the CL-PPCRE regex definition.

```Commonlisp
(defparameter *url-regex* "(\\w+://[-\\w\\./_?=%&]+)"
  "Hacked up regex suitable for demo purposes.")
```


Next, a predicate for HTTP. We really don't care about FTP, HTTPS,
GOPHER, GIT, etc protocols. It returns nil if it can't find http:// in
the URL.

```Commonlisp
(defun http-p (url)
  (cl-ppcre:all-matches "\\bhttp://" url))
```


Next, a predicate to check to see if our data is ASCII. While Common
Lisp can handle Unicode data, this is a sample program, and the
complexities of Unicode can be deferred.

```Commonlisp
(defun ascii-p (data)
  "A not terribly great way to determine if the data is ASCII"
  (unless (stringp data)
    (loop for elem across data do
         (when (> elem 127)
           (return-from ascii-p nil))))
  t)
```

Next, we have a *really sloppy* way to see if a URL is going to point
to a binary. It just looks for a binary file extension in the string.


```Commonlisp
(defun known-binary (url)
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
       (search ".tgz" url)))
```

The next form is the most complex: `find-links`.

`find-links` attempts to find all the links in a given url.

```Commonlisp

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

      #+sbcl(sb-int:simple-stream-error (se) (format t "Whoops, ~a didn't work. ~a~%" url se))
      (DRAKMA::DRAKMA-SIMPLE-ERROR (se) (format t "Error? ~a threw ~a~%" url se))
      (USOCKET:TIMEOUT-ERROR (se) (format t "timeout error ~a threw ~a~%" url se))
      (USOCKET:NS-HOST-NOT-FOUND-ERROR (se) (format t "host-not-found error ~a threw ~a~%" url se))
      (FLEXI-STREAMS:EXTERNAL-FORMAT-ENCODING-ERROR (se) (format t "~a threw ~a~%" url se)))))

```

The initial form is `WHEN` - a one-branch conditional. When we have a
http link and it's not a binary URL, then...

 `HANDLER-CASE` wraps some code. `HANDLER-CASE` is part of the Common
Lisp condition system; it serves as the "try" block in this
situation. The list of errors below form the "catch" blocks. The
interested reader is referred to [the quicklinks
section](quicklinks.html) for more resources. Note that the errors are
typical network errors- timeouts, stream errors, encoding errors.

The first form in `HANDLER-CASE` requests in the url and assigns it to
page.  Supposing we got something, we make sure it's an ascii page; if
so, we then find all the url-ish looking things, using the previously
defined global. Supposing that the page is, indeed, a string, we
return it, otherwise we convert the octets to a string and return
that. N.b.: Common Lisp makes a difference between strings and vectors
of bytes.  Of course, if an error occurred, the `HANDLER-CASE` will
route to the known conditions.

Note that in one case, `#+sbcl` is present; this is a Common Lisp
syntax to indicate that the following form is for SBCL only.