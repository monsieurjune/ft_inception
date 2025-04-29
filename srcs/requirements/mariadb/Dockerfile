FROM alpine:3.21

# Install Mariadb
RUN apk add --no-cache mariadb \
                        mariadb-client \
                        mariadb-server-utils

# Setup dir for mysql user
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy Configuration file
COPY ./conf /etc/my.cnf.d

# Expose Port
EXPOSE 3306

# Copy entrypoint
COPY ./tools/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Start MariaDB
ENTRYPOINT [ "/docker-entrypoint.sh" ]