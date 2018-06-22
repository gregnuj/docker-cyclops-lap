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
    apache2 \
    php7.2 \
    php7.2-common \
    php7.2-curl \
    php7.2-intl \
    php7.2-json \
    php7.2-memcached \
    #php7.2-mcrypt \ deprecated
    php7.2-mbstring \
    php7.2-mysqli \
    php7.2-odbc \
    php-pear \
    php7.2-phar \
    php7.2-redis \
    php7.2-snmp \
    php7.2-soap \
    php7.2-sockets \
    php7.2-ssh2 \
    php7.2-xdebug \
    php7.2-xml \
    php7.2-xsl \
    php7.2-zip \
    php7.2-pdo \
    php7.2-sqlite3 \
    php7.2-sybase \
    php7.2-mysql \ 
    php7.2-pgsql \ 
    composer \
    && rm -r /var/lib/apt/lists/*

# www-data - 33 exists in base image  
USER www-data
WORKDIR /var/www
ENTRYPOINT ["/usr/bin/php"]
CMD ["-a"]
