.PHONY: all

all: sbcl

sbcl:
        sbcl --non-interactive  --load make.lisp --eval '(build-files)'

ccl:
        lx86cl64 -l make.lisp  -e '(build-files)'
