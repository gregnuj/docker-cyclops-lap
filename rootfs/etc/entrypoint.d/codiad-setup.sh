#!/bin/bash

# may need to set these
export APP_USER="${APP_USER:-cyclops}"
export PROJECT_DIR="${PROJECT_DIR:-$(pwd)/${APP_NAME}}"
export CODIAD_BASE="${CODIAD_BASE:-/var/www/html/codiad}"
export CODIAD_DATA="${CODIAD_DATA:-${CODIAD_BASE}/data}"

# settings files
CODIAD_SECRET="${CODIAD_SECRET:-/var/run/secrets/app_password}"
CODIAD_PROJECTS="${CODIAD_PROJECTS:-${CODIAD_DATA}/projects.php}"
CODIAD_SETTINGS="${CODIAD_SETTINGS:-${CODIAD_DATA}/settings.php}"
CODIAD_USERS="${CODIAD_USERS:-${CODIAD_DATA}/users.php}"


# populate projects
if [ ! -f "${CODIAD_PROJECTS}" ]; then
	echo "<?php /*|[{\"name\":\"inventory\",\"path\":\"${PROJECT_DIR}\"}]|*/ ?>" > ${CODIAD_PROJECTS}
fi

# populate settings
if [ ! -f "${CODIAD_SETTINGS}" ]; then
	echo "<?php /*|{\"${APP_USER}\":{\"codiad.username\":\"${APP_USER}\"}}|*/ ?>" > ${CODIAD_SETTINGS}
fi

# populate users
if [ ! -f "${CODIAD_USERS}" ]; then
	# set variable for use in CODIAD_USERS
	if [ -n "${APP_PASSWD}" ]; then
		# Create codiad secret if it does not exist
		if [ ! -f "${CODIAD_SECRET}" ]; then
			openssl rand -base64 10 > ${CODIAD_SECRET}
		fi
		APP_PASSWD="$(cat ${CODIAD_SECRET} | md5sum | awk '{print $1}')"
		APP_PASSWD="$(echo -n "${APP_PASSWD}" | sha1sum | awk '{print $1}')"
	fi
	echo "<?php /*|[{\"username\":\"${APP_USER}\",\"password\":\"${APP_PASSWD}\",\"project\":\"${PROJECT_DIR}\"}]|*/ ?>" > ${CODIAD_USERS}
fi
