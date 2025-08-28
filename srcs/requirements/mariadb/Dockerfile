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

# Clear Data Direcory, because i want the clean DB to work on, not the pre setup
RUN rm -rf /var/lib/mysql/*

# Copy scripts and make them executable
COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh
COPY ./tools/healthcheck.sh /healthcheck.sh
RUN chmod +x /docker-entrypoint.sh /healthcheck.sh

# Expose Port
EXPOSE 3306

# Start MariaDB
ENTRYPOINT [ "/docker-entrypoint.sh" ]
