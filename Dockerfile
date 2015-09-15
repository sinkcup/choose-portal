FROM php:apache
MAINTAINER sinkcup <sinkcup@163.com>

RUN apt-get update -qq
RUN apt-get upgrade -y
RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
ADD php.ini /usr/local/etc/php/
RUN cd /usr/local/bin/ && \
  curl -sS https://getcomposer.org/installer | php && \
  ln -s composer.phar composer
RUN ln -s ../mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

ADD . /var/www/choose-portal
RUN cd /var/www/choose-portal/ && \
  composer update ** \
  mkdir -p tmp && \
  chmod 777 tmp
ADD apache2/sites-enabled/ /etc/apache2/sites-enabled/
