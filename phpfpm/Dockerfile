FROM php:8.3-fpm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git unzip zip libzip-dev mariadb-client \
        libpng-dev libjpeg-dev libfreetype6-dev \
        libonig-dev libxml2-dev libssl-dev \
        pkg-config libcurl4-openssl-dev autoconf \
        gcc g++ make \
    && pecl install redis xdebug \
    && docker-php-ext-enable redis xdebug \
    && docker-php-ext-install pdo pdo_mysql pcntl zip \
    && mkdir -p /var/log \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=trigger" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.trigger_value=PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --disabled-password --gecos "" --uid 1000 appuser \
    && mkdir -p /var/www/html \
    && chown -R appuser:appuser /var/www/html

USER appuser

WORKDIR /var/www/html/laravel