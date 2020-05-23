---
layout: default
title: DB - Index
folder: index
permalink: /archive/db/index/
---

# DB - Index

请参考[大白话讲索引](https://www.cnblogs.com/maxstack/p/12939019.html)

## 什么是索引

Simply put, an index is a pointer to data in a table. An index in a database is very similar to an index in the back of a book.

索引是数据库中的一种数据结构，它可以加速查询。一种常见的实现是B树。

## B Tree

平衡多路查找树

一颗m阶的B树具有以下特征：

- 每个结点最多含有m个子树（m>=2）；
- 若根结点不是叶子结点，则至少有2个子树；
- 除根结点和叶子结点外，其它每个结点至少有[ceil(m / 2)]个子树；
- 所有叶子结点都出现在同一层；
- 有j个子树的非叶子节点有j-1个关键字，按增序排列。

![db-index-b-tree](img/db-index-b-tree.png)

B树的各种操作能使B树保持较低的高度，从而有效避免磁盘过于频繁的IO操作，从而提高查找效率。

<http://blog.csdn.net/v_JULY_v/article/details/6530142/>

## 索引的优缺点

优点
- 可以大大加快数据的检索速度
- 通过创建唯一性索引，可以保证数据库表中每一行数据的唯一性。
- 通过使用索引，可以在查询的过程中，使用优化隐藏器，提高系统的性能。

缺点
- 需要占用额外物理空间
- 创建和维护索引，以及对表中数据更新时，需要耗费额外时间

## 几种索引的类型

唯一索引

- 唯一索引是不允许其中任何两行具有相同索引值的索引。
- 当现有数据中存在重复的键值时，大多数数据库不允许将新创建的唯一索引与表一起保存。数据库还可能防止添加将在表中创建重复键值的新数据。例如，如果在employee表中职员的姓(lname)上创建了唯一索引，则任何两个员工都不能同姓。

单一索引与组合索引

- 单一索引：即只对于某一列(column)建立索引。
- 组合索引：即对于多列(column)建立索引。

## 怎么使用索引

- 在经常需要搜索的列上，可以加快搜索的速度；
  - 在经常需要根据范围进行搜索的列上创建索引，因为索引已经排序，其指定的范围是连续的；
  - 在经常需要排序的列上创建索引，因为索引已经排序，这样查询可以利用索引的排序，加快排序查询时间；
  - 在经常使用在WHERE子句中的列上面创建索引，加快条件的判断速度。
- 在作为主键的列上，强制该列的唯一性和组织表中数据的排列结构；
- 在经常用在连接的列上，这些列主要是一些外键，可以加快连接的速度；

## Links

- <http://blog.csdn.net/kennyrose/article/details/7532032>
- <http://www.informit.com/library/content.aspx?b=STY_Sql_24hours&seqNum=123>
