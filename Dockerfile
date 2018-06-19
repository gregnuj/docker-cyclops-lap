FROM gregnuj/cyclops-base:apline3.7

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"

# Install packages
RUN set -ex \
  && apk add --no-cache \
  php7 \
  php7-common \
  php7-phar

# get composer from library/composer (uses alpine:3.7)
COPY --from=library/composer /usr/bin/composer /usr/bin/composer
