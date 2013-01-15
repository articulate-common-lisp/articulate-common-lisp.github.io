% Quicklisp
%
%

[Quicklisp](http://www.quicklisp.org/beta/) is *the* package
management system for Common Lisp.

* To install Quicklisp, download quicklisp.lisp. Load up your
  [SBCL](sbcl-setup.html) instance like so, `sbcl --load
  quicklisp.lisp`, and follow the on-screen instructions. If you are
  behind a proxy, use (quicklisp-quickstart:install :proxy
  "http://your-proxy-here:1337"), of course replacing the proxy information
  with your site proxy information.

* Then, after the installation finishes, before you exit SBCL, run
  `(ql:add-to-init-file)`.


The list of available packages is the [Quicklisp Releases list](http://www.quicklisp.org/beta/releases.html).
