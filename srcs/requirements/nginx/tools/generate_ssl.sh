#!/usr/bin/env sh

# Exit when error
set -e

# Variable
ALGORITHM=rsa:4096
DOWNLOAD_DIR=./srcs/requirements/nginx/conf/ssl
KEY_FILE="server.key"
CERT_FILE="server.crt"

# Subject
SUBJ="/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCALITY}/O=${SSL_COMPANY}/OU=${SSL_DEPARTMENT}/CN=${DOMAIN_NAME}"

# Create ssl
openssl \
    req -x509 -nodes \
    -days $SSL_DAY_AGE \
    -newkey $ALGORITHM \
    -keyout $DOWNLOAD_DIR/$KEY_FILE \
    -out $DOWNLOAD_DIR/$CERT_FILE \
    -subj $SUBJ