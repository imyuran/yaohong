


nohup /data/kibana-web/bin/kibana &

/usr/local/zookeeper/bin/zkServer.sh start

/usr/local/kafka/bin/kafka-server-start.sh  -daemon /usr/local/kafka/config/server.properties 


#重启logstash
systemctl restart logstash

# 测试zookeeper
/usr/local/kafka/bin/kafka-topics.sh --zookeeper 100.98.233.12:2181 --list
#  日志收集filebeate
cd /data/
wget  https://mirrors.huaweicloud.com/filebeat/6.2.3/filebeat-6.2.3-x86_64.rpm
rpm -ivh filebeat-6.2.3-x86_64.rpm 
systemctl enable filebeat
systemctl list-unit-files|grep filebeat


# 检测filebeat语法是否正确
/usr/share/filebeat/bin/filebeat -c /etc/filebeat/filebeat.yml

# logstatsh检测语法
/usr/share/logstash/bin/logstash --path.settings /etc/logstash -f /etc/logstash/conf.d/ac.vipthink.cn.conf --config.test_and_exit


# 通过 Zookeeper 去查看
/usr/local/kafka/bin/kafka-console-consumer.sh --zookeeper 100.98.233.12:2181  --topic access_ac_vipthink --from-beginning
 
# 通过 Kafka 本身去查看
/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server 100.98.233.12:2181 --topic efang --from-beginning
 
# 如果不想从头看，就把 --from-beginning 去掉，也就是从最新的开始看