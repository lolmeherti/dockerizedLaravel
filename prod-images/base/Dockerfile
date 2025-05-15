FROM node:18-alpine AS node-build

WORKDIR /app

COPY ./src/laravel/package*.json ./
RUN npm ci

COPY ./src/laravel/ ./
COPY ./src/laravel/prod-files/.env .env
COPY ./src/laravel/prod-files/vite.config.js vite.config.js

RUN npm run build


FROM php:8.2-fpm-alpine AS base

RUN apk add --no-cache \
    mariadb-client \
    rsync \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    zlib-dev \
    mariadb-connector-c \
    git \
    unzip \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql zip exif pcntl gd \
    && pecl install redis \
    && docker-php-ext-enable redis

RUN addgroup -g 1001 wwwgroup \
    && adduser -D -u 1000 -G wwwgroup appuser \
    && adduser www-data wwwgroup

WORKDIR /var/www/html/laravel

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY --chown=appuser:appuser ./src/laravel/ ./
COPY --chown=appuser:appuser ./src/laravel/prod-files/.env .env
COPY --chown=appuser:appuser ./src/laravel/prod-files/vite.config.js vite.config.js
COPY --from=node-build --chown=appuser:appuser /app/public/build ./public/build

COPY ../nginx/default.conf /var/www/html/nginx/conf.d/default.conf

RUN rm -f public/hot && rm -rf storage/framework/views/*

USER appuser
