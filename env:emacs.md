% Emacs
%
%

Emacs is *the* modern open source Lisp IDE. Its history and quirks
extend back to the Lisp machines and early editors such as TECO.

It is considered difficult to initially learn, and often disparaged
due to the antiquated interface, but is generally thought the best open
source free IDE for Common Lisp.

In order to use emacs, there are two variants; XEmacs and GNU Emacs. I
usually use GNU emacs, so I'll talk about it here.

In order to get it, you can obtain it from the [GNU](
http://www.gnu.org/software/emacs/). Windows, Linux, and OSX versions
are available. It's also available via most Linux distributions
package repositories.  The most recent version is 24; 23 is also
recent and works well with the Superior Lisp Interaction Mode for
Emacs, a.k.a SLIME.

New users can find many resources online for Emacs, including a
well-written help system! An emacs tutorial can be found
[here](http://www.gnu.org/software/emacs/manual/html_mono/emacs.html),
and the GNU FAQ is also
[available](http://www.gnu.org/software/emacs/emacs-faq.text)

Usually you want to get SLIME installed for your development.

If you're using emacs23, SLIME can be found
[here](http://www.common-lisp.net/project/slime/).

Emacs24 has it in its package manager (`M-x package-list-packages`). However, I
have not had good experiences with the SLIME found in the Marmalade emacs repo.


I like to use the following elisp to configure SLIME:

```
(require 'cl)
(setq inferior-lisp-program  "/usr/local/bin/sbcl") ;modify to taste
(require 'slime)
(slime-setup '(slime-fancy))    ;adds some nice features

;; these give you unicode
(set-language-environment "UTF-8")
(setenv "LC_LOCALE" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
(setq slime-net-coding-system 'utf-8-unix)
```

Another useful trick is:

```
;; highlight parens
(require 'paren)
(show-paren-mode t)

```


Once you are set up...
----

When you load a Lisp file and want to engage SLIME, `M-x slime` will do
the trick.

Paredit is a popular Lisp editing mode that the engaged student will
hear about. The author recommends getting comfortable with emacs and
SLIME before using Paredit, it provides several automatic s-expression
editing features that surprised him on first use.

When you have configured your SLIME in a `fancy` fashion, you will find a SLIME
REPL (Read Evaluate Print Loop) buffer created in your Emacs window.

This provides an interactive view into Common Lisp. You can evaluate functions you
are writing in the source file and immediately use them in the REPL. This provides a
very fast "code and test" facility.
