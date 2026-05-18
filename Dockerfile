FROM php:8.2-apache

# Install system dependencies and Composer
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable mod_rewrite
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy composer files first (for caching)
COPY composer.json ./

# Install PHP dependencies (this creates the vendor folder)
RUN composer install --no-dev --optimize-autoloader

# Copy the rest of your application
COPY . .

# Create .htaccess for routing
RUN echo "RewriteEngine On\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule ^ index.php [QSA,L]" > /var/www/html/.htaccess

EXPOSE 80