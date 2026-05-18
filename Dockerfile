FROM php:8.2-apache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable mod_rewrite and install MySQLi & PDO MySQL (some images may already have it, but ensure)
RUN docker-php-ext-install pdo_mysql mysqli && a2enmod rewrite

WORKDIR /var/www/html

COPY composer.json ./
RUN composer install --no-dev --optimize-autoloader

COPY . .

RUN echo "RewriteEngine On\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule ^ index.php [QSA,L]" > /var/www/html/.htaccess

EXPOSE 80