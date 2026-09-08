#!/bin/bash
# Build the static site into _site/, then bake it into the container image.
#
#   ./build.sh
#
# Requires docker. Run ./test.sh afterwards to serve the built image.
set -euo pipefail

JEKYLL_IMAGE="${JEKYLL_IMAGE:-jekyll/jekyll:4.4.1}"
IMAGE="${IMAGE:-pnathan/articulate-common-lisp:latest}"

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mount_flag=""
if command -v getenforce >/dev/null 2>&1 && [ "$(getenforce)" = "Enforcing" ]; then
    mount_flag=":z"
fi

# set -e above matters here: the image bakes in _site/, so a failed site build
# must not fall through to `docker build` and ship stale or missing content.
echo "==> building site into _site/"
docker run --rm \
       --label=jekyll \
       --user "$(id -u):$(id -g)" \
       --volume "${repo}:/srv/jekyll${mount_flag}" \
       --env GIT_CONFIG_COUNT=1 \
       --env GIT_CONFIG_KEY_0=safe.directory \
       --env GIT_CONFIG_VALUE_0=/srv/jekyll \
       "$JEKYLL_IMAGE" \
       jekyll build --trace

if [ ! -f "${repo}/_site/index.html" ]; then
    echo "error: _site/index.html missing after build; refusing to build image" >&2
    exit 1
fi

echo "==> building image ${IMAGE}"
docker build -t "$IMAGE" "$repo"
echo "==> done. Serve it with ./test.sh"
