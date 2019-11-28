# This docker file uses the centos image
# VERSION 1
# Base image

FROM yaohong/python-ssh:v1
#FROM yaohong/python-ssh

# Maintainer
MAINTAINER linyaohong 122123498@qq.com

# Run user
RUN useradd -s /sbin/nologin -M www

# Add files
ADD app.py /opt/app.py
ADD requirements.txt /opt/
ADD supervisord.conf /etc/supervisord.conf
ADD app-supervisor.ini /etc/supervisord.d/app.ini

# Install pag
RUN  /usr/bin/pip2.7 install -r /opt/requirements.txt

# Port
EXPOSE 22 5000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

# docker build -t yaohong/app-api:v1 .
# docker run  -d --name myapp -p 88:5000 -p 8022:22  yaohong/app-api:v1 
