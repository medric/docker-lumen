#!/bin/sh
export DATABASE__PASSWORD="password"
export DATABASE__USER="user"
export DATABASE__HOST="host"
export DATABASE__NAME="name"

php artisan migrate --force
php artisan optimize