FROM php:apache
MAINTAINER sinkcup <sinkcup@163.com>

RUN apt-get update -qq
RUN apt-get upgrade -y
RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN ln -s ../mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
ADD php.ini /usr/local/etc/php/

ADD . /var/www/choose-portal
RUN cd /var/www/choose-portal/ && \
  mkdir -p tmp && \
  chmod 777 tmp
ADD apache2/sites-enabled/ /etc/apache2/sites-enabled/
