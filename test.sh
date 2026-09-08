#!/bin/bash
# Serve the container image built by ./build.sh. Ctrl-C to stop.
#
#   ./test.sh              -> http://127.0.0.1:8080/
#   PORT=9090 ./test.sh
set -euo pipefail

IMAGE="${IMAGE:-pnathan/articulate-common-lisp:latest}"
PORT="${PORT:-8080}"

if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
    echo "error: image ${IMAGE} not found; run ./build.sh first" >&2
    exit 1
fi

tty_flags=()
if [ -t 0 ] && [ -t 1 ]; then
    tty_flags=(--interactive --tty)
fi

# Bound to loopback: this is a local test server, not something to expose.
exec docker run --rm "${tty_flags[@]}" \
     --publish "127.0.0.1:${PORT}:80" \
     "$IMAGE"
