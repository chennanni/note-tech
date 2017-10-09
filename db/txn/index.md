---
layout: default
title: DB - Transaction
folder: txn
permalink: /archive/db/txn/
---

# DB - Transaction

> 事务的概念来自于两个独立的需求：并发数据库访问，系统错误恢复。可以看做是一个工作单元的一系列SQL语句的集合。

## 事务的特性

ACID

- 原子性（Atomicity）：要么全部完成，要么全部不完成
- 一致性（Consistency）：事务将数据库从一种一致状态转变为下一种一致状态。也就是说，事务在完成时，必须使所有的数据都保持一致状态（各种 constraint 不被破坏）
- 隔离性（Isolation）：当多个事务同时进行时,它们之间应该互相不干扰，一个事务的影响在该事务提交前对其他事务都不可见
- 持久性（Durability）：在事务完成以后，该事务对数据库所作的更改便持久的保存在数据库之中

## 事务控制

有四个命令用于控制事务

- COMMIT：提交更改
  - 会将自上次 COMMIT 命令或者 ROLLBACK 命令执行以来所有的事务都保存到数据库中
- ROLLBACK：回滚更改
  - 只能撤销自上次 COMMIT 命令或者 ROLLBACK 命令执行以来的事务
- SAVEPOINT：在事务内部创建一系列可以 ROLLBACK 的还原点
- SET TRANSACTION：命名事务
  - 可以用来初始化数据库事务，指定随后的事务的各种特征（只读或者读写）

## 异常情况

脏读（Dirty Read）
- 脏读指的是一个事务允许读取其他正在运行的事务还没有提交的改变
- 主要因为没有加锁

不可重复读（Nonrepeatable Read）
- 不可重复读指的是一个事务内连续读却得到不同的结果，主要因为同时有其他事务更新了我们正在读取的数据
- 针对Update

幻想读（Phantom Read）
- 事务在操作过程中进行两次查询，第二次查询的结果包含了第一次查询中未出现的数据
- 因为在两次查询过程中有另外一个事务插入数据造成的
- 针对Insert和Delete

## 隔离级别

SQL事务隔离级别由弱到强分别是
- READ_UNCOMMITTED 未提交读
  - 即使没有Commit，其它事物也可以读到
  - 允许脏读
- READ_COMMITTED 已提交读
  - 只有Commit了之后，其它事物才可以读到
  - 不允许脏读，但会出现非重复读
  - 一般数据库默认该级别
- REPEATABLE_READ 可重复读
  - 在同一个事务里面先后执行同一个查询语句的时候，得到的结果是一样的
  - 不允许脏读，不允许非重复读，但是会出现幻象读
- SERIALIZABLE 串行读
  - 这个事务执行的时候不允许别的事务并发执行。完全串行化的读，每次读都需要获得表级共享锁，读写相互都会阻塞
  - 不允许不一致的异常

## 锁

- 基本锁
  - 共享锁(S锁)：用于只读操作(SELECT)，锁定共享的资源。不会阻止其他用户读，但是阻止修改
  - 排他锁(X锁)：也叫独占锁，和其它任何锁都不兼容。排它锁用于数据修改，当资源上加了排他锁时，不能被其它事务读取和修改
- 意向锁
  - 意向共享锁（IS）：表示该表中的某个行被加上了S锁
  - 意向排他锁（IX）：表时该表中的某个行上被加上X锁
  - 共享意向排他锁（ISX）：表示先对某个表加上S锁，然后再加上X锁。表示要读取整个表的数据，但是只对其中的一部分行做修改
  - 如果我们要封锁表的某个行，则也在该行所在的表上加上锁，表示这个表里有的行被锁了

Oracle 锁机制
- 共享锁（S）：仅允许其它事务查询被锁定的表，防止其它事务更新该表或加RX，SRX
  - Lock Table TableName In Share Mode;
- 排他锁（X）：禁止其它事务执行其它任何DML类型的语句或在该表上加任何其它类型的锁
  - Lock Table TableName In Exclusive Mode;
- 行级共享锁（RS）：允许其它事务查询、插入、更新、删除或同时在同一张表上锁定行。不允许其它事务加X
  - Lock TABLE TableName In Row Share Mode;
- 行级排他锁（RX）：允许其它事务查询、插入、更新、删除或同时在同一张表上锁定行。不允许其它事物加S，X，RX
  - Lock Table Tablename In Row Exclusive Mode;
- 共享行级排他锁（SRX）：不允许其它事务更新该表或加X，RS，RX，SRX
  - Lock Table TableName In Share Row Exclusive Mode;

## 隔离级别的实现

~~~ sql
Oracle

ALTER SESSION SET ISOLATION_LEVEL = READ COMMITTED / SERIALIZABLE;

MySQL

SET [SESSION | GLOBAL] TRANSACTION ISOLATION LEVEL {READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE}
~~~

Read Uncommited
- 读不加锁
- 写不加锁
Read Committed
- 读取数据的事务允许其他事务继续访问该行数据，但是未提交的写事务将会禁止其他事务读取该行数据
- 读加 表级排他锁RX，读完立即释放
- 写加 行级共享锁RS，直到事务结束才释放

Repeatable Read
- 读取数据的事务将会禁止写事务（但允许读事务），写事务则禁止任何其他事务
- 读加 行级排他锁RX，读完立即释放
- 写加 行级排他锁RX，直到事务结束才释放

Serializable
- 禁止其它事务读写
- 读加 表级共享锁 S，直到事务结束才释放
- 写加 表级排他锁 X，直到事务结束才释放

## Links

- <http://www.jianshu.com/p/4e3edbedb9a8>
- <https://hit-alibaba.github.io/interview/basic/db/Transaction.html>
- <https://tech.meituan.com/innodb-lock.html>
- <http://blog.csdn.net/liuyiy/article/details/25005393>
