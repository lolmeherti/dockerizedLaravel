FROM php:8.2-cli-alpine

COPY --from=laravel_base:latest /usr/local /usr/local
COPY --from=laravel_base:latest /var/www/html/laravel /var/www/html/laravel

WORKDIR /var/www/html/laravel

CMD ["php", "-a"]
