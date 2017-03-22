#!/bin/sh
chmod +x ./entrypoint.sh

rm -rf vendor
composer install
rm -rf app/logs/* app/cache/*

docker-compose up --build