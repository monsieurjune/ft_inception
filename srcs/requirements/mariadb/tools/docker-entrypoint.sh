#!/usr/bin/env bash

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

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Init DB
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # Start MariaDB temporary
    service mariadb start

    # Simple Sleep (it should be around 2-5 sec)
    sleep 10

    # Append SQL to MariaDB
    echo -e $SQL_COMMANDS | mariadb -u root

    # Stop Temporary DB
    service mariadb stop
fi

# Execute MariaDB as mysql
exec mariadbd --user=mysql