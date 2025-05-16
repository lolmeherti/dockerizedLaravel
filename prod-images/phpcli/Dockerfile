FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
    autoconf \
    g++ \
    make \
    bash \
    libzip-dev \
    zip \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    mariadb-connector-c \
    curl \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo_mysql \
        zip \
        exif \
        pcntl \
        gd \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del autoconf g++ make

RUN adduser -D -u 1000 appuser \
    && mkdir -p /home/appuser/.ssh \
    && chown -R appuser:appuser /home/appuser

USER appuser

WORKDIR /var/www/html/laravel

EXPOSE 9000
CMD ["php-fpm"]
