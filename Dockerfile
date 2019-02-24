FROM php:7.2-apache

LABEL Rufus Mbugua - https://github.com/rufusmbugua

COPY . /var/www/html/
COPY ./docker/000-default.conf /etc/apache2/sites-available/000-default.conf

# Prepare MySQL
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections 
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections 


# Install Additional Packages
RUN apt-get update 
RUN apt-get install --no-install-recommends -y mysql-server git zip unzip zlib1g-dev
RUN docker-php-ext-install pdo pdo_mysql zip
RUN a2enmod rewrite
RUN service apache2 restart
RUN service mysql start

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php


VOLUME /var/www/html

WORKDIR /var/www/html

EXPOSE 80/tcp
EXPOSE 80/udp
