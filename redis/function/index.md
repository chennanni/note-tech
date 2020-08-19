---
layout: default
title: Redis - Function
folder: function
permalink: /archive/redis/function/
---

# Redis其它功能

## 慢查询

### 生命周期

![redis_fu_1](img/redis_fu_1.PNG)

慢查询发生在第三阶段，执行命令。
客户端超时的原因有很多，不一定就是慢查询导致的。

### 两个配置

配置了慢查询之后，当一个命令执行时间超过某个值（`slowlog-log-slower-than`，比如10ms）时，就会被放入一个队列中（slowlog list），这个队列的长度为`slow-log-max-len`。
这是一个先进先出的队列，它是固定长度，存在内存中。

![redis_fu_2](img/redis_fu_2.PNG)

这里引出了两个重要配置参数：

`slow-log-max-len`
- 默认值：128，通常设置：1000

`slowlog-log-slower-than`
- 单位：微秒
- =0，记录所有命令；<0，不记录
- 默认值：10000（即10ms），通常设置：1ms

修改方式有两种，可以修改配置文件重启，也可以动态配置（推荐）

~~~
config set slowlog-max-len 1000
config set slowlog-log-slower-than 1000
~~~

三个命令

- `slowlog get[n]`：获取慢查询队列
- `slowlog len`：获取队列长度
- `slowlog reset`：清空

## pipeline

## 发布订阅

## bitmap

## hyperloglog

## geo
