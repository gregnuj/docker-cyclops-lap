FROM gregnuj/cyclops-base:stretch

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
	
RUN apt install ca-certificates apt-transport-https \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add - \
    && echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list \	
	
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
