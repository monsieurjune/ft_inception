#!/usr/bin/env sh

# Exit when error
set -e

# Read user input
echo "============== CREATE ENV ================"
printf "%s" "DOMAIN_NAME [default: localhost]: "; read DOMAIN_NAME
printf "%s" "MYSQL_DATABASE [default: db]: "; read MYSQL_DATABASE
printf "%s" "MYSQL_USER: [default: user]: "; read MYSQL_USER
printf "%s" "SSL_COUNTRY [default: <blank>]: "; read SSL_COUNTRY
printf "%s" "SSL_STATE [default: <blank>]: "; read SSL_STATE
printf "%s" "SSL_LOCALITY [default: <blank>]: "; read SSL_LOCALITY
printf "%s" "SSL_COMPANY [default: <blank>]: "; read SSL_COMPANY
printf "%s" "SSL_DEPARTMENT [default: <blank>]: "; read SSL_DEPARTMENT
printf "%s" "SSL_DAY_AGE [default: 365]: "; read SSL_DAY_AGE

# Set default value
if [ -z "$DOMAIN_NAME" ]; then
    DOMAIN_NAME=localhost
fi
if [ -z "$MYSQL_DATABASE" ]; then
    MYSQL_DATABASE=db
fi
if [ -z "$MYSQL_USER" ]; then
    MYSQL_USER=user
fi
if [ -z "$SSL_COUNTRY" ]; then
    SSL_COUNTRY="''"
fi
if [ -z "$SSL_STATE" ]; then
    SSL_STATE="''"
fi
if [ -z "$SSL_LOCALITY" ]; then
    SSL_LOCALITY="''"
fi
if [ -z "$SSL_COMPANY" ]; then
    SSL_COMPANY="''"
fi
if [ -z "$SSL_DEPARTMENT" ]; then
    SSL_DEPARTMENT="''"
fi
if [ -z "$SSL_DAY_AGE" ]; then
    SSL_DAY_AGE=365
fi

# Create String for .env
ENV_STR="DOMAIN_NAME=${DOMAIN_NAME}\n"
ENV_STR="${ENV_STR}MYSQL_DATABASE=${MYSQL_DATABASE}\n"
ENV_STR="${ENV_STR}MYSQL_USER=${MYSQL_USER}\n"
ENV_STR="${ENV_STR}SSL_COUNTRY=${SSL_COUNTRY}\n"
ENV_STR="${ENV_STR}SSL_STATE=${SSL_STATE}\n"
ENV_STR="${ENV_STR}SSL_LOCALITY=${SSL_LOCALITY}\n"
ENV_STR="${ENV_STR}SSL_COMPANY=${SSL_COMPANY}\n"
ENV_STR="${ENV_STR}SSL_DEPARTMENT=${SSL_DEPARTMENT}\n"
ENV_STR="${ENV_STR}SSL_DAY_AGE=${SSL_DAY_AGE}\n"

# Create env file
echo -e $ENV_STR > srcs/.env