# Usar imagem base leve com PHP 8.3 e FPM
FROM php:8.3-fpm-alpine

# Instalar dependências essenciais para PHP (incluindo extensões de imagem e MySQL)
RUN apk add --no-cache \
    bash \
    zip \
    unzip \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-webp --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql gd

# Copiar a configuração personalizada do PHP-FPM
COPY ./docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf

# Instalar o Composer (com a opção --no-interaction para não precisar de interação com o terminal)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar apenas os arquivos essenciais para instalar dependências PHP
COPY composer.json composer.lock /var/www/html/

# Instalar dependências PHP
RUN composer install --no-dev --optimize-autoloader --prefer-dist

# Copiar o restante do código da aplicação
COPY . /var/www/html/

# Ajuste de permissões para o diretório da aplicação (usando apenas o usuário 'laravel' agora)
RUN chown -R laravel:laravel /var/www/html

# Usar o usuário não privilegiado para rodar a aplicação
USER laravel

# Configurar o comando para rodar o PHP-FPM
CMD ["php-fpm"]
