# Dockerfile
FROM thecodingmachine/php:8.2-v4-apache

# Enable Apache rewrite module
RUN a2enmod rewrite

# Copy your application code into the container
COPY . /var/www/html/

# Set Apache to use your index.php for routing
RUN echo "\n\
<Directory /var/www/html/>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>" > /etc/apache2/sites-available/000-default.conf