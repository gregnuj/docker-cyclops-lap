#!/bin/bash

export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"
export WEBCONSOLE_BASE=${WEBCONSOLE_BASE:-/var/www/html/webconsole}
export WEBCONSOLE_PHP=${WEBCONSOLE_PHP:-${WEBCONSOLE_BASE}/webconsole.php}

WEBCONSOLE_SECRET="${WEBCONSOLE_SECRET:-/var/run/secrets/app_password}"

if [ -n "${APP_PASSWD}" ]; then
	# Create webconsole secret if it does not exist
	if [ ! -f "${WEBCONSOLE_SECRET}" ]; then
		openssl rand -base64 10 > ${WEBCONSOLE_SECRET}
	fi
	APP_PASSWD="$(cat ${WEBCONSOLE_SECRET} | sha256sum | awk '{print $1}')"
fi

sed -i \
	-e "s/^\$USER = .*\$/\$USER = \"${APP_USER}\"/" \
	-e "s/^\$PASSWORD = .*\$/\$PASSWORD = \"${APP_PASSWD}\"/" \
	-e "s/^\$PASSWORD_HASH_ALGORITHM = .*\$/\$PASSWORD_HASH_ALGORITHM = \"sha256\"/" \
	${WEBCONSOLE_PHP}

# set/fix permissions for codiad
chown -R ${APP_USER}:${APP_GROUP} ${WEBCONSOLE_BASE}

