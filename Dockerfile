FROM gregnuj/cyclops-base:edge
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apk add --no-cache \
    php7 \
    php7-apache2 \
    php7-common \
    php7-curl \
    php7-intl \
    php7-json \
    php7-memcached \
    php7-mcrypt \
    php7-mbstring \
    php7-mysqli \
    php7-odbc \
    php7-pear \
    php7-phar \
    php7-redis \
    php7-snmp \
    php7-soap \
    php7-sockets \
    php7-ssh2 \
    php7-xdebug \
    php7-xml \
    php7-xsl \
    php7-zip \
    php7-pdo \
    php7-pdo_odbc \
    php7-pdo_sqlite \
    php7-pdo_dblib \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    apache2

# get composer from library/composer (uses alpine:3.7)
COPY --from=library/composer /usr/bin/composer /usr/bin/composer
  
# add apache supervisord config
COPY supervisord-apache2.conf /etc/supervisor.d/default.ini
 
# add www-data user
RUN set -ex \
    && adduser -u 82 -D -S -G www-data www-data  

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord -n"]
