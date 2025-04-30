FROM debian:bullseye

# Install dependencies and MariaDB server
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Setup dir for mysql user
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy Configuration file
COPY ./conf /etc/mysql/mariadb.conf.d/

# Expose Port
EXPOSE 3306

# Copy entrypoint
COPY ./tools/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Start MariaDB
ENTRYPOINT [ "/docker-entrypoint.sh" ]