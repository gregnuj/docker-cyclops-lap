#!/bin/bash

# Exit unles intall requested
if [ -z ${WEBCONSOLE_INSTALL} ]; then
	exit 0
fi

# globals
export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"
export WEBCONSOLE_BASE="${WEBCONSOLE_BASE:-/var/www/html/}"
export WEBCONSOLE_DIR="${WEBCONSOLE_DIR:-${WEBCONSOLE_BASE}/webconsole}"
export WEBCONSOLE_PHP="${WEBCONSOLE_PHP:-${WEBCONSOLE_DIR}/webconsole.php}"
export http_proxy="${http_proxy:-${HTTP_PROXY}}"
export https_proxy="${https_proxy:-${HTTPS_PROXY}}"

# locals
WEBCONSOLE_ZIP="webconsole-0.9.7.zip"
WEBCONSOLE_URL="https://github.com/nickola/web-console/releases/download/v0.9.7/${WEBCONSOLE_ZIP}"
WEBCONSOLE_SECRET="${WEBCONSOLE_SECRET:-/var/run/secrets/app_password}"

# Install if needed
if [ ! -e "${WEBCONSOLE_DIR}" ]; then
    wget ${WEBCONSOLE_URL}
    unzip ${WEBCONSOLE_ZIP} -d ${WEBCONSOLE_BASE}
    rm ${WEBCONSOLE_ZIP}
fi

# Get weconsole password 
if [ -z "${APP_PASSWD}" ]; then
	# Create webconsole secret if it does not exist
	if [ ! -f "${WEBCONSOLE_SECRET}" ]; then
		openssl rand -base64 10 > ${WEBCONSOLE_SECRET}
	fi
	APP_PASSWD="$(cat ${WEBCONSOLE_SECRET} | sha256sum | awk '{print $1}')"
fi

# Set weconsole user/password 
sed -i \
	-e "s/^\$USER = .*\$/\$USER = \"${APP_USER}\";/" \
	-e "s/^\$PASSWORD = .*\$/\$PASSWORD = \"${APP_PASSWD}\";/" \
	-e "s/^\$PASSWORD_HASH_ALGORITHM = .*\$/\$PASSWORD_HASH_ALGORITHM = \"sha256\";/" \
	${WEBCONSOLE_PHP}

if [ ! -f "${WEBCONSOLE_BASE}/.htaccess" ]; then
	echo "RewriteEngine On" > "${WEBCONSOLE_BASE}/.htaccess"
	echo "RewriteRule ^webconsole.* webconsole/webconsole.php [L,NC]" >> "${WEBCONSOLE_BASE}/.htaccess"
fi


# set/fix permissions for webconsole
chown -R ${APP_USER}:${APP_GROUP} ${WEBCONSOLE_DIR}

