FROM gregnuj/cyclops-base:stretch

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
	
RUN apt install ca-certificates apt-transport-https \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
    && echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list 
	
# Install packages
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
    php5.6 \
    php5.6-common \
    php5.6-phar \
    composer \
    && rm -r /var/lib/apt/lists/*
