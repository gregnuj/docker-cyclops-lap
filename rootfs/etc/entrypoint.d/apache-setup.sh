#!/bin/bash

export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"
export APACHE_PORT="${APACHE_PORT:-80}"
export HTDOCS_DIR="${HTDOCS_DIR:-/var/www/html}"

sed -i \
    -e's/#LoadModule rewrite_module/LoadModule rewrite_module/' \
    -e 's/^User .*/User ${APP_USER}/' \
    -e 's/^Group .*/Group ${APP_USER}/' \
    -e 's/^Listen .*/Listen ${APACHE_PORT}/' \
    -e 's/AllowOverride None/AllowOverride All/' \
    /etc/apache2/httpd.conf 

# set/fix permissions for htdocs
chown -R ${APP_USER}:${APP_GROUP} $(readlink ${HTDOCS_DIR})
