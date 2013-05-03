% SBCL Setup
%
%

Steel Bank Common Lisp (SBCL) is aggressively maintained with releases
approximately monthly as of 2012. SBCL has a long history, with its
source code stretching back to the early '80s under different
systems. This tutorial recommends SBCL due to its popularity at the time
of writing. Other opens source systems such as ECL, CLISP, CMUCL, and
CCL exist.

Installing on Linux and OSX
---

Linux is the "home OS" of SBCL. The installation procedure also works
the same easy for OSX. Typically the best way to start is to download
the binary from [SBCL](http://www.sbcl.org) and install it.

The procedure for installing it on your system runs as so:

```
tar xjf <sbcl-binary>
cd sbcl-<version-name>
sudo sh ./install.sh
```

After that, execute sbcl at the command line and you should find the
REPL! Congratulations!

SBCL's REPL is designed to be used in an environment such as
emacs' SLIME interface. Check the IDE help page for more information.

Linedit
---

The tool Linedit should provide some reasonable CLI capabilities for
users.

In order to load it into SBCL, copy and paste the following snippet:

```Commonlisp
(progn
 (ql:quickload :linedit)
 (require :sb-aclrepl)
 (require :linedit)
 (funcall (intern "INSTALL-REPL" :linedit) :wrap-current t))
```

Installing on Windows
---
Dear Windows SBCL user, please tell us how it's done!


Further installation on Linux/OSX
---
Sometimes the SBCL you pick up from sbcl.org isn't as feature-complete 
as you want, or perhaps you want to recompile it for your own reasons 
(i.e., the Hunchentoot web server requires threads).

In order to do this, download the *source* SBCL package and issue this 
set of commands:

```Bash
sh ./make.sh --fancy
pushd doc/manual/ && make && popd
sudo sh ./install.sh
```

* --fancy builds with several optional features as of 1.1.3: 
  :sb-core-compression :sb-xref-for-internals :sb-after-xc-core, plus 
  threading on supported platforms.

* For platforms with very limited memory, --dynamic-space-size=<MB> 
  can help ensure that you don't blow the internal Lisp heap.
