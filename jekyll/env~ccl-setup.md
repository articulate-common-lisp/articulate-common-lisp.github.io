% Clozure CL Setup
%
%

Clozure is an open source Lisp system provided by Clozure associates.

Installing
---

I'll defer to their instructions for
[installation](http://ccl.clozure.com/download.html).

Of particular interest is that it works on the PPC and ARM architectures; this
can be of use to embedded system developers. It is possible to get
[CCL working on the Raspberry Pi](http://lispm.dyndns.org/ccl), for instance.

CCL is particularly well-developed on Mac OS X, including a Cocoa bridge and an
IDE. It's also a good choice on Windows as it supports native (Win32) threads.

In general, like SBCL, it's designed to be used as the backend to an IDE.

Note that each platform has a *different* CCL executable.

* Linux: lx86cl, lx86cl64

* OSX:

* Windows: wx86cl.exe, wx86cl64.exe


Linedit
---

A CLI tool called linedit is useful.


```Commonlisp
(ql:quickload :linedit)
(require :linedit)
(funcall (intern "INSTALL-REPL" :linedit) :wrap-current t)
```

Notes
---

CCL, in general, is very fast to load and has a good reputation for
performance.
