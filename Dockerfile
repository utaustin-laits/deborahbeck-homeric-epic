FROM php:7.3-apache

RUN a2enmod rewrite

ADD database.sqlite3 /
ADD server /var/www/html
