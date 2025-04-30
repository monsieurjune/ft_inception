#!/usr/bin/env bash

# Set to exit when cmd return non-zero
set -e

# Get env from credential file
set -a
. /run/secrets/credentials
set +a

# Set Variable
WORDPRESS_URL="https://${DOMAIN_NAME}"

# Create php directories
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

# Wait for db to work
sleep 10

# Change directory
cd /var/www/html

# Create wp-config.php
if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="$(cat ${WORDPRESS_DB_PASSWORD_FILE})" \
        --path=/var/www/html \
        --allow-root
fi

# Install wordpress
if ! wp core is-installed --allow-root --path="/var/www/html"; then
    wp core install \
        --url="${WORDPRESS_URL}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --skip-email \
        --path=/var/www/html \
        --allow-root
fi

# Start php-fpm & lighttpd
exec php-fpm82 --nodaemonize