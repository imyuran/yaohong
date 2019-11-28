
# 查看topic
/data/server/kafka_2.12-2.3.0/bin/kafka-topics.sh --zookeeper 100.98.233.12:2181 --list


# 删除topic
/data/server/kafka_2.12-2.3.0/bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic prod_php_www.mixins


ES:  /data/server/elasticsearch-7.3.0/bin/elasticsearch -d
kibana:   nohup /data/server/kibana-7.3.0-linux-x86_64/bin/kibana &
zookeeper:  /data/server/kafka_2.12-2.3.0/bin/zookeeper-server-start.sh -daemon /data/server/kafka_2.12-2.3.0/config/zookeeper.properties
kafka:  /data/server/kafka_2.12-2.3.0/bin/kafka-server-start.sh -daemon /data/server/kafka_2.12-2.3.0/config/server.properties
logstash:   nohup /data/server/logstash-7.3.0/bin/logstash -f /data/server/logstash-7.3.0/config/input-kafka.conf --config.reload.automatic &

# 查看所有索引
curl 'localhost:9200/_cat/indices?v'

# ##############################

mkdir -p /data/server/
cd  /data/server/
wget https://mirrors.huaweicloud.com/elasticsearch/7.3.0/elasticsearch-7.3.0-linux-x86_64.tar.gz
wget https://mirrors.huaweicloud.com/kibana/7.3.0/kibana-7.3.0-linux-x86_64.tar.gz
wget https://mirrors.huaweicloud.com/logstash/7.3.0/logstash-7.3.0.tar.gz
wget https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.3.0/kafka_2.12-2.3.0.tgz
tar zxf elasticsearch-7.3.0-linux-x86_64.tar.gz 
tar zxf kafka_2.12-2.3.0.tgz 
tar zxf logstash-7.3.0.tar.gz 
tar zxf kibana-7.3.0-linux-x86_64.tar.gz

vm.max_map_count = 262144
sysctl -p

/data/server/elasticsearch-7.3.0/bin/elasticsearch -d
su shop

curl -XGET 'http://100.98.233.12:9200/_cluster/health?pretty' 

curl --silent --location https://rpm.nodesource.com/setup_10.x | bash
yum install -y nodejs
npm install -g cnpm --registry=https://registry.npm.taobao.org 
cnpm install -g @vue/cli
nohup /data/server/kibana-7.3.0-linux-x86_64/bin/kibana &

/data/server/kafka_2.12-2.3.0/bin/zookeeper-server-start.sh -daemon /data/server/kafka_2.12-2.3.0/config/zookeeper.properties
/data/server/kafka_2.12-2.3.0/bin/kafka-server-start.sh -daemon /data/server/kafka_2.12-2.3.0/config/server.properties

nohup /data/server/logstash-7.3.0/bin/logstash -f /data/server/logstash-7.3.0/config/input-kafka.conf --config.reload.automatic &


  log_format json '{ "@timestamp": "$time_iso8601", '
                         '"time": "$time_iso8601", '
                         '"remote_addr": "$remote_addr", '
                         '"remote_user": "$remote_user", '
                         '"http_host": "$host", '
                         '"body_bytes_sent": $body_bytes_sent, '
                         '"request_time": $request_time, '
                         '"status": $status, '
                         '"host": "$host", '
                         '"request": "$request", '
                         '"request_method": "$request_method", '
                         '"uri": "$uri", '
                         '"http_referrer": "$http_referer", '
                         '"http_x_forwarded_for": "$http_x_forwarded_for", '
                         '"http_user_agent": "$http_user_agent", '
                         '"up_addr": "$upstream_addr", '
                         '"up_status": "$upstream_status", '
                         '"up_rept": "$upstream_response_time" '
                    '}';





wget https://mirrors.huaweicloud.com/filebeat/7.3.0/filebeat-7.3.0-linux-x86_64.tar.gz
tar zxvf filebeat-7.3.0-linux-x86_64.tar.gz
ln -s /data/filebeat-7.3.0-linux-x86_64 /data/filebeat
cd filebeat

cat >restart.sh <<EOF
#!/bin/sh
echo \`ps -ef|grep filebeat|grep -v grep|awk '{print \$2}'\`
echo "start kill prometheus"
kill -9 \`ps -ef|grep filebeat|grep -v grep|awk '{print \$2}'\`
cd /data/filebeat/
rm -f  nohup.out
./filebeat &
echo starting
echo \`ps -ef|grep filebeat|grep -v grep|awk '{print \$2}'\`
EOF

chmod +x restart.sh



cat >restart.sh <<EOF
#!/bin/sh
echo \`ps -ef|grep elasticsearch|grep -v grep|awk '{print \$2}'\`
echo "start kill prometheus"
kill -9 \`ps -ef|grep elasticsearch|grep -v grep|awk '{print \$2}'\`
cd data/server/elasticsearch-7.3.0
/data/server/elasticsearch-7.3.0/bin/elasticsearch -d
echo starting
echo \`ps -ef|grep elasticsearch|grep -v grep|awk '{print \$2}'\`
EOF
chmod +x restart.sh






#!/bin/bash/
esname=es-node-01
run_user="elasticsearch"
id -u ${run_user} >/dev/null 2>&1
[ $? -ne 0 ] && useradd  -s /sbin/nologin ${run_user} 
hostnamectl set-hostname  ${esname}
yum -y install java
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat>/etc/yum.repos.d/elasticsearch.repo<<EOF
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
yum install elasticsearch
mkdir -p /data/es-data  /data/es-logs



#ELK1重启

nohup /data/node_exporter/node_exporter &

su shop
/data/server/elasticsearch-7.3.0/bin/elasticsearch -d
nohup /data/server/kibana-7.3.0-linux-x86_64/bin/kibana &


/data/server/kafka_2.12-2.3.0/bin/zookeeper-server-start.sh -daemon /data/server/kafka_2.12-2.3.0/config/zookeeper.properties
/data/server/kafka_2.12-2.3.0/bin/kafka-server-start.sh -daemon /data/server/kafka_2.12-2.3.0/config/server.properties
nohup /data/server/logstash-7.3.0/bin/logstash -f /data/server/logstash-7.3.0/config/input-kafka.conf --config.reload.automatic &

