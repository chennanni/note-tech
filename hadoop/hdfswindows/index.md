---
layout: default
title: Hadoop - HDFS in Windows
folder: hdfswindows
permalink: /archive/hadoop/hdfswindows/
---

# Hadoop - HDFS in Windows

## 前言

Hadoop在Linux上面的安装相对来说简单，在Windows上面坑就多一些。

这里必须单独列一章节出来讲。因为开发环境很多都是Windows，本地测试时必须把Hadoop先搭建好，否则各种坑。

参考 -> Windows上安装运行Hadoop <https://www.cnblogs.com/chevin/p/9090683.html>

## 下载

首先，尽量保证自己装的各个软件/包的版本是一致的！（不一致的话有没有坑不好说）

### hadoop

下载地址1（更新，镜像站下载起来更快）：<https://www.apache.org/dyn/closer.cgi/hadoop/common>

下载地址2（更全）：<https://archive.apache.org/dist/hadoop/common/>

### winutils

这是Windows特有的一些执行文件，在hadoop包里面没有，需要自己编译或者下载别人已经编译好的。

<https://github.com/steveloughran/winutils>

下载下来把hadoop的/bin目录覆盖即可。

## 配置

### 环境变量

JAVA路径当然要配好，这里就省略不说了。需要注意的是，JAVA_HOME的路径不能带空格，比如Program Files！

除此之外，hadooop配置如下：

~~~
HADOOP_HOME -> D:\hadoop-2.7.1

PATH -> %HADOOP_HOME%\bin

CLASSPATH -> %HADOOP_HOME%\bin\winutils.exe
~~~

### 配置文件修改

这部分和linux差不多。文件位于：`/etc/hadoop`。

1.`core-site.xml`（配置默认hdfs的访问端口）

~~~
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>    
</configuration>
~~~

2.`hdfs-site.xml`（namenode文件路径以及datanode数据路径。）

~~~ xml
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>    
        <name>dfs.namenode.name.dir</name>    
        <value>file:/hadoop/data/dfs/namenode</value>    
    </property>    
    <property>    
        <name>dfs.datanode.data.dir</name>    
        <value>file:/hadoop/data/dfs/datanode</value>  
    </property>
</configuration>
~~~

3.`hadoop-env.cmd`

~~~
set JAVA_HOME=C:\Java\jdk1.8.0_73
~~~

4.yarn的配置先略过，简单应用来说不是必须的。

## 启动

这部分和linux也差不多。

### 初始化

进入bin目录，格式化hdfs，在cmd中运行命令`hdfs namenode -format`。

### 启停

进入sbin目录，

在cmd中运行命令`start-dfs.cmd`。

在cmd中运行命令`stop-dfs.cmd`。

### 查看

`http://localhost:50070`查看Hadoop状态。

## 错误排查

### NativeIO

我写了一个Java程序，来操作本地/远程HDFS执行MapReduce时报错如下：

~~~
java.lang.UnsatisfiedLinkError: org.apache.hadoop.io.nativeio.NativeIO$Windo
~~~

首先，保证`hadoop.dll`和`winutils`都在bin目录下，且版本一致。

然后，把以下代码放到程序里，让它强制加载bin目录下的`hadoop.dll`。
再运行程序问题就解决了。

~~~ java
static {
    try {
    	System.load("D:/Hadoop/hadoop-2.7.3/bin/hadoop.dll");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load.\n" + e);
      System.exit(1);
    }
}
~~~

参考 -> <https://blog.csdn.net/wyxeainn/article/details/81413544>