---
layout: default
title: DB
folder: basic
permalink: /archive/db/basic/
---

# DB

## Function 作用
数据库，是用来存储数据的。

问：那为啥不直接用Excel或者txt文本文件呢？
答：简单的场景如记自己的账，可以。但是，当数据量大，场景复杂，如银行记账，就不够用了。

一款数据库软件，要保证：
- 查询（读）方便
- 存储（写）稳定

## Relational DB 关系型数据库
- Oracle
- [[mysql]]
- [[h2]]

## NoSQL DB 非关系型数据库
- Redis
- HBase
- MongoDb
- Neo4J

![[db_nosql_list.png]]

## Concept 概念

以下是关系型数据库的一些概念，但是大部分对于非关系型数据库也适用。

### View

In database theory, a view is the result set of a stored query on the data,
which the database users can query just as they would in a persistent database collection object.

视图是一种虚拟的表，具有和物理表相同的功能。可以对视图进行增，改，查，操作，试图通常是有一个表或者多个表的行或列的子集。对视图的修改不影响基本表。它使得我们获取数据更容易，相比多表查询。

### Schema

A database schema is a way to logically group objects such as tables, views,
stored procedures etc. Think of a schema as a container of objects.

### Package

A package is a schema object that groups logically related PL/SQL types, variables,
constants, subprograms, cursors, and exceptions. A package is compiled and stored in the database, where many applications can share its contents.

### Trigger

A trigger is a special kind of stored procedure that automatically executes
when an event occurs in the database server. DML triggers execute when a user tries to modify data through a data manipulation language (DML) event. DML events are INSERT, UPDATE, or DELETE statements on a table or view.

### Sequence

Sequence will allow you to populate primary key with a unique, serialized number.

### Synonym

A synonym is an alias or alternate name for a table, view, sequence, or other schema object.

### Index

索引，参考 -> [[db/index/index]]

### Sharding

分片，参考 -> [[sharding]]

### Null

- Null表示的是未知，不确定
- Null的比较需要用`IS/IS NOT`，不能用`=/!=`
  - `select * from users where deleted_at = null;  -- no results`
  - `select * from users where deleted_at is null;  -- some results`
- 将Null值转化为其它值
  - `NVL(value,0)`
