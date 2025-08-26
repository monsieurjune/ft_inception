#!/usr/bin/env bash

# Exit when error
set -e

# Variable
DOWNLOAD_DIR=./srcs/requirements/wordpress/tools/
WORDPRESS_CLI_LINK=https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
WORDPRESS_CLI_FILE=wp-cli.phar

# Download wp-cli
if [ ! -f "${DOWNLOAD_DIR}/${WORDPRESS_CLI_FILE}" ]; then
    curl -o ${DOWNLOAD_DIR}/${WORDPRESS_CLI_FILE} ${WORDPRESS_CLI_LINK}
fi
