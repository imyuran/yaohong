# This docker file uses the centos image
# VERSION 1
# Base image
FROM centos
# Maintainer
MAINTAINER linyaohong
#Commands to update the image
ADD pcre-8.42.tar.gz /usr/local/src
ADD nginx-1.14.2.tar.gz /usr/local/src
RUN yum install -y wget gcc gcc-c++ openssl-devel make
RUN useradd -s /sbin/nologin -M www
WORKDIR /usr/local/src/nginx-1.14.2
RUN ./configure --prefix=/usr/local/nginx --user=www --group=www \
     --with-http_ssl_module --with-http_stub_status_module --with-file-aio \
     --with-http_dav_module --with-pcre=/usr/local/src/pcre-8.42 && make && make install
ADD nginx.conf /usr/local/nginx/conf
RUN echo "daemon off;" >> /usr/local/nginx/conf/nginx.conf
ENV PATH /usr/local/nginx/sbin:$PATH
RUN mkdir /usr/local/nginx/conf/vhost
RUN mkdir -p /data/wwwroot/shd-lp.vipthink.cn/static
ADD index.html /data/wwwroot/shd-lp.vipthink.cn/static
EXPOSE 80
CMD ["nginx"]

# docker build -t mynginx  .

# docker run  --name nginx02 -d  -p 10.10.10.190:81:80 -p 443:443 nginx