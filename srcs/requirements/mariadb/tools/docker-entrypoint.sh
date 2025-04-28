#!/usr/bin/env sh

# Set to exit when cmd return non-zero
set -e

# ===== SQL Code ======

SQL_COMMANDS=""

# Create Database
SQL_COMMANDS="${SQL_COMMANDS}CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;\n"

# Create User with wildcard host
SQL_COMMANDS="${SQL_COMMANDS}CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '$(cat "${MYSQL_PASSWORD_FILE}")';\n"
SQL_COMMANDS="${SQL_COMMANDS}GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';\n"

# Create User with localhost
SQL_COMMANDS="${SQL_COMMANDS}CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '$(cat "${MYSQL_PASSWORD_FILE}")';\n"
SQL_COMMANDS="${SQL_COMMANDS}GRANT SELECT, SHOW VIEW ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'localhost';\n"

# Apply Password to root
SQL_COMMANDS="${SQL_COMMANDS}ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat "${MYSQL_ROOT_PASSWORD_FILE}")';\n"

# Delete 'ghost' users
SQL_COMMANDS="${SQL_COMMANDS}DELETE FROM mysql.user WHERE user = '';\n"

# Apply Change
SQL_COMMANDS="${SQL_COMMANDS}FLUSH PRIVILEGES;\n"

# ======================

# ======= SQL ==========

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Create mysql user in db
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # Start MariaDB temporarily
    mysqld_safe --skip-networking &

    # Plain Sleep for a seconds, as it's certain that there is error.
    # if it still doesn't active after 5-10 sec
    sleep 5

    # Append SQL to MariaDB
    printf "%s" "${SQL_COMMANDS}" | mariadb -u root

    # Stop Temporary DB
    mariadb-admin shutdown
fi

# ======================

# Unset Variable
SQL_COMMANDS=""

# Execute default CMD
exec su mysql -s /bin/sh -c "exec $@"