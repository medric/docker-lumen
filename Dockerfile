FROM php:7.0.4-fpm

RUN apt-get update

### POSTGRES for PHP ###
RUN buildDeps="libpq-dev libzip-dev libicu-dev" \
    && apt-get install -y $buildDeps --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

### COMPOSER ###
# Register the COMPOSER_HOME environment variable
ENV COMPOSER_HOME /composer
# Add global binary directory to PATH and make sure to re-export it
ENV PATH /composer/vendor/bin:$PATH
# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1
# Setup the Composer installer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
    && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }"
RUN php /tmp/composer-setup.php --install-dir=/bin --filename=composer \
    && rm -rf /tmp/composer-setup.php /tmp/composer-setup.sig

RUN chown -R www-data:www-data \
        /var/www/storage \
        /var/www/bootstrap/cache