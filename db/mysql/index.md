---
layout: default
title: DB - Mysql
folder: mysql
permalink: /archive/db/mysql/
---

# DB - Mysql

使用`yum`安装步骤如下：

~~~
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
sudo yum install mysql-server
~~~

参考 -> <https://www.cnblogs.com/julyme/p/5969626.html>

## 验证

~~~
// 启动
sudo service mysqld start
sudo service mysqld restart

// 登录
mysql -h localhost -uroot -p
mysql --host=172.19.183.52 --port=3306 -u root -p

// 切换数据库
use mysql;

// 查看基本信息
select host,user from user;
show databases;
show tables;

// 修改密码
update user set password=password('123456') where user='root';
~~~

## 配置 - 绑定IP

默认MySQL是起在localhost上的，也就是127.0.0.1，为了和Hive协同工作，我们可能需要让它起在特定的IP上，比如服务器内网IP：172.19.183.99。

我们需要修改MySQL的配置文件：`my.cnf`，一般位于系统`/etc`目录下。

~~~
# 加上以下内容
port = 3306
bind-address=172.19.183.99
~~~

重启

~~~
shell > service mysqld restart
shell > service mysqld status
shell > netstat -tunlp
~~~

参考 -> mysql 绑定内网ip <https://blog.csdn.net/qq_25385555/article/details/91047856>

## 配置 - 创建权限

然后，我们要在MySQL中给添加的IP创建访问权限。

~~~
mysql> CREATE USER 'root'@'172.19.183.99' IDENTIFIED BY '123456';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.19.183.99' WITH GRANT OPTION;
mysql> flush privileges;
~~~
