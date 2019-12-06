 cat >>/etc/docker/daemon.json <<-'EOF'
{
"registry-mirrors": ["https://i80iz2o3.mirror.aliyuncs.com"]
"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]
}
EOF


# docker 修改了容器以后提交到新的镜像
docker commit -m "myappv2"  b4eb7bcceae8  yaohong/app-api:v2  #  容器id  提交到  新的镜像yaohong/app-api:v2

# namespace
https://www.cnblogs.com/sparkdev/p/9365405.html
# linux进程管理
https://www.cnblogs.com/yanjieli/p/9539588.html

# docker private registry  docker私有仓库
harbor   docker私有仓库

docker 启动限制cpu和内存
# https://blog.csdn.net/candcplusplus/article/details/53728507
# 500M
docker run -m 1G

# OOM killer

#  默认情况下，在出现 out-of-memory(OOM) 错误时，系统会杀死容器内的进程来获取更多空闲内存。这个杀死进程来节省内存的进程，我们姑且叫它 OOM killer。
#  我们可以通过设置--oom-kill-disable选项来禁止 OOM killer 杀死容器内进程。
但请确保只有在使用了-m/--memory选项时才使用--oom-kill-disable禁用 OOM killer。
#  如果没有设置-m选项，却禁用了 OOM-killer，可能会造成出现 out-of-memory 错误时，系统通过杀死宿主机进程或获取更改内存


docker pull lorel/docker-stress-ng  # 压测镜像

docker stats # 显示容器使用资源的情况
docker top  容器名称  # 显示容器的top情况

docker pull lorel/docker-stress-ng   #首先下载镜像
docker run  --name stress -it  --rm -m 512m  lorel/docker-stress-ng stress --vm 2  # 启动镜像测试内存

#测试用例
docker run  --name stress -it  --rm -m 256m --cpus 1 lorel/docker-stress-ng stress --vm 2 --cpu 8 # 启动镜像测试内存和cpu
docker run  --name stress -it  --rm -m 256m --cpuset-cpus 0,2 lorel/docker-stress-ng stress --vm 2 --cpu 8 # 启动镜像测试内存和cpu

