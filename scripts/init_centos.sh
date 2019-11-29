#!/bin/sh
#安装常用的软件包
yum  -y install wget

wget -O /etc/yum.repos.d/epel.repo  http://mirrors.aliyun.com/repo/epel-7.repo
wget -O /etc/yum.repos.d/CentOS-Base.repo  http://mirrors.aliyun.com/repo/Centos-7.repo  
# yum makecache

yum -y install gcc gcc-c++ 
yum -y install iftop iotop sysstat 
yum -y install screen lsof lrzsz vim bzip2 
yum -y install telnet tree nmap  
yum -y install libevent-devel  libevent
yum  -y install git 

yum -y install python-devel  python-pip 
pip install --upgrade pip
# bash补全包
yum install bash-completion -y

# Close SELINUX
setenforce 0
sed -i 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config

#set sshd_config
sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/' /etc/ssh/sshd_config

# set rsyslog
systemctl enable rsyslog

# Custom profile
cat >> /etc/profile << EOF
TMOUT=6000
HISTSIZE=10000
HISTFILESIZE=5
PS1="\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h \[\e[35;40m\]\W\[\e[0m\]]\\\\$ "
HISTTIMEFORMAT="%F %T \$(whoami) "
alias l='ls -AFhlt'
alias lh='l | head'
alias ll='ls -l -h -i --color=auto --time-style=long-iso'
GREP_OPTIONS="--color=auto"
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
EOF

# /etc/security/limits.conf
[ -e /etc/security/limits.d/*nproc.conf ] && rename nproc.conf nproc.conf_bk /etc/security/limits.d/*nproc.conf
sed -i '/^# End of file/,$d' /etc/security/limits.conf
cat >> /etc/security/limits.conf <<EOF
# End of file
* soft nproc 1000000
* hard nproc 1000000
* soft nofile 1000000
* hard nofile 1000000
EOF

# /etc/hosts
[ "$(hostname -i | awk '{print $1}')" != "127.0.0.1" ] && sed -i "s@127.0.0.1.*localhost@&\n127.0.0.1 $(hostname)@g" /etc/hosts

# Set timezone
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#Set en  Centos7
sed -i 's@LANG=.*$@LANG="en_US.UTF-8"@g' /etc/locale.conf

#set sysctl.conf
cat > /etc/sysctl.conf << EOF
# es
vm.max_map_count = 262144
fs.file-max=1000000
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096 87380 4194304
net.ipv4.tcp_wmem = 4096 16384 4194304
net.ipv4.tcp_max_syn_backlog = 16384
net.core.netdev_max_backlog = 32768
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_fin_timeout = 20
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_syncookies = 1
#net.ipv4.tcp_tw_len = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.ip_local_port_range = 1024 65000
net.nf_conntrack_max = 6553500
net.netfilter.nf_conntrack_max = 6553500
net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_established = 3600
EOF
sysctl -p
source /etc/profile

# Update time
if [ -e "$(which ntpdate)" ]; then
  ntpdate -u pool.ntp.org
  [ ! -e "/var/spool/cron/root" -o -z "$(grep 'ntpdate' /var/spool/cron/root)" ] && { echo "*/20 * * * * $(which ntpdate) -u pool.ntp.org > /dev/null 2>&1" >> /var/spool/cron/root;chmod 600 /var/spool/cron/root; }
fi

# install atop
yum -y install atop
systemctl enable atop
sed -i 's/LOGINTERVAL=600/LOGINTERVAL=30/' /etc/sysconfig/atop
systemctl start atop
# Clean up atop7 day old logs
[ ! -d /data/tools ] && mkdir -p /data/tools/
cat >/data/tools/atop_clean.sh <<EOF
rm -f \`find /var/log/atop/ -type f  -mtime +7\`
EOF
# add atop cron
if [ -e "$(which atop)" ]; then
  [ ! -e "/var/spool/cron/root" -o -z "$(grep 'atop_clean' /var/spool/cron/root)" ] && { echo "0 1 * * *  /data/tolol/atop_clean.sh > /dev/null 2>&1" >> /var/spool/cron/root;chmod 600 /var/spool/cron/root; }
fi
