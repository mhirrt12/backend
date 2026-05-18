FROM php:8.2-apache

# Enable mod_rewrite
RUN a2enmod rewrite

# Copy your app
COPY . /var/www/html/

# Use the default Apache port (Render maps 10000 to 80)
EXPOSE 80

# Apache stays in foreground
CMD ["apache2-foreground"]