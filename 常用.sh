Linux检测IP的端口是否打开
[root@test01 ~]# nmap 10.10.10.190  -p 3306
# 查看端口是否打开,如果打开为open状态,
批量检查网段脚本
#!/bin/bash
ip=10.10.10.
for n in `seq 1 254`
do
ping -c 2 $ip$n &> /tmp/day11.log
  if (($?==0))
  then
    echo "$ip$n 在线"
    nmap ${ip}${n} | grep open
  fi
done

Linux下查看文件编码
[root@test01 /backup]# file all.sql 
all.sql: UTF-8 Unicode text, with very long lines, with CRLF, LF line terminators

Linux下快速设置主机名
hostnamectl  set-hostname nginx_lua
bash

yum只下载不安装：yumdownloader
yum install yum-utils -y
yumdownloader subversion #只下载subversion 不安装

Linux磁盘分区和挂载

fdisk -l
fdisk /dev/vdb                                           # 根据上面命令显示的磁盘名称  //分区
mkfs.ext4 /dev/vdb1                                      # 格式化 或者xfs格式
mount /dev/vdb1 /www                                     # 挂载
echo '/dev/vdb1 /www ext4 defaults 0 0' >> /etc/fstab    # 开机自挂载

#EXT3 
（1）最多只能支持32TB的文件系统和2TB的文件，实际只能容纳2TB的文件系统和16GB的文件 
（2）Ext3目前只支持32000个子目录 
（3）Ext3文件系统使用32位空间记录块数量和i-节点数量 
（4）当数据写入到Ext3文件系统中时，Ext3的数据块分配器每次只能分配一个4KB的块
#EXT4 
EXT4是Linux系统下的日志文件系统，是EXT3文件系统的后继版本。 
（1）Ext4的文件系统容量达到1EB，而文件容量则达到16TB 
（2）理论上支持无限数量的子目录 
（3）Ext4文件系统使用64位空间记录块数量和i-节点数量 
（4）Ext4的多块分配器支持一次调用分配多个数据块 
#XFS 
（1）根据所记录的日志在很短的时间内迅速恢复磁盘文件内容 
（2）采用优化算法，日志记录对整体文件操作影响非常小 
（3） 是一个全64-bit的文件系统，它可以支持上百万T字节的存储空间 
（4）能以接近裸设备I/O的性能存储数据

脚本中含有空格处理方法

sed -i "s/\r//"   filename

手动清理Linux内存

sync      #首先把内存中的数据写入硬盘
echo 1 > /proc/sys/vm/drop_caches          #可以设置的值分别为1.2.3 们所表示的含义为：
#---------------------
echo 1 > /proc/sys/vm/drop_caches:表示清除 pagecache
echo 2 > /proc/sys/vm/drop_caches:表示清除回收 slab 分配器中的对象（包括目录项缓存和 inode 缓存,slab 分配器是内核中管理内存的一种机制，其中很多缓存数据实现都是用的pagecache
echo 3 > /proc/sys/vm/drop_caches:表示清除 pagecache 和 slab 分配器中的缓存对象。

修改系统字符集

echo $LANG
locale -a   #系统可以支持的语言
locale      #当前系统的语言环境 

export LANG=zh_CN.utf8 
LANG     #系统主要语系
LC_ALL   #系统整体语系

修改系统环境字符集
Cenos7：
[root@yunsu_daoyi ~]# vim  /etc/locale.conf
LANG="zh_CN.UTF-8"
[root@yunsu_daoyi ~]# source /etc/locale.conf
Centos6：
vim  /etc/profile
export LANG=zh_CN.utf8 
source /etc/profile  #使设置生效
[root@t1 ~]# cat /etc/sysconfig/i18n #修改文件，也是一种方案
LANG="en_US.UTF-8"

linux 文件系统（inode和block）

磁盘-分区-格式化 （创建文件系统：会创建一些inoede和bolck）
使用ls -lih命令：-i是显示出索引节点、第一列：是索引节点，inode的号码
inode    #存放文件属性和block的地址
block    #存放文件内容 存储空间，存放数据，1k 2k 4k(ext4)
centos6：256字节（ll命令查看到的东西，文件属性信息，都在inode里存着，但是不包含文件名,文件名不在inode里面，在上一级的block里面）
         还包含指向文件实体的指针功能(相当于指向block)
