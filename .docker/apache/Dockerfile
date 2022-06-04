FROM php:7.4-apache AS apache

RUN apt-get update -y && \
    apt-get install imagemagick sendmail -y

RUN docker-php-ext-install pdo pdo_mysql mysqli

COPY ./.user.ini /usr/local/etc/php/conf.d/.user.ini

RUN a2enmod rewrite