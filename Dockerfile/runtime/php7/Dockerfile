FROM php:7.2-cli-alpine
COPY ./lib/inotify-2.0.0.tgz /root/
COPY ./lib/swoole-4.2.3.tgz /root/
COPY ./lib/tars-extension-0.1.0.tar.gz /root/

RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories  && \
  apk update &&\
  apk add   libpng-dev curl-dev   freetype-dev g++ autoconf make &&\
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ && /usr/local/bin/docker-php-ext-install pdo pdo_mysql curl  gd bcmath zip sockets

RUN tar xvf ~/tars-extension-0.1.0.tar.gz -C ~/ && cd ~/tars-extension-0.1.0 &&  phpize && ./configure && make && make install  && echo "extension=phptars.so"> "/usr/local/etc/php/conf.d/phptars.ini" &&\
  tar xvf ~/swoole-4.2.3.tgz -C ~/ && cd ~/swoole-4.2.3 &&  phpize && ./configure && make && make install  && echo "extension=swoole.so"> "/usr/local/etc/php/conf.d/swoole.ini" &&\
  tar xvf ~/inotify-2.0.0.tgz -C ~/ && cd ~/inotify-2.0.0 &&  phpize && ./configure && make && make install  && echo "extension=inotify.so"> "/usr/local/etc/php/conf.d/inotify.ini" &&\
  echo "succ"
RUN  curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/3.1.3.tar.gz && tar xfz /tmp/redis.tar.gz && rm -r /tmp/redis.tar.gz && mkdir -p /usr/src/php/ext && mv phpredis-3.1.3 /usr/src/php/ext/redis && docker-php-ext-install redis

ENTRYPOINT ["/code/docker/tars_start.sh"]

#创建镜像
# docker build -t phptars:7.2-fpm .