df      #查看block
df -i   #查看inode使用量  

案例一：
假如磁盘空间马上满了，占用最大的是web日志，删除10G的web日志后,磁盘并不能立即有10G的空间
这个时候需要重启web进程释放，才能获取磁盘空间
还有一种可能：当一个文件被某一个进程引用时,删除文件并没有真正被删除、和Linux删除文件原理有关系
案例二：
df -h  还有剩余空间  但是磁盘写入不了东西,磁盘空间已满,这个时候大概是inode满了

服务器禁Ping的方法
 

临时方法：
vim /proc/sys/net/ipv4/icmp_echo_ignore_all    # 0 为允许 ping，1 为禁止 ping，无需重启服务器
永久方法：
net.ipv4.icmp_echo_ignore_all = 1              #/etc/sysctl.conf，在文件末尾增加一行  0 表示允许，1 表示禁止。
sysctl -p

锁定系统重要的文件、当有需要再打开

[root@test01 ~]# chattr +i /etc/passwd /etc/shadow /etc/group /etc/gshadow /etc/inittab /etc/rc.d/rc.local   #锁定
[root@test01 ~]# lsattr /etc/passwd /etc/shadow /etc/group /etc/gshadow /etc/inittab /etc/rc.d/rc.local      #解锁 

修改登陆系统后的提示语

[root@template ~]# cat /etc/motd 
weclome to TEST Liuux
Please do not modify the file

Linxu中查看当前系统的语言环境

locale
[root@yunsu_daoyi ~]# cat /etc/locale.conf       #CentOS7
LANG="en_US.UTF-8"
[root@t1 ~]# cat /etc/sysconfig/i18n             #CentOS6
LANG="en_US.UTF-8"

Linxu中的环境变量：

环境变量：
[root@localhost /home/log]# cat /etc/bashrc
[root@localhost /home]# vim  ~/.bashrc
[root@localhost /home]# vim  /etc/profile
#全局环境变量：/etc/profile
也可以单独定义自己的环境变量，在/etc/profile.d/下面创建自己的环境变量。
[root@mail home]# cat /etc/profile.d/test.sh 
....
PS1="\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h \[\e[31;40m\]\w\[\e[0m\]]\\$ " 
.....
没什么卵用、写脚本可以用

Selinux：

[root@test01 ~]# setenforce 0     临时关闭SELinux
setenforce: SELinux is disabled

[root@test01 ~]# getenforce       查看SELinux状态
Disabled

CentOS 图形化网络配置 nmtui (玩玩就算了、工作中不建议使用)

[root@zabbix ~]# nmtui
NetworkManager is not running  #首先需要依赖NetworkManager

NetworkManager

Centos6中，生产环境下 我们一般都是手动配置网络，以静态地址为主不需要系统的网络管理工具，往往会出现在KDE环境中，因此，我们就会将它禁用掉，命令：
# /etc/init.d/NetworkManager stop 此命令只能临时关闭而不是永久关闭；

 永久关闭，则用命令：
# chkconfig NetworkManager off 用来永久关闭，生产环境常禁用状态
Centos7版本中关闭NetworkManager命令是与6版本的关闭命令还是有很多区别的，关闭命令为：

# systemctl stop NetworkManager 临时关闭

# systemctl disable NetworkManager 永久关闭网络管理命令
 
TCP状态
[root@web ~]# netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a,S[a]}'
CLOSE_WAIT 3
ESTABLISHED 7
TIME_WAIT 11

SYN_RECV          # 一个连接请求已经到达，等待确认
ESTABLISHED       # 正常数据传输状态/当前并发连接数
FIN_WAIT2         # 另一边已同意释放
ITMED_WAIT        # 等待所有分组死掉
CLOSING           # 两边同时尝试关闭
TIME_WAIT         # 另一边已初始化一个释放
LAST_ACK          # 等待所有分组死掉

HISTIGNORE 历史记录相关 

