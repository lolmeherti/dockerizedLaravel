FROM php:8.3-cli

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        curl \
        libzip-dev \
        zlib1g-dev \
        default-mysql-client \
    && docker-php-ext-configure zip \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        zip \
        pcntl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN addgroup --gid 1001 wwwgroup \
    && adduser --disabled-password --gecos "" --uid 1000 --ingroup wwwgroup appuser

RUN mkdir -p /var/www/html \
    && chown -R appuser:wwwgroup /var/www/html \
    && chmod -R 775 /var/www/html

USER appuser

WORKDIR /var/www/html/laravel