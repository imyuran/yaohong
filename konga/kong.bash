# https://www.jianshu.com/p/956d8f653729
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
# 新建 linux kong 用户 
sudo adduser kong
# 执行完初始化任务之后，postgresql 会自动创建和生成两个用户和一个数据库：
linux 系统用户 postgres：管理数据库的系统用户
postgresql 用户 postgres：数据库超级管理员
数据库 postgres：用户 postgres 的默认数据库
# 使用管理员账号登录 psql 创建用户和数据库
# 切换 postgres 用户 切换 postgres 用户后，提示符变成 `-bash-4.2$` 
su postgres
# 进入 psql 控制台
psql
# 此时会进入到控制台（系统提示符变为'postgres=#'）
# 先为管理员用户postgres修改密码
\password postgres        #Aa111111...
# 添加用户和数据
sudo -s -u postgres
psql
CREATE USER kong WITH PASSWORD '123456';       # 建立新的数据库用户（和之前建立的系统用户要重名）
CREATE DATABASE kong OWNER kong;                # 为新用户建立数据库
GRANT ALL PRIVILEGES ON DATABASE kong to kong;  # 把新建的数据库权限赋予 kong
# 退出控制台
\q
#默认  psql 不能登录
vi /var/lib/pgsql/9.5/data/postgresql.conf 

# 安装完以后一定要修改这里,信任登陆
vim /var/lib/pgsql/9.6/data/pg_hba.conf 
# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# 重启数据库
systemctl restart postgresql-9.5.service


# 登陆 postgres
连接参数
sudo -u postgres psql -U postgres -d postgres -h 127.0.0.1 -p 5432
简写为
sudo -u postgres psql -h 127.0.0.1 

######################################################################################################################################################
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

# 检测配置生产和生成表
kong migrations bootstrap [-c /path/to/kong.conf]
# 配置环境变量
export KONG_ADMIN_LISTEN=0.0.0.0:8001,0.0.0.0:8444 ssl
# 启动
/usr/local/bin/kong start
curl -i http://localhost:8001/
######################################################################################################################################################
# konga 安装  https://github.com/pantsel/konga#installation
git clone https://github.com/pantsel/konga.git
cd konga
cnpm install konga
# 如果报错解决方案
#######################
rm -rf node_modules
rm package-lock.json
npm cache clear --force
npm install
cnpm install konga

npm install -g gulp
npm install -g bower
npm install konga
rm  -rf node_modules/  # 如果报错尝试删除node_modules
npm i
cnpm install konga

#######################  可以换成 mysql
# 添加konga 数据持久化 用户和数据
sudo -s -u postgres
psql
CREATE USER konga WITH PASSWORD '123456';
CREATE DATABASE konga OWNER konga;                # 为新用户建立数据库
GRANT ALL PRIVILEGES ON DATABASE konga to konga;  # 把新建的数据库权限赋予 kong
sudo -u postgres psql -U konga -d konga -h 127.0.0.1 -p 5432
###########################
# 编辑konga 数据库链接信息 或者是 .env

vim config/connections.js
##
  postgres: {
    adapter: 'sails-postgresql',
    url: process.env.DB_URI,
    host: process.env.DB_HOST || 'localhost',
    user:  process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD || '123456',
    port: process.env.DB_PORT || 5432,
    database: process.env.DB_DATABASE ||'konga',
    // schema: process.env.DB_PG_SCHEMA ||'public',
    poolSize: process.env.DB_POOLSIZE || 10,
    ssl: process.env.DB_SSL ? true : false // If set, assume it's true                '
  },
###














