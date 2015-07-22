#!/bin/bash
docker run --label=jekyll --label=stable --volume=$(pwd):/srv/jekyll -t -p 127.0.0.1:4000:4000 jekyll/stable jekyll s --baseurl=''
