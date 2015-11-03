from davazp/quicksbcl
run apt-get update
run apt-get install -y libssl-dev
expose 80

run sbcl --eval '(ql:update-all-dists :prompt nil)'  --eval '(ql:quickload :hunchentoot)'  --eval '(ql:quickload :local-time)' --non-interactive

copy source/ /opt/articulate-common-lisp/www
copy _site/ /opt/articulate-common-lisp/www/static

cmd sbcl --load /opt/articulate-common-lisp/www/main.lisp --eval '(start)' --non-interactive
