FROM gregnuj/cyclops-base:stretch
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# apt https
RUN set -ex \
    && apt-get update \
    && apt-get install -y \	
    apt-transport-https \
    && rm -r /var/lib/apt/lists/*
	
RUN set -ex \
    && curl -sS https://packages.sury.org/php/apt.gpg > /etc/apt/trusted.gpg.d/php.gpg \
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

# www-data - 33 exists in base image  
USER www-data
WORKDIR /var/www
ENTRYPOINT ["/usr/bin/php"]
CMD ["-a"]
