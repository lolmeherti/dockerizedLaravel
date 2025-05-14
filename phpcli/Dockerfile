FROM php:8.3-cli

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        curl \
        libzip-dev \
        default-mysql-client \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        zip \
        pcntl \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --disabled-password --gecos "" --uid 1000 appuser \
    && mkdir -p /var/www/html \
    && chown -R appuser:appuser /var/www/html

USER appuser

WORKDIR /var/www/html/laravel