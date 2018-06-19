FROM gregnuj/cyclops-base:stretch

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
	
RUN set -ex \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list
	
# Install packages
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
    php7.2 \
    php7.2-common \
    php7.2-phar \
    composer \
    && rm -r /var/lib/apt/lists/*
