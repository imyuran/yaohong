
# 安装postgresql
yum install -y https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-3.noarch.rpm
# https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/
yum install -y postgresql95-server postgresql95-contrib
/usr/pgsql-9.5/bin/postgresql95-setup initdb
systemctl enable postgresql-9.5.service
systemctl start postgresql-9.5.service
systemctl status postgresql-9.5.service

######################################################################################################################################################
yum install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-6-x86_64/pgdg-centos96-9.6-3.noarch.rpm -y
yum install postgresql96 -y
yum install postgresql96-server -y
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl enable postgresql-9.6
systemctl start postgresql-9.6

######################################################################################################################################################
# 添加用户和数据
sudo -s -u postgres
psql
CREATE USER kong WITH PASSWORD '123456';
CREATE DATABASE kong OWNER kong;
GRANT ALL PRIVILEGES ON DATABASE kong to kong;

# 执行完初始化任务之后，postgresql 会自动创建和生成两个用户和一个数据库：
linux 系统用户 postgres：管理数据库的系统用户
postgresql 用户 postgres：数据库超级管理员
数据库 postgres：用户 postgres 的默认数据库

# 新建 linux kong 用户 
sudo adduser kong

# 使用管理员账号登录 psql 创建用户和数据库
# 切换 postgres 用户 切换 postgres 用户后，提示符变成 `-bash-4.2$` 
su postgres

# 进入 psql 控制台
psql

# 此时会进入到控制台（系统提示符变为'postgres=#'）
# 先为管理员用户postgres修改密码
\password postgres        #Aa111111...

# 建立新的数据库用户（和之前建立的系统用户要重名）
create user kong with password '123456'
create user konga_database with password '123456'

# 为新用户建立数据库
create database konga_database owner konga_database;
create database kong owner kong;

# 把新建的数据库权限赋予 kong
grant all privileges on database kong to kong
grant all privileges on database konga_database to konga_database

# 退出控制台
\q

#默认  psql 不能登录
/var/lib/pgsql/9.5/data/pg_hba.conf 
vi /var/lib/pgsql/9.5/data/postgresql.conf 

# 重启数据库
systemctl restart postgresql-9.5.service

# 安装kong
wget https://bintray.com/kong/kong-rpm/rpm -O bintray-kong-kong-rpm.repo
export major_version=`grep -oE '[0-9]+\.[0-9]+' /etc/redhat-release | cut -d "." -f1`
sed -i -e 's/baseurl.*/&\/centos\/'$major_version''/ bintray-kong-kong-rpm.repo
mv bintray-kong-kong-rpm.repo /etc/yum.repos.d/
yum update -y
yum install -y kong 


cp  /etc/kong/kong.conf.default  /etc/kong/kong.conf

database = postgres 
pg_host = 127.0.0.1 
pg_port = 5432      
pg_user = kong      
pg_password = 123456
pg_database = kong  


pg_host = 10.66.252.42
pg_user = kong 
pg_password =  kong 
pg_database = kong       

./kong migrations bootstrap -c /etc/kong/kong.conf

kong migrations bootstrap [-c /path/to/kong.conf]

export KONG_ADMIN_LISTEN=0.0.0.0:8001,0.0.0.0:8444 ssl

/usr/local/bin/kong start

curl -i http://localhost:8001/
http://129.211.76.182:8001/

# konga 安装 

npm install lodash
npm install dotenv

npm install -g gulp
npm install -g bower
npm install -g sails
npm install -g grunt

npm install -g grunt
npm install konga
rm  -rf node_modules/  # 如果报错尝试删除node_modules
npm i
cnpm install konga
netstat -lntup

npm install sails-postgresql
npm install --unsafe-perm=true --allow-root sails-postgresql
npm install grunt --save-dev

curl --silent --location https://rpm.nodesource.com/setup_10.x | bash
yum -y install nodejs npm
 cnpm i pm2 -g
 vim package.json 
 npm run production
 pm2 list
 pm2 start -- run production











