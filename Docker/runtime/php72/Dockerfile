# This docker file uses the centos image
# VERSION 1
# Base image
#下载swoole-4.2.3.tgz安装包到software 下载地址：# http://pecl.php.net/package/swoole
# 编译安装,扩展需要redis,gd zip,mbstring,swoole,

# LABEL multi.label1="value1" \
# multi.label2="value2" \
# other="value3"

# Maintainer

FROM daocloud.io/php:7.2-fpm-alpine
MAINTAINER linyaohong

WORKDIR /usr/src/swoole
COPY ./swoole-4.4.12.tgz  /tmp/ 
COPY ./tars-extension-0.1.2.tar.gz /tmp
# 修改镜像源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装依赖,核心扩展,pecl扩展,git,composer,npm工具
RUN apk update && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
        libmcrypt-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
    && apk add --no-cache \
        curl \
        git \
        imagemagick \
        mysql-client \
        postgresql-libs \
        nodejs \
        nodejs-npm \
    # 配置npm中国镜像
    && npm config set registry https://registry.npm.taobao.org \
    && pecl install imagick \
    && pecl install mcrypt-1.0.1 \
    && mkdir -p /usr/src/swoole \
    && tar -xzf /tmp/swoole-4.4.12.tgz -C /usr/src/swoole --strip-components=1 \
    && /usr/local/bin/phpize \
    && ./configure \
    && make \
    && make install \
    && mkdir -p /usr/src/phptars \
    && tar -xzf /tmp/tars-extension-0.1.2.tar.gz -C /usr/src/phptars --strip-components=1 \
    && /usr/local/bin/phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable swoole \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install \
        curl \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        pcntl \
        tokenizer \
        xml \
        zip \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd \
    && pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

# 安装composer并允许root用户运行
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME=/usr/local/share/composer
RUN mkdir -p /usr/local/share/composer \
    && curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
    && rm -f /tmp/composer-setup.* \
    # 配置composer中国全量镜像
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com

# 对其他容器开放9000端口
EXPOSE 9000
WORKDIR /


#================================Dockerfile=================================
#创建镜像
# docker build -t myphp:7.2-fpm .

#启动容器
# docker run -p 9100:9000 --name myPhp -v /www:/var/www/html/ -v $PWD/www.conf:/usr/local/etc/php-fpm.d/www.conf --privileged=true -d myphp:7.2-fpm