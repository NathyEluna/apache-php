FROM php:8.1-apache

#Actualizar repositorios e instalar paquetes necesarios
RUN apt-get update && apt-get install -y \
	vim nano net-tools \
	&& apt-get autoremove

# Copiar contenido HTML y PHP al contenedor
COPY html/ /var/www/html/

# Configurar el VirtualHost
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Copiar certificados SSL al contenedor
COPY certs/ /etc/ssl/certs/

# Habilitar SSL y reiniciar el servidor
RUN a2enmod ssl rewrite && service apache2 restart

# Exponer el puerto 80 para HTTP y 443 para HTTPS
EXPOSE 80 443

# Configurar Apache para ejecutar PHP
CMD ["apache2-foreground"]
