#!/bin/bash

echo "Create project: "
composer create-project --prefer-dist laravel/laravel $1
echo "Enter into project folder: "
cd $1
echo "README: "
echo " " > README.md
cp .env.example .env
echo "Version Control: "
git init
git add -A
git commit -m 'Initial commit'
echo "Optimizate: "
php artisan key:generate
php artisan config:clear
php artisan config:cache
echo "Migrations: "
php artisan session:table
php artisan cache:table
php artisan migrate

echo "Prevent uggly page to public/: "
echo "<IfModule mod_rewrite.c>
RewriteEngine On
RewriteRule ^(.*)$ public/$1 [L]
</IfModule>
# Crafted by Daniel Naranjo 2018
" > .htaccess

echo "Reminder: "
echo "* To fix this:  1071 Specified key was too long; max key length is 767 bytes"
echo "* Add this: Schema::defaultStringLength(191); to this file: app\Provider\AppServiceProvider.php and on header: use Illuminate\Support\Facades\Schema;"
echo "* See: https://laravel-news.com/laravel-5-4-key-too-long-error"
echo " "
echo "* To use custom locate, ex. es":
echo "* Add this: Carbon::setLocale(config('app.locale')); to AppServiceProvider.php and header: use Carbon\Carbon;"
echo " "

echo "Run Server: "
php artisan serve
