#!/usr/bin/env bash

# Set to exit on error
set -e

# Ping DB
exec mariadb-admin ping -h localhost -u root -p$(cat "${MYSQL_ROOT_PASSWORD_FILE}")
