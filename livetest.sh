#!/bin/bash
# Serve the site locally with live regeneration. Ctrl-C to stop.
#
#   ./livetest.sh          -> http://127.0.0.1:4000/
#   PORT=4001 ./livetest.sh
#
# Requires docker.
set -euo pipefail

# Pinned: an unpinned tag silently changed Jekyll under us (see issue #76).
# Override for a one-off: JEKYLL_IMAGE=jekyll/jekyll:latest ./livetest.sh
JEKYLL_IMAGE="${JEKYLL_IMAGE:-jekyll/jekyll:4.4.1}"
PORT="${PORT:-4000}"

# Run from the script's own directory, so invoking it from elsewhere works.
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# SELinux hosts (Fedora, RHEL) deny the bind mount without a relabel.
mount_flag=""
if command -v getenforce >/dev/null 2>&1 && [ "$(getenforce)" = "Enforcing" ]; then
    mount_flag=":z"
fi

# Only ask for a TTY when we have one, so this still works non-interactively.
tty_flags=()
if [ -t 0 ] && [ -t 1 ]; then
    tty_flags=(--interactive --tty)
fi

# --host 0.0.0.0: jekyll otherwise binds loopback *inside* the container,
#   which the published port cannot reach. This was half of issue #76.
# --force_polling: inotify does not fire reliably across a bind mount.
# --user: keeps _site/ owned by you rather than root.
# GIT_CONFIG_*: lets _plugins/jekyll-git-hash.rb run git against the mount
#   without needing a writable HOME for `git config --global`.
exec docker run --rm "${tty_flags[@]}" \
     --label=jekyll \
     --user "$(id -u):$(id -g)" \
     --volume "${repo}:/srv/jekyll${mount_flag}" \
     --publish "127.0.0.1:${PORT}:4000" \
     --env GIT_CONFIG_COUNT=1 \
     --env GIT_CONFIG_KEY_0=safe.directory \
     --env GIT_CONFIG_VALUE_0=/srv/jekyll \
     "$JEKYLL_IMAGE" \
     jekyll serve --host 0.0.0.0 --force_polling
