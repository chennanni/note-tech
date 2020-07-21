---
layout: default
title: Redis - Basic
folder: basic
permalink: /archive/redis/basic/
---

## Redis是什么

- 基于键值（Key Value）的存储服务系统
- 性能高
- 开源

便于理解，它的替代方案一般是：DB，Gemfire等。

## 特性总结

- 基本
  - 速度快
  - 持久化
- 高并发
  - 主从复制
  - 高可用，分布式
- 兼容性
  - 支持多种数据结构
  - 支持多种编程语言
- 其它
  - 简单
  - 功能丰富

## 特性 - 速度快

速度：10w OPS

为什么快：因为数据读写是在内存中

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_fast.png" width="50%" alt="redis_fast" align=center >
![redis_fast.png](img/redis_fast.png)

## 特性 - 持久化

所有数据存储在内存中，对数据的更新将异步保存到磁盘上

具体怎么保证断点不丢数据的呢？- RDB，AOF

## 特性 - 数据结构

5种主要数据结构
- String
- Hash table
- Linked List
- Set
- Sorted Set

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_data_structure.png" width="50%" alt="redis_data_structure" align=center />

# 特性 - 功能丰富

- 发布订阅
- 事务
- pipeline
- Lua脚本

# 特性 - 主从复制

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_copy.png" width="50%" alt="redis_copy" align=center />

# 特性 - 高可用

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_availble.png" width="50%" alt="redis_availble" align=center />

## 典型适用场景

- 缓存
- 计数器
- 消息队列
- 排行榜
- 社交网络
- 实施系统

## 安装

可执行文件（bin）介绍

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_bin_1.png" width="50%" alt="redis_bin_1" align=center />
<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_bin_2.png" width="50%" alt="redis_bin_2" align=center />

最简启动

~~~
src/redis-server
~~~

动态参数启动

~~~
src/redis-server --port 6380
~~~

配置文件启动

~~~
src/redis-server configPath
~~~

查看启动情况

~~~
ps -ef | grep redis
redis-cli -h [ip] -p [port] ping
~~~

使用

~~~
$ src/redis-cli
redis> set foo bar
OK
redis> get foo
"bar"
~~~

## Redis客户端返回值

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_feedback_1.png" width="50%" alt="redis_feedback_1" align=center />

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_feedback_2.png" width="50%" alt="redis_feedback_2" align=center />

## 常用配置

~~~
daemonize yes
port 6382
dir "/Users/Max/Applications/redis-6.0.5/data"
logfile "6382.log"
~~~

<img src="https://github.com/chennanni/note-tech/blob/master/redis/basic/img/redis_config.png" width="50%" alt="redis_config" align=center />
