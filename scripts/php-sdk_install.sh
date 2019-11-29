#!/bin/bash
app_code=$(hostname)
cd /data/
[ ! -d /data ]  && mkdir /data/
if [ ! -f /usr/local/php/bin/phpize ];then
    ln  -s /usr/local/php/bin/*  /usr/local/bin/
fi
git clone https://github.com/SkyAPM/SkyAPM-php-sdk.git
cd ./SkyAPM-php-sdk
phpize
./configure
make
make install
echo "extension=skywalking.so" >> /usr/local/php/etc/php.d/09-skywalking.ini
echo "skywalking.enable=1" >> /usr/local/php/etc/php.d/09-skywalking.ini
echo "skywalking.version=6" >> /usr/local/php/etc/php.d/09-skywalking.ini
echo "skywalking.app_code=\$(app_code)" >> /usr/local/php/etc/php.d/09-skywalking.ini
echo "skywalking.sock_path=/tmp/sky-agent.sock" >> /usr/local/php/etc/php.d/09-skywalking.ini
systemctl restart php-fpm

cd /data/
wget https://github.com/SkyAPM/SkyAPM-php-sdk/releases/download/3.2.0/sky-php-agent-linux-x64
mv sky-php-agent-linux-x64 sky-php-agent
chmod +x sky-php-agent
mv sky-php-agent /usr/bin
nohup sky-php-agent --grpc 10.104.158.1:11800 /tmp/sky-agent.sock  &
echo cd /data/ \&\& nohup sky-php-agent --grpc 10.104.158.1:11800 /tmp/sky-agent.sock  \& >>/etc/rc.local
chmod +x  /etc/rc.local
