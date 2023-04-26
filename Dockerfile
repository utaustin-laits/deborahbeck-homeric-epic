FROM php:8.1-apache

RUN a2enmod rewrite

ADD database.sqlite3 /
ADD server /var/www/html
