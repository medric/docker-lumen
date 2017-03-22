#!/bin/bash
export DATABASE__PASSWORD="password"
export DATABASE__USER="user"
export DATABASE__HOST="host"
export DATABASE__NAME="name"

#chown -R www-data:www-data \
#        /var/www/storage \
#        /var/www/bootstrap/cache

php artisan migrate --force
php artisan optimize