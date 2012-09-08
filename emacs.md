EMACS
====

Emacs is the modern open source Lisp IDE. Its history and quirks
extend back to the Lisp machines and early editors such as TECO.

It is considered difficult to initially learn, and often disparaged
due to the antiquated interface, but is generally the best open source
free IDE for CL.

Usually you want to get SLIME installed for emacs, available at
http://www.common-lisp.net/project/slime/.

A few enhancements are usually good to make for maximum usefulness:xs

(setq inferior-lisp-program  "/usr/local/bin/sbcl") ;modify to taste
(require 'slime)
(slime-setup '(slime-fancy) 	;adds some nice features

;; these give you unicode
(set-language-environment "UTF-8")
(setenv "LC_LOCALE" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
(setq slime-net-coding-system 'utf-8-unix)


Another useful trick is:
;; highlight parens
(require 'paren)
(show-paren-mode t)

Once you are set up...

When you load a Lisp file and want to engage SLIME, M-x slime will do
the trick.

Paredit is a popular Lisp editing mode that the engaged student will
hear about. The author recommends getting comfortable with emacs and
SLIME before using Paredit, it provides several automatic s-exp
editing features that surprised him on first use.