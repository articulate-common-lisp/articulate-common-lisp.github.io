# The old base, davazp/quicksbcl, was Debian wheezy; its apt repos now 404 and
# the image build had been failing for years. clfoundation/sbcl is the Common
# Lisp Foundation's maintained image, pinned here so the build stays stable.
FROM clfoundation/sbcl:2.6.1-bookworm

# libssl-dev: cl+ssl, reached through hunchentoot's dependency graph.
# ca-certificates, curl: fetch Quicklisp over TLS.
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        ca-certificates \
        curl \
        libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Quicklisp is not part of the base image. Install it and load it from the
# init file, which is what source/main.lisp's top-level ql:quickload needs.
RUN curl -fsSL -o /tmp/quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp \
    && sbcl --non-interactive \
            --load /tmp/quicklisp.lisp \
            --eval '(quicklisp-quickstart:install)' \
    && echo '(load "/root/quicklisp/setup.lisp")' >> /root/.sbclrc \
    && rm /tmp/quicklisp.lisp

# Pre-load the runtime dependencies so container startup needs no network.
RUN sbcl --non-interactive --eval '(ql:quickload (list :hunchentoot :local-time))'

COPY source/ /opt/articulate-common-lisp/www/
COPY _site/  /opt/articulate-common-lisp/www/static/

EXPOSE 80
CMD ["sbcl", "--load", "/opt/articulate-common-lisp/www/main.lisp", \
     "--eval", "(start)", "--non-interactive"]
