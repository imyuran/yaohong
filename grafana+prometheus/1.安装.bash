###########################################################################################################################################################################################

# prometheus 主程序，主要是负责存储、抓取、聚合、查询方面
# Prometheus   普罗米修斯
# https://github.com/prometheus/prometheus/releases
# 端口：9090

cd /data/server/
wget https://github.com/prometheus/prometheus/releases/download/v2.14.0/prometheus-2.14.0.linux-amd64.tar.gz
tar zxf prometheus-2.14.0.linux-amd64.tar.gz 
ln  -s  /data/server/prometheus-2.14.0.linux-amd64 /data/prometheus
cd /data/prometheus/

# 重启脚本
cat >restart.sh <<EOF
#!/bin/sh
echo \`ps -ef|grep /data/prometheus|grep -v grep|awk '{print \$2}'\`
echo "start kill prometheus"
kill -9 \`ps -ef|grep prometheus|grep -v grep|awk '{print \$2}'\`
cd /data/prometheus/
nohup /data/prometheus/prometheus --web.enable-lifecycle --config.file="/data/prometheus/prometheus.yml"  --storage.tsdb.retention.time=180d &
echo starting
echo \`ps -ef|grep prometheus|grep -v grep|awk '{print \$2}'\`
EOF
chmod +x restart.sh
# 启动
./restart.sh
# 可以远程热加载配置文件，无需重启prometheus
curl -X POST http://localhost:9090/-/reload  


###########################################################################################################################################################################################

# grafana
# 端口 3000
# Grafana是一个可视化面板(Dashboard),有着非常漂亮的图表和布局展示,功能齐全的度量仪表盘和图形编辑器
# 支持Graphite、zabbix、InfluxDB、Prometheus等数据源

yum install initscripts fontconfig -y
yum install -y urw-fonts
cd /data/server/
wget https://mirrors.huaweicloud.com/grafana/6.4.0/grafana-6.4.0-1.x86_64.rpm
rpm -Uvh  grafana-6.4.0-1.x86_64.rpm
# vim /etc/grafana/grafana.ini  /可以修改监听端口和bind的ip
systemctl start grafana-server.service
systemctl status grafana-server.service

# 安装pie插件
官网：https://grafana.net/plugins/grafana-piechart-panel 

#查询可用的插件
grafana-cli plugins list-remote 

# 安装zabbix插件
grafana-cli plugins install alexanderzobnin-zabbix-app

# 安装其他面板插件
grafana-cli plugins install grafana-clock-panel
grafana-cli plugins install grafana-piechart-panel
grafana-cli plugins install raintank-worldping-app
grafana-cli plugins install jasonlashua-prtg-datasourc
grafana-cli plugins install jasonlashua-prtg-datasource 
grafana-cli plugins install grafana-worldmap-panel

# grafana模版下载
https://grafana.com/grafana/dashboards


###########################################################################################################################################################################################
# agent端安装  node_exporter
# 端口 9100
# 监控linux主机的node_exporter
cd /data/server/
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar zxf node_exporter-0.18.1.linux-amd64.tar.gz
ln -s /data/server/node_exporter-0.18.1.linux-amd64 /data/node_exporter
cd /data/node_exporter/

cat >restart.sh <<EOF
#!/bin/sh
echo \`ps -ef|grep /data/node_exporter|grep -v grep|awk '{print \$2}'\`
echo "start kill /data/node_exporter"
kill -9 \`ps -ef|grep /data/node_exporter|grep -v grep|awk '{print \$2}'\`
cd /data/node_exporter/
nohup /data/node_exporter/node_exporter &
echo starting
echo \`ps -ef|grep /data/node_exporter|grep -v grep|awk '{print \$2}'\`
curl localhost:9100/metrics|grep node_memory_MemFree
EOF
chmod +x restart.sh
./restart.sh


###########################################################################################################################################################################################
# 下载监控MySQL的mysqld_exporter
# 9104
cd /data/server/
wget  https://github.com/prometheus/mysqld_exporter/releases/download/v0.12.1/mysqld_exporter-0.12.1.linux-amd64.tar.gz
tar -zxf  mysqld_exporter-0.12.1.linux-amd64.tar.gz
ln -s /data/server/mysqld_exporter-0.12.1.linux-amd64  /data/mysqld_exporter
cd /data/mysqld_exporter/
vim .my.cnf 
# 添加如下配置 */
[client]
port=3306
user=mysql_monitor
password=mysql_monitor

# 在要监控的数据库里配置账号  localhost 和 内网段 最好都配置一下
mysql> CREATE USER 'mysql_monitor'@'localhost' identified by 'mysql_monitor'; 
mysql> GRANT REPLICATION CLIENT, PROCESS ON *.* TO 'mysql_monitor'@'localhost'; 
mysql> GRANT SELECT ON performance_schema.* TO 'mysql_monitor'@'localhost';

# 启动
cd /data/mysqld_exporter/
nohup   ./mysqld_exporter --config.my-cnf=.my.cnf --web.listen-address=":9105"   & 


###########################################################################################################################################################################################

# 下载redis_exporter
wget https://github.com/oliver006/redis_exporter/releases/download/v0.30.0/redis_exporter-v0.30.0.linux-amd64.tar.gz
tar -zxvf  redis_exporter-v0.30.0.linux-amd64.tar.gz

# 启动redis_exporter

# redis无密码 */
nohup  ./redis_exporter -redis.addr=192.168.56.118:6379 -web.listen-address 0.0.0.0:9121  &
# redis有密码  */
nohup  ./redis_exporter -redis.addr=192.168.56.118:6479 -redis.password 123456   -web.listen-address 0.0.0.0:9122 & 

#  可以自定义监控端口 /**   
 -web.listen-address 
