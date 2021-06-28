---
layout: default
title: Kafka
folder: kafka
permalink: /archive/kafka/
---

# Kafka

## 定义

Kafka 是一个分布式、分区的、多副本的、多订阅者，基于zookeeper协调的分布式**日志系统**，也可以当做**消息系统**，常见可以用于web/nginx日志、访问日志，消息服务等等。

## 特点

Kafka主要设计目标如下：

- 高效，处理速度快
  - 以时间复杂度为O(1)的方式提供消息持久化能力，即使对TB级以上数据也能保证常数时间的访问性能。
- 支持分布式，水平扩展
  - 可以应对大数据的处理需求。

## Kafka 与 Zookeeper

简单地理解，Kafka 的分布式，很大程度上是通过 Zookeeper 来实现的：

- 例1：多个 Broker 之间的同步，Leader 和 Follower 的选举。
- 例2：Topic 分 Partion 在整个系统中如何存储。
- 例3：Consumer 如何负载均衡地从 Cluster 上拿消息。

详细参考如下：

- Kafka的高可用 <https://www.cnblogs.com/qingyunzong/p/9004703.html>
- Kafka在zookeeper中的存储 <https://www.cnblogs.com/qingyunzong/p/9007107.html>

## 安装

以下演示在 linux 环境安装的过程。

### Download

~~~
wget https://archive.apache.org/dist/kafka/0.11.0.0/kafka_2.11-0.11.0.0.tgz
~~~

### Unzip

~~~
tar -xvf kafka_2.11-0.11.0.0.tgz -C kafka/
~~~

### Change Server Config

`vim ~/.bash_profile`

~~~
export KAFKA_HOME=$HOME/kafka/kafka_2.11-0.11.0.0
export PATH=$PATH:$KAFKA_HOME/bin
~~~

`source ~/.bash_profile`

### Change Kafka Config

`vim $KAFKA_HOME/server.properties`

~~~
log.dirs=/root/logs/kafka-logs
zookeeper.connect=hadoop000:2181
~~~

## 使用

### Start Kafka Server

`./kafka-server-start.sh -daemon $KAFKA_HOME/config/server.properties`

然后，可以使用`jps`查看新启动的进程：

~~~
7214 Kafka
~~~

### Start Zookeeper

启动服务：`zkServer.sh start`

查看状态：`zkServer.sh status`

### Create Kafka Topic

`./kafka-topics.sh --create --zookeeper hadoop000:2181 --replication-factor 1 --partitions 1 --topic maxkafka`

结果 ->

~~~
Created topic "maxkafka".
~~~

### Create Producer

新开一个窗口，命令：`./kafka-console-producer.sh --broker-list hadoop000:9092 --topic maxkafka`

->

(ready to send)

~~~
> hello world
> kafka
>
~~~

### Create Consumer

新开一个窗口，命令：`./kafka-console-consumer.sh --zookeeper hadoop000:2181 --topic maxkafka`

->

(listening)

~~~
> hello world
> kafka
>
~~~

在 Producer 窗口中发送一个消息，在 Consumer 窗口中就可以收到。

