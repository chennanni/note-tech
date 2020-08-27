---
layout: default
title: Hadoop - HDFS
folder: hdfs
permalink: /archive/hadoop/hdfs/
---

# Hadoop - HDFS

## 概述

HDFS是一个分布式的文件系统。
1. 分布式
2. 使用廉价的机器 commodity hardware
3. 高容错 fault-tolerant
4. 高吞吐 high throughput
5. 支持大文件 large data sets

什么是文件系统？
- 主流的文件系统有两种形式：一种是Windows，一种是Unix/Linux
- 目的：存放文件或者文件夹
- 对外提供服务：创建、修改、删除、查看、移动等等

普通文件系统 v.s. 分布式文件系统
- 一种是单机
- 一种是横跨N个机器

## 设计目标

HDFS的设计，是为了解决以下问题

- Hardware Failure
- Streaming Data Access  流式数据访问
  - The emphasis is on high throughput of data access
  - rather than low latency of data access
- Large Data Sets
- Moving Computation is Cheaper than Moving Data
  - 移动计算比移动数据更划算。前者就是做一个路由，后者有拷贝数据的消耗（网络IO+硬盘IO）。

## 架构

HDFS采用master/slave的架构

- master - NameNode
  - regulates the file system namespace, determines the mapping of blocks to DataNodes
  - regulates access to files by clients, like CRUD
- slave - DataNodes
  - storage

最重要的特性：将一个文件切分为多块，然后复制多份，存放在不同机器上（HDFS默认采用3副本机制，每个blocksize=128M）

~~~
举例：X切分为3块，然后复制了三份

X -> A1, B1, C1
  -> A2, B2, C2
  -> A3, B3, C3

然后放到4个不同的机器上

M1: A1, B2, C3
M2: A2, B3
M3: A3, C1
M4: B1, C2

比如，M1挂了，但是并不会影响我们使用X，因为其它机器上还是可以拿到A，B，C的
~~~

通常情况下，1个单机部署一个组件（NameNode或者DataNode）。

- <https://hadoop.apache.org/docs/r2.9.2/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html>
