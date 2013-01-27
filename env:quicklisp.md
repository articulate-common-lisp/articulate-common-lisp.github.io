% Quicklisp
%
%

[Quicklisp](http://www.quicklisp.org/beta/) is *the* package
management system for Common Lisp.

* Initially, download quicklisp.lisp to a directory.

* To install Quicklisp on SBCL, load up your [SBCL](env:sbcl-setup.html)
  instance, loading Quicklisp with this command: `sbcl --load
  quicklisp.lisp`, and follow the on-screen instructions.

* To install Quicklisp on CCL, load up your [CCL](env:ccl-setup.html)
  instance, loading Quicklisp with this command, `$ccl -l
  quicklisp.lisp`

* If you are behind a proxy, use (quicklisp-quickstart:install :proxy
  "http://your-proxy-here:1337"), of course replacing the proxy
  information with your site proxy information.

* Then, after the installation finishes, before you exit, run
  `(ql:add-to-init-file)`.


The list of available packages is the [Quicklisp Releases
list](http://www.quicklisp.org/beta/releases.html).

Note that on LispWorks Personal Edition 6.1, Quicklisp does not load
from the init file by default: run a `(LOAD "~/.lispworks")` form on
the REPL on initial bootup.
