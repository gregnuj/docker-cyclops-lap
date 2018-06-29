FROM gregnuj/cyclops-base:stretch
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root
	
# Install packages 
RUN set -ex \ 
    && curl -sS https://packages.sury.org/php/apt.gpg > /etc/apt/trusted.gpg.d/php.gpg \
    && echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y \
    php7.2 \
    php7.2-apache2 \
    php7.2-common \
    php7.2-curl \
    php7.2-intl \
    php7.2-json \
    php7.2-memcached \
    php7.2-mcrypt \
    php7.2-mbstring \
    php7.2-mysqli \
    php7.2-odbc \
    php7.2-pear \
    php7.2-phar \
    php7.2-redis \
    php7.2-simplexml \
    php7.2-snmp \
    php7.2-soap \
    php7.2-sockets \
    php7.2-ssh2 \
    php7.2-tokenizer \
    php7.2-xdebug \
    php7.2-xml \
    php7.2-xmlwriter \
    php7.2-xsl \
    php7.2-zip \
    php7.2-pdo \
    php7.2-pdo_odbc \
    php7.2-pdo_sqlite \
    php7.2-pdo_dblib \
    php7.2-pdo_mysql \
    php7.2-pdo_pgsql \
    apache2 \
    composer \
    && rm -r /var/lib/apt/lists/*

# add apache supervisord config 
COPY supervisord-default /etc/supervisor/conf.d/default.conf
  
# add apache supervisord config
COPY httpd-foreground /usr/local/bin/httpd-foreground

# add www-data user
RUN set -ex \
    && ln -s /var/www/localhost/htdocs /var/www/html \
    && chmod 755 /usr/local/bin/httpd-foreground 

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-n"]
