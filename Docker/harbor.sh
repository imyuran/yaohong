# Docker  Registry 
# 自己私有的仓库  docker  re届死tree
# https://hub.docker.com/

# docker compose 安装
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Harbor安装  哈波 
# gitlab地址 https://github.com/docker/compose/releases/
cd /data/
wget https://github.com/goharbor/harbor/releases/download/v1.9.3/harbor-offline-installer-v1.9.3.tgz
tar xf harbor-offline-installer-v1.9.3.tgz

# docker-compose安装
# Github源
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Daocloud镜像
curl -L https://get.daocloud.io/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/

./prepare 
./install.sh
admin/Harbor12345
cd  /data/harbor
# 关闭 配置ssl
docker-compose down 
mkdir -p /data/cert/

vim harbor.yml 
https:
#   # https port for harbor, default is 443
  port: 443
#   # The path of cert and key files for nginx
  certificate: /data/cert/fullchain.pem
  private_key: /data/cert/privkey.pem


./prepare
docker-compose down
docker-compose up -d

# 进入harbor
docker login sh-hb.vipthink.cn
Username: admin
Password: 
Login Succeeded

# 案例1

$ docker tag yaohong/app:v1 sh-hb.vipthink.cn/myapp/myapp:v1
$ docker push sh-hb.vipthink.cn/myapp/myapp:v1

#案例2
docker tag centos:7.4.1708  sh-hb.vipthink.cn/myapp/centos:7.4.1708
docker push sh-hb.vipthink.cn/myapp/centos:7.4.1708

