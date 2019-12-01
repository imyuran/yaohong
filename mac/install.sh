# https://www.cnblogs.com/wt645631686/p/10898714.html
brew install php72
# 如果你的系统已经安装其他版本，报错可能如下

==> Installing php72 from homebrew/php
Error: Cannot install homebrew/php/php72 because conflicting formulae are installed.
php55: because different php versions install the same binaries.
Please `brew unlink php55` before continuing.
# 可以卸载当前系统下的php5.5版本

brew unlink php55


# 2、配置文件位置
好安装后生成的配置文件都在/usr/local/etc/php/7.2目录里，分别如下：
php.ini位置为/usr/local/etc/php/7.2/php.ini
php-fpm.conf位置为/usr/local/etc/php/7.2/php-fpm.conf
PHP运行phpize，PHP-配置ls /usr/local/opt/php72/bin
PHP-FPM位置为/usr/local/opt/php72/sbin/php-fpm

# 3、将php7加入开机启动
mkdir -p ~/Library/LaunchAgents ln -sfv /usr/local/opt/php72/homebrew.mxcl.php72.plist ~/Library/LaunchAgents/ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php72.plist

# 4、将php加入$PATH
vim ~/.bash_profile

export PATH="/usr/local/sbin:$PATH"
export PATH="$(brew --prefix php72)/bin:$PATH"
export PATH="$(brew --prefix php72)/sbin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
source ~/.bash_profile

#6、查看是否安装成功
lsof -Pni4 | grep LISTEN | grep php

# 7、重启php7
brew services restart php72
# 安装Nginx

brew install nginx
通过homebrew，nginx文件默认被安装在/usr/local/etc/nginx/nginx.conf

nginx -s reload
nginx -t
# Nginx开机启动,不过推荐自己启动
ln -sfv /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
# 安装MySQL
brew install mysql@5.7
# 设置MySQL的开机自启动：
ln -sfv /usr/local/opt/mysql@5.7/*.plist ~/Library/LaunchAgents
/Users/wangteng/Library/LaunchAgents/homebrew.mxcl.mysql@5.7.plist -> /usr/local/opt/mysql@5.7/homebrew.mxcl.mysql@5.7.plist
# 增加环境变量
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# 然后启动mysql
mysql.server start
# 测试数据库是否安装成功
mysql -u root -p  //因为没有设置密码，两次回车即可 
# 查看网络监听
netstat -nat | grep LISTEN
