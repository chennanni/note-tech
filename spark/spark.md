---
layout: default
title: Spark
folder: spark
permalink: /archive/spark/
---

# Spark

https://spark.apache.org/
https://spark.apache.org/downloads.html

# What
“Apache Spark是专为大规模数据处理而设计的快速通用的**计算引擎** 。现在形成一个高速发展应用广泛的生态系统。”

# Feature
- 分布式计算框架
	- “高级 API 剥离了对集群本身的关注，Spark 应用开发者可以专注于应用所要做的计算本身。”
- 快
	- “Spark 很快，支持交互式计算和复杂算法。”
- 通用
	- “Spark 是一个通用引擎，可用它来完成各种各样的运算，包括 SQL 查询、文本处理、机器学习等”

# Language
- scala
- java
- python
- sql

# Build
Output: a jar should be generated.

## sbt

refer to -> https://www.scala-sbt.org/1.x/docs/Hello.html

~~~ shell
sbt clean package
~~~

(note: sbt udpate may take a long time, use another vpn)

## maven

~~~ shell
maven clean package
~~~

# Run

~~~ shell
spark-submit --class "My_Class_Name" my_jar_location.jar
~~~

refer to -> https://blog.csdn.net/TxyITxs/article/details/105886445

# Reference
- https://spark.apache.org/docs/latest/quick-start.html