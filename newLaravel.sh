#!/bin/bash

composer create-project --prefer-dist laravel/laravel $1
cd $1
touch README.md
cp .env.example .env
git init
git add -A
git commit -m 'Initial commit'
php artisan key:generate
php artisan config:clear
php artisan config:cache
