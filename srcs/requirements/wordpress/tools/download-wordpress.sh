#!/usr/bin/env sh

# Exit when error
set -e

# Variable
DOWNLOAD_DIR=./srcs/requirements/wordpress/tools/
WORDPRESS_LINK=https://wordpress.org/wordpress-6.8.tar.gz
WORDPRESS_FILE=wordpress.tar.gz

# Exit when error
set -e

# Download Wordpress 6.8
if [ ! -f "${DOWNLOAD_DIR}/${WORDPRESS_FILE}" ]; then
    wget ${WORDPRESS_LINK} -O ${DOWNLOAD_DIR}/${WORDPRESS_FILE}
fi

# Extract file
if [ ! -d "${DOWNLOAD_DIR}/wordpress" ]; then
    tar -xzvf ${DOWNLOAD_DIR}/${WORDPRESS_FILE} -C ${DOWNLOAD_DIR}
fi