#!/bin/bash
# host:guest port map.
docker run --label=jekyll --label=stable --volume=$(pwd):/srv/jekyll -t -p 127.0.0.1:4000:4000 jekyll/jekyll jekyll build

docker build -t pnathan/articulate-common-lisp:latest .
