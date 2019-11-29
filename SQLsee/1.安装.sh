 1. Mysql
 2. pt-online-schema-change
 3. Inception
 4. Sqladvisor
 5. Redis
 6. Nginx
 7. See项目

# Inception: 【in 赛 普 深】 去哪儿网开源，提供SQL语句审核、执行、回滚功能
# SQLAdvisor:【SQL 爱的var 儿 则 】  美团开源，提供分析SQL中的where条件、聚合条件、多表Join关系，输出索引优化建议
# SOAR: 【】小米开源，提供SQL启发式算法的语句优化、多列索引优化等功能


#  Mysql
[mysqld]
server-id = 100  # 不限制具体数值
log_bin = mysql-bin
binlog_format = row  # 或 MIXED

# pt-online-schema-change
# 在线修改表结构的工具
yum install -y perl-DBI perl-DBD-mysql perl-Time-HiRes perl-ExtUtils-MakeMaker
wget https://www.percona.com/get/percona-toolkit.tar.gz
tar -zxvf percona-toolkit.tar.gz
cd percona-toolkit-3.1.0/
perl Makefile.PL
make
make install
ln -s /usr/local/bin/pt-online-schema-change /usr/bin/

# bison 语法分析器生成器
yum -y install cmake libncurses5-dev libssl-dev g++ bison gcc gcc-c++ openssl-devel ncurses-devel mysql MySQL-python
wget http://ftp.gnu.org/gnu/bison/bison-2.5.1.tar.gz
tar -zxvf bison-2.5.1.tar.gz
cd bison-2.5.1
./configure
make
make install
#  Inception: 去哪儿网开源，提供SQL语句审核、执行、回滚功能
cd /usr/local/
wget https://github.com/myide/inception/archive/master.zip
unzip master.zip
cd inception-master/
sh inception_build.sh builddir linux

# 创建文件 /etc/inc.cnf ,内容如下

[inception]
general_log=1
general_log_file=inc.log
port=6669
socket=/tmp/inc.socket 
character-set-client-handshake=0 
character-set-server=utf8 
inception_remote_system_password=123456 
inception_remote_system_user=root 
inception_remote_backup_port=3306 
inception_remote_backup_host=127.0.0.1 
inception_support_charset=utf8 
inception_enable_nullable=0 
inception_check_primary_key=1 
inception_check_column_comment=1 
inception_check_table_comment=1 
inception_osc_min_table_size=1 
inception_osc_bin_dir=/usr/bin 
inception_osc_chunk_time=0.1 
inception_ddl_support=1
inception_enable_blob_type=1 
inception_check_column_default_value=1 

# 3.3 启动服务
nohup /usr/local/inception-master/builddir/mysql/bin/Inception --defaults-file=/etc/inc.cnf &

# https://blog.csdn.net/eagle89/article/details/80079766

# 安装 Sqladvisor

cd /usr/local/src/
git clone https://github.com/Meituan-Dianping/SQLAdvisor.git

yum install -y cmake libaio-devel libffi-devel glib2 glib2-devel bison
# 移除mysql-community库(无用途且和Percona-Server有冲突)
yum remove -y mysql-community-client mysql-community-server mysql-community-common mysql-community-libs

yum -y remove mariadb-libs
yum install -y  percona-release
yum install perl

wget http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm -O /tmp/percona-release-0.1-3.noarch.rpm
rpm -ivh /tmp/percona-release-0.1-3.noarch.rpm
# OR
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-Server-shared-56
# ln -s libperconaserverclient_r.so.18 libperconaserverclient_r.so 

# 验证
[root@VM_32_73_centos lib64]# find / -name "*perconaserverclient_r*"
/usr/lib64/libperconaserverclient_r.so.18.1.0
/usr/lib64/libperconaserverclient_r.so.18
/usr/lib64/libperconaserverclient_r.so
/usr/lib64/libperconaserverclient_r.so.18.0.0


cd /usr/local/src/SQLAdvisor/
cmake -DBUILD_CONFIG=mysql_release -DCMAKE_BUILD_TYPE=debug -DCMAKE_INSTALL_PREFIX=/usr/local/sqlparser ./
make && make install

cd ./sqladvisor/
cmake -DCMAKE_BUILD_TYPE=debug ./
make

#  完成测试
cp /usr/local/src/SQLAdvisor/sqladvisor/sqladvisor /usr/bin/sqladvisor
sqladvisor -h 127.0.0.1  -P 3306  -u root -p '123456' -d test -q "select user,host from mysql.user"" -v 1















cp libpython3.6m.so.1.0 /usr/local/lib64/
cp libpython3.6m.so.1.0 /usr/lib/ 
cp libpython3.6m.so.1.0 /usr/lib64/
————————————————





wget https://mirrors.linyaohong.com/Yearning-2.1.6.1.linux-amd64.zip
unzip Yearning-2.1.6.1.linux-amd64.zip 
cd Yearning-go/
[root@VM_32_73_centos Yearning-go]# cat conf.toml 
[Mysql]
Db = "yearning"
Host = "127.0.0.1"
Port = "3306"
Password = "123456"
User = "root"

[General]
SecretKey = "dsadfvdsfa9fasfd"
./Yearning -m




https://github.com/cookieY/inception-document/blob/master/docs/install.md




./Yearning -s -b "https://oapi.dingtalk.com/robot/send?access_token=5012efa23c5b08a0357bd76241d7ca0cb1b12084855a703c58d9af0346e03a53" -p "8000"

docker run -d -it -p8000:8000 -e MYSQL_USER=root -e MYSQL_ADDR=10.104.32.73:3306 -e MYSQL_PASSWORD=123456 -e MYSQL_DB=Yearning --name yearning yearning


pip install -r requirements.txt --trusted-host mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/