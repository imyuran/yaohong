
# 定时任务管理系统
# gitlab地址 :https://github.com/ouqiang/gocron/releases
# gocron master 端口 5920 可以使用root启动
# 还需要有数据库 
# 1 * * * * * 每分钟第一秒运行
# */20 * * * * * 每隔20秒运行一次
# 0 30 21 * * * 每天晚上21:30:00运行一次
# 0 0 23 * * 6 每周六晚上23:00:00 运行一次
#!/bin/sh
[ ! -d /data/server ] && mkdir /data/server/ -p
cd /data/server/
wget  https://mirrors.linyaohong.com/klzz/gocron-v1.5.1-linux-amd64.tar.gz
wget  https://mirrors.linyaohong.com/klzz/gocron-node-v1.5.1-linux-amd64.tar.gz
tar zxvf gocron-node-v1.5.1-linux-amd64.tar.gz 
tar zxvf gocron-v1.5.1-linux-amd64.tar.gz 
ln -s /data/server/gocron-linux-amd64/ /data/gocron
ln -s /data/server/gocron-node-linux-amd64/ /data/gocron-node

cd /data/gocron/
nohup /data/gocron/gocron  web  &
# 启动agent 需要普通用户
nohup /data/gocron-node/gocron-node &
