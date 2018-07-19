#!/bin/bash

export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"

sed -i \
    -e's/#LoadModule rewrite_module/LoadModule rewrite_module/' \
    -e 's/^User .*/User ${APP_USER}/' \
    -e 's/^Group .*/Group ${APP_USER}/' \
    /etc/apache2/httpd.conf 
