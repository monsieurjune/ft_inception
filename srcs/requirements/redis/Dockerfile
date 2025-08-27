FROM alpine:3.20.6

# Install redis
RUN apk add --no-cache redis

# Config file
COPY ./conf/redis.conf /etc/redis/redis.conf
COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh
COPY ./tools/healthcheck.sh /healthcheck.sh

# Set script to be executable
RUN chmod +x /docker-entrypoint.sh /healthcheck.sh

# expose port
EXPOSE 6379

# Run redis
ENTRYPOINT [ "/docker-entrypoint.sh" ]