export HISTIGNORE="ls:l:pwd:ll"
export HISTTIMEFORMAT="%F %T"

#历史记录中忽略ls l pwd ll命令
#history显示格式：   60  2019-06-03 22:51:22 cd /

#HISTCONTROL有以下的选项:(永久生效添加到环境变量)
HISTCONTROL=ignoredups       # 默认，忽略重复命令
HISTCONTROL=ignorespace      # 忽略所有一空格开头的命令
HISTCONTROL=erasedups        # 删除重复命令
HISTCONTROL=ignoreboth       # ignoredups 和 ignorespace 的组合

查看硬件产品名称 
[root@zabbix ~]# dmidecode|grep "Product Name"
	Product Name: Alibaba Cloud ECS
[root@web01 ~]# dmidecode |grep "Name"
	Product Name: VMware Virtual Platform
	Product Name: 440BX Desktop Reference Platform
	Manufacturer Name: Intel
 
查看CPU相关 
#查看cpu详细信息
[root@zabbix ~]# lscpu
查看cpu总核数
[root@340 ~]# grep processor /proc/cpuinfo |wc -l
8
查看CPU个数
[root@340 ~]# grep 'physical id' /proc/cpuinfo|sort|uniq|wc -l
1
查看CPU型号
[root@340 ~]# grep name /proc/cpuinfo 
model name	: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
.....

Xshell sftp上传与下载
sftp:/root> lcd e:\   #设置下载路径
Local directory is now e:\
sftp:/root> get /data/wwwroot/mirrors/tools/sqlyog_x64.zip  #下载

sftp:/root> cd /root/ #切换上传路径
sftp:/root> put  #上传
 
观察文件夹下文件的变动
watch -n 1 ls    #-n 1    1秒刷新一次

CentOS 7 使用systemctl 补全服务全名称 
1、 yum install -y bash-completion
2、 退出bash、重新登录即可

#实现效果：当使用systemctl 再使用tab键可以提示有哪些使用方法，比如：status start stop enable mask unmask 等等
#systemctl status fire +tab 还可以补全服务名称、有的时候不好用，不知道哪里的问题、

快速生成一个 n 大小的文件
[root@web01 ~]# dd if=/dev/zero of=/tmp/cache bs=1M count=100
100+0 records in
100+0 records out

[root@web01 ~]# ls -lh  /tmp/cache 
-rw-r--r-- 1 root root 100M Jun 28 14:54 /tmp/cache

系统中的UUID
[root@test01 ~]# blkid     #可以查看系统中磁盘的UUID   fsatb开机自动挂载可以使用UUID，而不使用磁盘名称(了解)
/dev/sda1: UUID="3b8004b0-abb3-49da-9f60-ce03004e1fda" TYPE="xfs" 
/dev/sda2: UUID="bnAY3C-4Spf-lXtT-xZ08-qdGR-sJEj-MZ4i2I" TYPE="LVM2_member" 
/dev/sr0: UUID="2016-12-05-13-55-45-00" LABEL="CentOS 7 x86_64" TYPE="iso9660" PTTYPE="dos" 
/dev/mapper/cl-root: UUID="ab5bfc20-f0a4-4bff-a408-80c14982de3d" TYPE="xfs" 
/dev/mapper/cl-swap: UUID="73f7a748-e21d-4720-8c39-c68b3ced372d" TYPE="swap"


# 第一列，并没有使用磁盘作为挂载，而是使用的UUID
0 0 分别代表 不备份 和 fsck将不会检查该文件系统

[root@moban ~]# cat /etc/fstab 

#
# /etc/fstab
# Created by anaconda on Tue Jul 17 20:06:03 2018
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/cl-root     /                       xfs     defaults        0 0
UUID=71adb9a3-87d1-4317-b0c0-b4347d78bc3e /boot                   xfs     defaults        0 0
/dev/mapper/cl-swap     swap                    swap    defaults        0 0

当普通用户环境变量出现问题的时候
-bash-4.1 $  [命令行显示不正常]
可以执行如下命令
[aaaaa@moban skel]$ set |grep  -i ps1
[aaaaa@moban skel]$ cp  /etc/skel/.bash* ~/