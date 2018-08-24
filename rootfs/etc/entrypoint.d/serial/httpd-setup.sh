#!/bin/bash

export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"
export HTTPD_PORT="${HTTPD_PORT:-80}"
export HTDOCS_DIR="${HTDOCS_DIR:-/var/www/html}"

# httpd user
if [ "$APP_USER" == "root" ]; then
    export HTTPD_USER="www-data"
    export HTTPD_GROUP="www-data"
else
    export HTTPD_USER="${APP_USER}"
    export HTTPD_GROUP="${APP_GROUP}"
fi


sed -i \
    -e "s/#LoadModule rewrite_module/LoadModule rewrite_module/" \
    -e "s/^User .*/User ${HTTPD_USER}/" \
    -e "s/^Group .*/Group ${HTTPD_GROUP}/" \
    -e "s/^Listen .*/Listen ${HTTPD_PORT}/" \
    -e "s/AllowOverride None/AllowOverride All/" \
    /etc/apache2/httpd.conf 

# set/fix permissions for htdocs
chown -R ${HTTPD_USER}:${HTTPD_GROUP} $(readlink ${HTDOCS_DIR})
