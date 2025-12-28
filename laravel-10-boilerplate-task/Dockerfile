FROM php:8.2-fpm-alpine

# System dependencies
RUN apk add --no-cache \
    curl \
    git \
    grep \
    build-base \
    libpng-dev \
    libxml2-dev \
    oniguruma-dev \
    libmemcached-dev \
    imagemagick-dev \
    supervisor

# PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    mbstring \
    xml

# PECL extensions
RUN pecl channel-update pecl.php.net \
    && pecl install memcached imagick \
    && docker-php-ext-enable memcached imagick

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer

WORKDIR /var/www

COPY . /var/www

# Supervisor config
COPY ./dev/docker-compose/php/supervisord-app.conf /etc/supervisord.conf

EXPOSE 9000

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
