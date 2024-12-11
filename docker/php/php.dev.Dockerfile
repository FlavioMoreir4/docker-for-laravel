# Usar imagem base leve com PHP 8.3 e FPM
FROM php:8.3-fpm-alpine

# Instalar dependências essenciais para PHP e ferramentas de desenvolvimento
RUN apk add --no-cache \
    bash \
    zip \
    unzip \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxml2-dev \
    git \
    bash \
    nodejs \
    npm \
    && docker-php-ext-configure gd --with-webp --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql gd

# Instalar xdebug (necessário para depuração no desenvolvimento)
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# Copiar a configuração personalizada do PHP-FPM
COPY ./docker/php/www.dev.conf /usr/local/etc/php-fpm.d/www.conf

# Instalar o Composer (para gerenciamento de dependências PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar dependências Node.js (caso precise para Vite.js ou outros assets)
RUN npm install -g npm@latest

# Copiar apenas os arquivos essenciais para instalar dependências PHP
COPY composer.json composer.lock /var/www/html/

# Instalar dependências PHP
RUN composer install --dev --optimize-autoloader --prefer-dist

# Copiar o restante do código da aplicação
COPY . /var/www/html/

# Instalar dependências Node.js e rodar o build de assets (se estiver usando Vite.js ou algo similar)
WORKDIR /var/www/html
RUN npm ci && npm run dev

# Ajuste de permissões para o diretório da aplicação
RUN chown -R laravel:laravel /var/www/html

# Usar o usuário não privilegiado para rodar a aplicação
USER laravel

# Configurar o comando para rodar o PHP-FPM
CMD ["php-fpm"]
