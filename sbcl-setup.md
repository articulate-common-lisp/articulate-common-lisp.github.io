% Initial Environment Setup
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


Installing on Windows
---
Dear Windows SBCL user, please tell us how it's done!


IDE configuration
---
Please see the IDE help page!
