FROM php:8.2-apache

# Install SQLite extensions and dependencies
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    sqlite3 \
    && docker-php-ext-install pdo pdo_sqlite \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Copy all project files to Apache webroot
COPY . /var/www/html/

# Set proper permissions for web server on SQLite db and uploads
RUN mkdir -p /var/www/html/db /var/www/html/uploads \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/db \
    && chmod -R 775 /var/www/html/uploads

# Expose HTTP port 80
EXPOSE 80

CMD ["apache2-foreground"]
