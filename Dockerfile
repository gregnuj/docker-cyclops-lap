FROM gregnuj/cyclops-base:alpine3.7
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
    php7-simplexml \
    php7-snmp \
    php7-soap \
    php7-sockets \
    php7-ssh2 \
    php7-tokenizer \
    php7-xdebug \
    php7-xml \
    php7-xmlwriter \
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
  
# add files in rootfs
ADD ./rootfs /

# add www-data user
RUN set -ex \
    && chmod 755 /usr/local/bin/httpd-foreground \
    && adduser -u 82 -D -S -G www-data www-data \
    && chown -R www-data:www-data /var/www \
    && ln -s /var/www/localhost/htdocs /var/www/html \
    && sed -i \
    -e's/#LoadModule rewrite_module/LoadModule rewrite_module/' \
    -e 's/^User apache/User www-data/' \
    -e 's/^Group apache/Group www-data/' \
    /etc/apache2/httpd.conf \
    && mkdir /run/apache2 

# add Codiad and web console
RUN set -ex \
    && git clone https://github.com/Codiad/Codiad /var/www/html/codiad \
    && wget https://github.com/nickola/web-console/releases/download/v0.9.7/webconsole-0.9.7.zip  \
    && unzip webconsole-0.9.7.zip -d /var/www/html
             
WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-n"]
