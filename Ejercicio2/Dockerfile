FROM matomo:latest

# Instalar dependencias adicionales
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

COPY zzz-matomo.ini /usr/local/etc/php/conf.d/zzz-matomo.ini

# Configuración de permisos
RUN chown -R www-data:www-data /var/www/html

# Exponer puerto
EXPOSE 80

# Comando por defecto
CMD ["apache2-foreground"]
