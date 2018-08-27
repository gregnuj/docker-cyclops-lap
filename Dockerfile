FROM gregnuj/cyclops-base:stretch
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root
	
# Install packages 
RUN set -ex \ 
    && apt-get update \
    && apt-get install -y \
    php7.2 \
    php7.2-common \
    php7.2-curl \
    php7.2-intl \
    php7.2-json \
    php7.2-memcached \
    #php7.2-mcrypt \
    php7.2-mbstring \
    php7.2-mysqli \
    php7.2-odbc \
    php-pear \
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
    #php7.2-pdo_odbc \
    php7.2-sqlite3 \
    php7.2-sybase \
    php7.2-mysql \ 
    php7.2-pgsql \ 
    apache2 \
    composer \
    && rm -r /var/lib/apt/lists/*

# add files in rootfs
ADD ./rootfs /

# add www-data user
RUN set -ex \
    && chown -R www-data:www-data /var/www \
    && ln -s /var/www/localhost/htdocs /var/www/html \
    && mkdir /run/apache2 \
    && a2enmod rewrite

# env variables for entrypoint scripts
ENV \
    # defaults to $PWD/$APP_NAME
    PROJECT_DIR="" \
    # GIT URL to clone
    PROJECT_GIT_URL="" \
    # GIT BRANCH to clone
    PROJECT_GIT_BRANCH="master" \
    # install codiad
    CODIAD_INSTALL="" \
    # install dbninja
    ADMINER_INSTALL="" \
    # install webconsole
    WEBCONSOLE_INSTALL=""


EXPOSE 22 80 443 9001
VOLUME ["/var/www/html"]
WORKDIR "/var/www/html"
CMD ["/usr/bin/supervisord", "-n"]
