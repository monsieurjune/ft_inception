FROM alpine:3.20.6

# Install PHP8.2-fpm and associate module
RUN apk add --no-cache php82-fpm \
                        php82-mysqli \
                        php82-pdo_mysql \
                        php82-json \
                        php82-curl \
                        php82-xmlreader \
                        php82-dom \
                        php82-gd \
                        php82-zip \
                        php82-gettext \
                        php82-openssl \
                        php82-ctype \
                        php82-iconv \
                        php82-cgi \
                        php82-cli \
                        php82-phar

# Create www-data user
RUN adduser -S -D -H -s /sbin/nologin -G www-data www-data && \
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    ln -s /usr/bin/php82 /usr/bin/php

# Copy Configuration Files
COPY ./conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY ./conf/extra.php /var/www/tmp/extra.php

# Copy wordpress
COPY ./tools/wordpress /var/www/html

# Copy wp-cli
COPY ./tools/wp-cli.phar /usr/local/bin/wp

# Copy entrypoint
COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh 

# Set script to be executable
RUN chmod +x /docker-entrypoint.sh /usr/local/bin/wp

# Run wordpress
ENTRYPOINT [ "/docker-entrypoint.sh" ]
