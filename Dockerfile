FROM gregnuj/cyclops-base:latest

LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"

# Install packages 
RUN set -ex \
  && apk add --no-cache \
  php7 \
  php7-common \
  php7-phar

# get composer from library/composer (uses alpine:3.7)
COPY --from=library/composer /usr/bin/composer /usr/bin/composer

# ensure www-data user exists
# 82 is the standard uid/gid for "www-data" in Alpine
RUN set -ex \
	&& addgroup -S -g 82 www-data \
	&& adduser  -S -u 82 -D -h /var/www -G www-data www-data
  
 USER www-data
 WORKDIR /var/www
 ENTRYPOINT ["/usr/bin/php"]
 CMD ["-a"]
