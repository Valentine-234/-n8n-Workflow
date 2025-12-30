FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    wget \
    curl \
    git \
    grep \
    build-base \
    libmemcached-dev \
    libxml2-dev \
    imagemagick-dev \
    pcre-dev \
    libtool \
    make \
    autoconf \
    g++ \
    cyrus-sasl-dev \
    libgsasl-dev \
    supervisor \
    pkgconfig \
    zlib-dev \
    ca-certificates \
    && update-ca-certificates

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql xml \
    && pecl install memcached imagick \
    && docker-php-ext-enable memcached imagick

WORKDIR /var/www

# Copy Supervisor config
COPY ./dev/docker-compose/php/supervisord-app.conf /etc/supervisord.conf

# Start Supervisor as entrypoint
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

