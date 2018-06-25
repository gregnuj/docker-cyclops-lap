FROM gregnuj/cyclops-php:stretch
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root
	
# Install packages
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
    node \
    && rm -r /var/lib/apt/lists/*

# www-data - 33 exists in base image  
USER www-data
WORKDIR /var/www
ENTRYPOINT ["/usr/bin/php"]
CMD ["-a"]
