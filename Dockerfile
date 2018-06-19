FROM gregnuj/cyclops-base:stretch

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
	
RUN add-apt-repository ppa:ondrej/php
	
# Install packages
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
    php5.6 \
    php5.6-common \
    php5.6-phar \
    composer \
    && rm -r /var/lib/apt/lists/*
