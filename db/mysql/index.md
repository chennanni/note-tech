---
layout: default
title: DB - Mysql
folder: mysql
permalink: /archive/db/mysql/
---

# DB - Mysql in Linux

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

## 卸载

查看安装版本

~~~
rpm -qa|grep -i mysql
~~~

卸载

~~~
rpm -ev MySQL-client-5.5.25a-1.rhel5 
~~~

查找并删除残余文件

~~~
find / -name mysql
rm -rf ...
~~~

删除配置文件

~~~
rm -rf /etc/my.cnf
~~~

参考 -> https://www.cnblogs.com/nicknailo/articles/8563456.html

# DB - Mysql in Windows

以下介绍 MySQL 在 Windows 下的使用

## Setup MySQL Server

1.download and install

2.配置 环境变量 `PATH`

3.配置 `my.ini`

~~~
[mysql]
 
# 设置mysql客户端默认字符集
default-character-set=UTF8MB4 
[mysqld]
#设置3306端口
port = 3306 
# 设置mysql的安装目录
basedir = D:\mysql-8.0.26-winx64
datadir = D:\mysql-8.0.26-winx64\data
# 允许最大连接数
max_connections=200
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server=UTF8MB4
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
~~~

4.根目录下创建 `data` 文件夹
5.管理员权限打开 `cmd` ，进入到安装目录下的 `bin` 文件夹
6.命令 `mysqld --initialize-insecure`
7.命令 `mysql -install`

至此，安装完成。

- mysql server安装及配置 <https://blog.csdn.net/epyingxue/article/details/86085942>
- my.ini的详细步骤 <https://www.jb51.net/article/172172.htm>
- MYSQL报错 -- 出现Failed to find valid data directory <https://blog.csdn.net/guyue35/article/details/107828255>

## Use MySQL Server

开始使用：

- 启动服务：`net start mysql`
- 登录：`mysql -u root -p`
- 选择数据库：`use mysql`
- 停止服务：`net stop mysql`

修改密码：`ALTER USER 'root'@'localhost' IDENTIFIED BY '123';`

## Setup MySQL Workbench

Serach for MySQL Workbench; Download and install

- MySQL Workbench的使用 <https://www.cnblogs.com/hahayixiao/p/9849742.html>

## 数据库设计

工具选型

- MySQL Workbench
- DBeaver

参考

- 数据库设计工具有哪些？ <https://www.zhihu.com/question/19579837>
- 四种优秀的数据库设计工具 <https://database.51cto.com/art/202002/611381.htm>