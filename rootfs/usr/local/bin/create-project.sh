#!/bin/bash

# similar to composer --create-project
# but does not require git vcs config in advance

set -x

git config --global user.name "${APP_USER}"
git config --global user.email "${APP_EMAIL}"

PROJECT_DIR="${PROJECT_DIR:-$(pwd)/${APP_NAME}}"
PROJECT_GIT_URL="${PROJECT_GIT_URL}"
PROJECT_GIT_BRANCH="${PROJECT_GIT_BRANCH:-master}"

if [ -n "$PROJECT_GIT_URL" ]; then
	# sleep random amount to avoid collision
	sleep $(( $RANDOM % 3 +  $RANDOM % 5 ))
	if [ ! "$(ls -A ${PROJECT_DIR})" ]; then
		git clone -b "$PROJECT_GIT_BRANCH" "$PROJECT_GIT_URL" "$PROJECT_DIR"
	fi
	if [ -f "./composer.json" ]; then
		composer update
	fi
fi

