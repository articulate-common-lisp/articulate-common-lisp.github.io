hacking on articulate-common-lisp
---

contributions welcome.

* ./livetest.sh will spawn a localhost:4000 webserver which watches the filesystem
* ./build.sh will generate a Docker image ready for pushing
* ./test.sh will run the build.sh generated Docker image. Note that
  this boots a nginx server.
* ACL is delivered as a Docker image
