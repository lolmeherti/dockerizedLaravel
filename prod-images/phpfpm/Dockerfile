
FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
    autoconf g++ make \
    freetype-dev libjpeg-turbo-dev libpng-dev libzip-dev zlib-dev mariadb-connector-c-dev \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/20-redis.ini \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql zip exif pcntl gd \
    && apk del autoconf g++ make

RUN adduser -D -u 1000 appuser \
    && mkdir -p /home/appuser/.ssh \
    && chown -R appuser:appuser /home/appuser

USER appuser

WORKDIR /var/www/html/laravel

EXPOSE 9000
CMD ["php-fpm"]
