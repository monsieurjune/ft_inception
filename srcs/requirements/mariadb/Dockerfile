# FROM mariadb:11.8-noble-rc

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

# Setup Database
COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]

# Start MariaDB
CMD ["mariadbd"]