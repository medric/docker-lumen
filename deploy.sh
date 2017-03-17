#!/bin/sh

rm -rf vendor
composer install
rm -rf app/logs/* app/cache/*

docker-compose up --build