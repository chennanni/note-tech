---
layout: default
title: Redis - Cache
folder: cache
permalink: /archive/redis/cache/
---

# Redis - Cache

## 缓存过期

set key expire time

## 缓存淘汰

delete expire key

- 定期删除策略:比如，每隔一段时间（100ms）扫描一遍所有的（或者常见的情况是，随机挑选10%的）key，将过期的删除
- 惰性删除策略：一旦遇到查询请求，发现一个key已经过期了，将其删除
- 其它策略：如下

~~~
noeviction：返回错误，不会删除任何键值
allkeys-lru：使用LRU算法删除最近最少使用的键值
volatile-lru：使用LRU算法从设置了过期时间的键集合中删除最近最少使用的键值
allkeys-random：从所有key随机删除
volatile-random：从设置了过期时间的键的集合中随机删除
volatile-ttl：从设置了过期时间的键中删除剩余时间最短的键
volatile-lfu：从配置了过期时间的键中删除使用频率最少的键
allkeys-lfu：从所有键中删除使用频率最少的键
~~~

## 缓存穿透

查询缓存没有命中，直接query数据库

解决方案：
- 布隆过滤器，它擅长从超大的数据集中快速告诉你查找的数据存不存在；具体地说，如果算法判断不存在，则实际结果一定不存在；如果算法判断存在，则实际结果（有概率）可能存在或者不存在

## 缓存击穿

刚刚有一个热点数据到了过期时间，被删掉了，不巧的是随后就有对这个数据的大量查询请求来了，导致数据库大量压力

## 缓存雪崩

一大批同时发生的缓存击穿

解决方案：
- 键值的过期时间随机分布，而不是同时过期
- 设置了热点数据永不过期

## 参考

- <https://www.cnblogs.com/xuanyuan/p/13665170.html>
