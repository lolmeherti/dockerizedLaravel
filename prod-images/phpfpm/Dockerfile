
FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    zlib-dev \
    mariadb-connector-c-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo_mysql \
        zip \
        exif \
        pcntl \
        gd

RUN addgroup -g 1001 wwwgroup \
    && adduser -D -u 1000 -G wwwgroup appuser \
    && mkdir -p /var/www/html \
    && chown -R appuser:wwwgroup /var/www/html

USER appuser

WORKDIR /var/www/html/laravel

EXPOSE 9000
CMD ["php-fpm"]
