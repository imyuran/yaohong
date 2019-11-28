# confluence [抗复嗯死] -- wiki
# 以做技术博客,发送文章,下面评论,点赞.也可以作为公司内部的团队协作软件，在线编辑word，execel，ppt等
# Wiki组成：
java
mysql
confluence

# 官网 
https://www.atlassian.com/software/confluence/download-archives
# Confluence序列号生成器
https://gitee.com/zhubiaook/soft/tree/master/confluence
# 下载
http://www.confluence.cn/pages/viewpage.action?pageId=6722516

# 安装文档
# https://www.cnblogs.com/zhubiao/p/9735519.html

# 创建数据库
create database confluence default character set utf8 collate utf8_bin;
# 创建用户
grant all on confluence.* to 'confluence'@'%' identified by '123456'

chmod +x atlassian-confluence-6.7.1-x64.bin
 ./atlassian-confluence-6.7.1-x64.bin
 # 根据提示安装
 # 安装完成以后 访问 ip+8090 安装 最终获取到 服务器ID B8GZ-9SU1-9YVS-WXIVI

# 备份如下包，并且重新命名为：atlassian-extras-2.4.jar 下载到本地
 /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.3.0.jar

# 到mac上运行破解工具对atlassian-extras-2.4.jar 进行破解
# 生产序列号

上传破解后atlassian-extras-2.4.jar包到/usr/local/atlassian/confluence/confluence/WEB-INF/lib，并重命名atlassian-extras-decoder-v2-3.3.0.jar
解压confluence破解工具.rar包，上传mysql驱动文件mysql-connector-java-5.1.44-bin.jar 到目录/usr/local/atlassian/confluence/confluence/WEB-INF/lib

# 参考博文
# https://www.cnblogs.com/zhubiao/p/9735519.html
# https://www.cnblogs.com/heaven-xi/p/11147073.html 