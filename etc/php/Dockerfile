FROM php:7.1-fpm

ARG WWW_DATA_UID

ENV WWW_DATA_UID $WWW_DATA_UID
ENV DEBIAN_FRONTEND noninteractive

ENV REDIS_VERSION 3.1.4
ENV XDEBUG_VERSION 2.5.5
ENV AMQP_VERSION 1.9.3

RUN usermod -u ${WWW_DATA_UID} www-data
RUN usermod -G staff www-data

RUN apt-get update \
 && apt-get install -y curl

# pdo
RUN apt-get install -y libpq-dev \
 && docker-php-ext-install pdo pdo_pgsql

# xdebug
RUN pecl install xdebug-${XDEBUG_VERSION} \
 && docker-php-ext-enable xdebug

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin

WORKDIR /var/www
