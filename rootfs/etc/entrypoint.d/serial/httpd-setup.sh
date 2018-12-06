#!/bin/bash

export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"
export HTTPD_PORT="${HTTPD_PORT:-80}"
export HTDOCS_DIR="${HTDOCS_DIR:-/var/www/html}"
export HTTPD_USER="${APP_USER}"
export HTTPD_GROUP="${APP_GROUP}"

sed -i \
    -e "s/#LoadModule rewrite_module/LoadModule rewrite_module/" \
    -e "s/^User .*/User ${HTTPD_USER}/" \
    -e "s/^Group .*/Group ${HTTPD_GROUP}/" \
    -e "s/^Listen .*/Listen ${HTTPD_PORT}/" \
    -e "s/AllowOverride None/AllowOverride All/" \
/etc/apache2/httpd.conf 

if [ -f /etc/apache/envvars ]; then
    sed -i \
        -e "s/USER=www-data/USER=${HTTPD_USER}/" \
        -e "s/GROUP=www-data/GROUP=${HTTPD_GROUP}/" \
    /etc/apache2/envvars 
fi

# set/fix permissions for htdocs
chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${HTDOCS_DIR}
