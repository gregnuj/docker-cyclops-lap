FROM gregnuj/cyclops-base:stretch

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
	
# Install packages
RUN set -ex \
	&& apt-get update \
	&& apt-get install -y \
  php7.2 \
  php7.2-common \
  php7.2-phar \
  composer \
  --no-install-recommends \
	&& rm -r /var/lib/apt/lists/*
