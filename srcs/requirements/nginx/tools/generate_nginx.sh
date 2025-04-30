#!/usr/bin/env sh

# Exit when error
set -e

# Variable
DOWNLOAD_DIR=./srcs/requirements/nginx/conf/rules
NGINX_FILE=default.conf
WP_DOCKERHOST=wordpress:9000

# Create string
NGINX_STR="server {\n"
NGINX_STR="${NGINX_STR}    listen 443 ssl;\n"
NGINX_STR="${NGINX_STR}    listen [::]:443 ssl;\n"
NGINX_STR="${NGINX_STR}    server_name ${DOMAIN_NAME};\n"
NGINX_STR="${NGINX_STR}\n"
NGINX_STR="${NGINX_STR}    ssl_protocols TLSv1.2 TLSv1.3;\n"
NGINX_STR="${NGINX_STR}    ssl_certificate /etc/nginx/ssl/server.crt;\n"
NGINX_STR="${NGINX_STR}    ssl_certificate_key /etc/nginx/ssl/server.key;\n"
NGINX_STR="${NGINX_STR}    ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305';\n"
NGINX_STR="${NGINX_STR}    ssl_prefer_server_ciphers on;\n"
NGINX_STR="${NGINX_STR}\n"
NGINX_STR="${NGINX_STR}    root /var/www/html;\n"
NGINX_STR="${NGINX_STR}    index index.php index.html index.htm;\n"
NGINX_STR="${NGINX_STR}\n"
NGINX_STR="${NGINX_STR}    location / {\n"
NGINX_STR="${NGINX_STR}        try_files \$uri \$uri/ /index.php?\$args;\n"
NGINX_STR="${NGINX_STR}    }\n"
NGINX_STR="${NGINX_STR}\n"
NGINX_STR="${NGINX_STR}    location ~ \.php$ {\n"
NGINX_STR="${NGINX_STR}        try_files \$uri =404;\n"
NGINX_STR="${NGINX_STR}        fastcgi_split_path_info ^(.+\.php)(/.+)\$;\n"
NGINX_STR="${NGINX_STR}        include fastcgi.conf;\n"
NGINX_STR="${NGINX_STR}        fastcgi_pass ${WP_DOCKERHOST};\n"
NGINX_STR="${NGINX_STR}        fastcgi_index index.php;\n"
NGINX_STR="${NGINX_STR}    }\n"
NGINX_STR="${NGINX_STR}\n"
NGINX_STR="${NGINX_STR}    location ~ /\.ht {\n"
NGINX_STR="${NGINX_STR}        deny all;\n"
NGINX_STR="${NGINX_STR}    }\n"
NGINX_STR="${NGINX_STR}}"

# Create file
echo -e "${NGINX_STR}" > $DOWNLOAD_DIR/$NGINX_FILE