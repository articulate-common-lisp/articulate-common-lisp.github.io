% New Projects
%
%


Here's a short guide on what you should do for a single project.

# One-file project, no dependencies


A one-file project has these characteristics:

- Simple
- Usually presented in Lisp textbooks
- Usually not  realistic.



#One file project, uses libraries

- Small system.
- Relatively common
- An example is the [web-trotter](src/web-trotter.lisp) program.


# Introduction to ASDF

ASDF, also known as Another System Definition Facility, is the modern
way for defining Common Lisp libaries. It is fully supported by
Quicklisp, and supports adding your own private libraries.


ASDF depends on two things:

* ASDF configured to know where this repository is; here's a
  configuration from one of my SBCL init files, specifying that the ASDF repository lives in the `~/asdf/` folder.

```Commonlisp
(pushnew "~/asdf/" asdf:*central-registry* :test #'equal)
```

* Repository for local libraries with the `ASD` files symlinked in: here's a example of a ls of my repository:

```
$ ls -1 ~/asdf
batteries.asd
cl-finance-query.asd
cl-yahoo-finance-query.asd
defobject.asd
```

  `ASD` files are ASDF library definition files.


Here is a copy of the contents a library's ASD file:

```Commonlisp

(asdf:defsystem #:cl-yahoo-finance
  :depends-on ( #:drakma #:babel #:cl-csv #:yason #:url-rewrite)
  :components ((:file "cl-yahoo-finance"))
  :name "cl-yahoo-finance"
  :version "3.3"
  :maintainer "Paul Nathan"
  :author "Paul Nathan"
  :licence "LLGPL"
  :description "CL interface to Yahoo's finance API"
  :long-description "Common Lisp interface to Yahoo's finance API, available over the web. See usage.lisp for example code.")
```

Briefly, it defines an ASDF system named `:cl-yahoo-finance`, along
with its dependencies, components, and some human metadata. This
integrates with Quicklisp such that I can `(ql:quickload
:cl-yahoo-finance` and have it load.



# One file library project

- Will export ASDF dependencies
- Will be usable by Quicklisp

# Multifile project.

- ASDF heavily used
- Quicklisp heavily used
- Packages, Systems, O My
