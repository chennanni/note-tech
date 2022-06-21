---
layout: default
title: Elasticsearch
folder: elasticsearch
permalink: /archive/elasticsearch/
---

# Elasticsearch

Elasticsearch是一个开源的 高扩展的 分布式 全文检索引擎。

- 全文检索：将每一个字段存入索引，使其可以被快速检索到。(Elasticsearch 在 Lucene 的基础上进行封装，实现了分布式搜索引擎。)
- 分布式：分布式架构，保证数据稳定性和可用性。(Elasticsearch 也是 Master-slave 架构，也实现了数据的分片和备份。)
- 高扩展：可以扩展到上百台服务器，处理PB级别数据。

可以把ES与MYSQL类比，它是一个具有强大搜索能力的数据存储应用。（但是，对于Txn没有很好的处理能力，即读强写弱）

## Elasticsearch v.s. MYSQL 

~~~
Elasticsearch  --   MySQL
---------------------------------------
Index          --   Database
Type           --   Table
Document       --   Row
Field          --   Column
Mapping        --   Schema
Query DSL      --   SQL
GET http://    --   SELECT * FROM ...
PUT http://    --   UPTABLE TABLE SET ...
~~~

## 应用

Elasticsearch 一个典型应用就是 ELK 日志分析系统。

1. 新浪ES 如何分析处理32亿条实时日志 http://dockone.io/article/505 
2. 阿里ES 构建挖财自己的日志采集和分析体系 http://afoo.me/columns/tec/logging-platform-spec.html 

## ELK

ELK = Elasticsearch + Logstash + Kibana 

- Elasticsearch：后台分布式存储以及全文检索 
- Logstash: 日志加工、“搬运工” 
- Kibana：数据可视化展示。 

ELK架构为数据分布式存储、可视化查询和日志解析创建了一个功能强大的管理链。 三者相互配合，取长补短，共同完成分布式大数据处理工作。

## 实战

安装
- 下载并解压文件

启动
- bin/elasticsearch (http://localhost:9200)
- bin/kibana (http://localhost:5601)

Add

~~~ json
PUT http://localhost:9200/movies/movie/1
{
    "title": "The Godfather",
    "director": "Francis Ford Coppola",
    "year": 1972
}
~~~

Update

~~~ json
PUT http://localhost:9200/movies/movie/1
{
    "title": "The Godfather",
    "director": "Francis Ford Coppola",
    "year": 1972,
    "genres": ["Crime", "Drama"]
}
~~~

Query

~~~
GET http://localhost:9200/movies/movie/1
~~~

Delete

~~~
DELETE http://localhost:9200/movies/movie/1
~~~

- [Elasticsearch环境安装配置](https://www.yiibai.com/elasticsearch/elasticsearch_installation.html)
- [Elasticsearch入门教程](https://www.yiibai.com/elasticsearch/elasticsearch-getting-start.html)

## Link

- [Elasticsearch学习，请先看这一篇](https://blog.csdn.net/achuo/article/details/87865141)
- [Elasticsearch原理讲透](https://developer.51cto.com/art/201904/594615.htm)
