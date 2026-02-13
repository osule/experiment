FROM --platform=linux/amd64 composer:2.8.1 AS composer 

FROM --platform=linux/amd64 php:8.3-bookworm

# Install PHP gd extension (required by phpoffice/phpspreadsheet for maatwebsite/excel)
RUN apt-get update && apt-get install -y chromium-driver libglib2.0-0 libpng-dev libzip-dev\
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) zip

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
# Copy the files specifically
COPY composer.json composer.lock ./

# RUN composer update --lock --no-autoloader --no-scripts
RUN composer install --no-interaction --no-scripts --no-autoloader --prefer-dist

COPY . .

RUN composer dump-autoload --optimize 

RUN php artisan dusk:chrome-driver && \
    ln -sf /usr/bin/chromedriver /var/www/html/vendor/laravel/dusk/bin/chromedriver-linux
CMD php artisan config:clear && php artisan serve --host=0.0.0.0 --port=8000

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

EXPOSE 8000
