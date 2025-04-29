#!/usr/bin/env sh

# Exit when error
set -e

# Variable
ALGORITHM=rsa:4096
DOWNLOAD_DIR=./srcs/requirements/nginx/conf/ssl
KEY_FILE="${DOMAIN_NAME}.key"
CERT_FILE="${DOMAIN_NAME}.crt"

# Subject
SUBJ="/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCALITY}/O=${SSL_COMPANY}/OU=${SSL_DEPARTMENT}/CN=${DOMAIN_NAME}"

# Create ssl
openssl \
    req -x509 -nodes \
    -month $SSL_MONTH_AGE \
    -newkey $ALGORITHM \
    -keyout $DOWNLOAD_DIR/$KEY_FILE \
    -out $DOWNLOAD_DIR/$CERT_FILE \
    -subj $SUBJ