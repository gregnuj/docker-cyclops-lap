FROM gregnuj/cyclops-base:apline3.7

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"

# Install packages
RUN set -ex \
  && apk add --no-cache \
  php7 \
  php7-common
