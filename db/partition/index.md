---
layout: default
title: DB - Partition
folder: basic
permalink: /archive/db/partition/
---

# Horizontal Partitioning

## What

Also known as "Sharding". (分表)

Horizontal partitioning involves putting different rows into different tables. Each partition forms part of a shard, which may in turn be located on a separate database server or physical location. 

![horizontal-partitioning](img/horizontal-partitioning.png)

## Advantage

分表主要解决数据量过大造成的查询效率低下的问题。

- the number of rows in each table is reduced which improves search performance.
- if shards are based on geo-locations, application may re-direct queries based on regions, which improves performance.
- you can use more cheaper, "lower-end" machines to host your data on, instead of one big server, which might not suffice anymore.

## When

db撑不住了，performance差
- records很多，（多少量级？）
- qps很高，（多少量级？）

## How

db层面，需要做分割，（Sharding Strategy?）

应用层方面，需要做导流

## Deploy

停机部署法

双写部署法

- [分库分表后如何部署上线](https://www.cnblogs.com/rjzheng/p/9597810.html)

# Vertical Partitioning

## What

Proper "Normalization" is one form of vertical partitioning. (分库)

Vertical partitioning involves creating tables with fewer columns and using additional tables to store the remaining columns. 

![vertical-partitioning](img/vertical-partitioning.jpg)

分库主要是从业务逻辑层面出发，将一个大表拆成多个内联的小表，或者进一步去耦合，将关联度低的不同表存储在不同的数据库。

## Advantage

分库主要是提高高并发下，数据库的写入能力。

## Reference

- [数据库分库分表思路](https://www.cnblogs.com/butterfly100/p/9034281.html)
