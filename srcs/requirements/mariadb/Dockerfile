FROM debian:bullseye

# Install dependencies and MariaDB server
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Setup dir for mysql user
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

# Copy Configuration file
COPY ./conf /etc/mysql/mariadb.conf.d/

# Expose Port
EXPOSE 3306

# Clear Data Direcory, because i want clean DB
RUN rm -rf /var/lib/mysql/*

# Copy entrypoint
COPY ./tools/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Start MariaDB
ENTRYPOINT [ "/docker-entrypoint.sh" ]