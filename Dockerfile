FROM php:7.3.6-fpm-alpine3.9

#Atualizando pacotes
RUN apk update
RUN apk upgrade --available && sync

RUN apk add --no-cache openssl bash mysql-client nodejs npm

RUN docker-php-ext-install pdo pdo_mysql bcmath

WORKDIR /var/www

#Removendo a pasta original do nginx
RUN rm -rf /var/www/html

#criando link simbolico
RUN ln -s public html

#instalando o composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

########## instalando laravel ###############
# RUN composer create-project --prefer-dist laravel/laravel blog
# RUN cd blog
# RUN shopt -s dotglob
# RUN mv * ../
# RUN cd ..
# RUN rm blog
########################

EXPOSE 9000

ENTRYPOINT ["php-fpm"]
