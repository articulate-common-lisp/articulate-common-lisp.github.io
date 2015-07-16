#!/bin/bash -e
make
docker build -t pnathan/articulate-common-lisp:latest .
