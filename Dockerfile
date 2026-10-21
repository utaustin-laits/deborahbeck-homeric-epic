FROM php:8.2-apache

RUN a2enmod rewrite

ADD database.sqlite3 /
ADD server /var/www/html
