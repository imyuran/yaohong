# Shipyard -- Docker可视化管理工具安装与配置   作者已停止更新

# Shipyard使用到的数据库，用于数据存储
docker pull docker.io/rethinkdb
# 使用Swarm管理Docker集群
docker pull docker.io/swarm
# Shipyard镜像
docker pull docker.io/shipyard/shipyard

docker run -ti -d \
 --restart=always \
 --name shipyard-rethinkdb \
 -p 8082:8080 \
 -p 28015:28015 \
 -p 29015:29015 \
 -v /data/rethinkdb:/data \
 docker.io/rethinkdb:latest