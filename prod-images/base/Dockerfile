FROM node:18-alpine AS node-build

WORKDIR /app

COPY ./src/laravel/package.json ./src/laravel/package-lock.json ./

RUN npm install

COPY ./src/laravel/ ./
COPY ./src/laravel/prod-files/.env .env
COPY ./src/laravel/prod-files/vite.config.js vite.config.js

RUN npm run build

FROM php:8.2-fpm-alpine AS base

RUN apk add --no-cache \
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

COPY ./src/laravel/ ./

RUN rm -f /public/hot
RUN rm -rf /storage/framework/views/*

COPY ./src/laravel/prod-files/.env /var/www/html/laravel/.env

COPY --from=node-build /app/public/build /var/www/html/laravel/public/build

RUN mkdir -p /var/www/html/nginx/conf.d

COPY ../nginx/default.conf /var/www/html/nginx/conf.d/default.conf

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html