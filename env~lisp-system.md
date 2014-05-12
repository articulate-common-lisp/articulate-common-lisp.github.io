% Choosing Your Lisp
%
%

Common Lisp implementations usually are called "systems", and there
are a number for the expert to choose from; I recommend **[SBCL](http://sbcl.org)**
for new users.  Read on for more detail.

Open Source
---

In general, Lisp systems are designed around a front end to do
development with.  However, without an IDE, usually the best usability
is to use a system with working arrow keys in the terminal. The author
has investigated the *CCL* and *SBCL* systems using a plugin called
Linedit; this should provide a ramp-up experience.

Using emacs as an IDE and [SBCL](http://sbcl.org) (Steel Bank Common
Lisp) is the most popular choice at this point in time for open source
development. Other common systems are CCL (Clozure Common Lisp),
CLISP, ABCL (Armed Bear Common Lisp) and ECL (Embeddable Common
Lisp). Less common systems exist. This author recommends _SBCL_ or
_CCL_ for beginners who are comfortable on the command line, but would
like to point out that each Lisp system provides value within the
general Common Lisp ecosystem.


Commercial
---

LispWorks and Allegro Common Lisp are the currently maintained commercial
implementations with IDEs. They provide free
limited-functionality personal editions. This author has
had good experiences with LispWorks Personal Edition; it has limitations
on its use, however.

Mobile developers may find [mocl](https://wukix.com/mocl) a very
interesting product in this space; it is a recently (2013) released
Common Lisp system designed for interoperation with the base systems.

Tabulation  of systems
---

Name  Base   Notes
----  ----   -------
SBCL  Native High speed compiler
 CCL  Native High speed compiler, good on OSX and Windows
 LW   Native Professional platform
 ACL  Native Professional platform
ABCL  JVM    Java interop
 ECL  C      C interop, has iOS port
MOCL  Native Stores CL as a library for mobile devices - iOS & Android
