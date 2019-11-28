# This docker file uses the centos image
# VERSION 1
# Base image docker pull  centos:7.4.1708
FROM centos:7.4.1708
# Maintainer
MAINTAINER linyaohong 122123498@qq.com

# EPEL
ADD  epel-7.repo    /etc/yum.repos.d

# Base pak
RUN yum -y install wget git tree sudo net-tools
RUN yum -y install mysql-devel redis
RUN yum -y install supervisor  
RUN yum -y install psmisc 
RUN yum -y install openssl-devel openssh-clients  openssh-server 
RUN yum clean all

# For SSHD
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN echo "root:123456"|chpasswd


#创建镜像
# docker build -t yaohong/centos74-ssh:v1 .