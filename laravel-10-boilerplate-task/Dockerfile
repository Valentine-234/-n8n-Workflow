FROM php:8.2-fpm-alpine

ARG user
ARG uid

# Alpine uses apk package manager (not apt-get)
RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
       sqlite \
       git \
       curl \
       libpng-dev \
       oniguruma-dev \
       libxml2-dev \
       zip \
       unzip \
       libzip-dev \
       dcron \
       mysql-client \
       bash \
       shadow \
    && rm -rf /var/cache/apk/*

# Install PHP extensions (same as before)
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Get latest composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create user for running the application (Alpine way)
RUN if [ -n "$user" ] && [ -n "$uid" ]; then \
        addgroup -g $uid $user \
        && adduser -u $uid -G $user -s /bin/bash -D $user; \
    fi

# Create log permission fix script
RUN echo '#!/bin/bash' > /usr/local/bin/fix-log-permissions.sh \
    && echo 'LOG_FILE="/var/www/storage/logs/laravel_$(date +%Y-%m-%d).log"' >> /usr/local/bin/fix-log-permissions.sh \
    && echo 'if [ -f "$LOG_FILE" ]; then' >> /usr/local/bin/fix-log-permissions.sh \
    && echo '    chown www-data:www-data "$LOG_FILE"' >> /usr/local/bin/fix-log-permissions.sh \
    && echo '    chmod 664 "$LOG_FILE"' >> /usr/local/bin/fix-log-permissions.sh \
    && echo 'fi' >> /usr/local/bin/fix-log-permissions.sh \
    && echo 'find /var/www/storage/logs -name "laravel_*.log" -user root -exec chown www-data:www-data {} \;' >> /usr/local/bin/fix-log-permissions.sh \
    && chmod +x /usr/local/bin/fix-log-permissions.sh

# Create entrypoint script (Alpine-compatible)
RUN echo '#!/bin/bash' > /usr/local/bin/entrypoint.sh \
    && echo '# Ensure proper permissions' >> /usr/local/bin/entrypoint.sh \
    && echo 'if [ -d "/var/www/storage" ]; then' >> /usr/local/bin/entrypoint.sh \
    && echo '    chown -R www-data:www-data /var/www/storage' >> /usr/local/bin/entrypoint.sh \
    && echo '    chmod -R 755 /var/www/storage' >> /usr/local/bin/entrypoint.sh \
    && echo 'fi' >> /usr/local/bin/entrypoint.sh \
    && echo 'if [ -d "/var/www/bootstrap/cache" ]; then' >> /usr/local/bin/entrypoint.sh \
    && echo '    chown -R www-data:www-data /var/www/bootstrap/cache' >> /usr/local/bin/entrypoint.sh \
    && echo '    chmod -R 755 /var/www/bootstrap/cache' >> /usr/local/bin/entrypoint.sh \
    && echo 'fi' >> /usr/local/bin/entrypoint.sh \
    && echo '# Set up cron job (Alpine uses /etc/crontabs/)' >> /usr/local/bin/entrypoint.sh \
    && echo 'echo "0 * * * * /usr/local/bin/fix-log-permissions.sh" > /etc/crontabs/root' >> /usr/local/bin/entrypoint.sh \
    && echo 'chmod 600 /etc/crontabs/root' >> /usr/local/bin/entrypoint.sh \
    && echo '# Start cron service (Alpine uses crond)' >> /usr/local/bin/entrypoint.sh \
    && echo 'crond -b' >> /usr/local/bin/entrypoint.sh \
    && echo 'exec "$@"' >> /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

# Set working directory
WORKDIR /var/www

# Copy composer files first
COPY composer.json composer.lock ./

# Install composer dependencies
RUN composer install --no-scripts --no-autoloader --no-interaction || true

# Copy application
COPY . .

# Generate autoloader
RUN composer dump-autoload --no-interaction || true

# Create necessary directories with proper permissions
RUN mkdir -p storage/logs storage/framework/cache storage/framework/sessions storage/framework/views bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 755 storage bootstrap/cache

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:9000/ping || exit 1

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm"]