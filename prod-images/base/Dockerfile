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
    rsync \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    mariadb-connector-c \
    git \
    unzip \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql zip exif pcntl gd

WORKDIR /var/www/html/laravel

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY --chown=www-data:www-data ./src/laravel/ ./
COPY --chown=www-data:www-data ./src/laravel/prod-files/.env .env
COPY --chown=www-data:www-data ./src/laravel/prod-files/vite.config.js vite.config.js
COPY --from=node-build --chown=www-data:www-data /app/public/build ./public/build
COPY ../nginx/default.conf /var/www/html/nginx/conf.d/default.conf

RUN rm -f public/hot \
    && rm -rf storage/framework/views/*
