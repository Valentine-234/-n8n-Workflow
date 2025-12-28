FROM php:8.2-cli-alpine

ARG queueTimeout
ARG queueTries
ARG queues

ENV QUEUE_TIMEOUT=${queueTimeout}
ENV QUEUE_TRIES=${queueTries}
ENV QUEUES=${queues}

# System dependencies
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip

# PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer

WORKDIR /var/www

# Queue worker
CMD php artisan queue:work redis \
    --queue=${QUEUES} \
    --timeout=${QUEUE_TIMEOUT} \
    --tries=${QUEUE_TRIES}

FROM php:8.2-cli-alpine

ARG queueTimeout
ARG queueTries
ARG queues

ENV QUEUE_TIMEOUT=${queueTimeout}
ENV QUEUE_TRIES=${queueTries}
ENV QUEUES=${queues}

# System dependencies
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip

# PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer

WORKDIR /var/www

# Queue worker
CMD php artisan queue:work redis \
    --queue=${QUEUES} \
    --timeout=${QUEUE_TIMEOUT} \
    --tries=${QUEUE_TRIES}
