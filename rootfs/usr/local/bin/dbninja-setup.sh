#!/bin/bash

# Exit unless install requested
if [ -z ${DBNINJA_INSTALL} ]; then
	exit 0
fi

# locals
DBNINJA_BASE="${DBNINJA_BASE:-/var/www/html/}"
DBNINJA_DIR="${DBNINJA_DIR:-${DBNINJA_BASE}/dbninja}"
DBNINJA_URL="https://www.dbninja.com/download/dbninja.tar.gz"


# Install if needed
if [ -z "${DBNINJA_DIR}" ]; then
    cd ${DBNINJA_BASE}
    curl -sS "${DBNINJA_URL}" | tar xz
fi

# set/fix permissions for dbninja
chown -R ${APP_USER}:${APP_GROUP} ${DBNINJA_DIR}

