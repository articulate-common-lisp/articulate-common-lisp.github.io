.PHONY: all

all:
	sbcl --non-interactive  --load make.lisp --eval '(build-files)'
