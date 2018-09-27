---
layout: default
title: Thread - Lock
folder: lock
permalink: /archive/thread/lock/
---

# Lock

锁的概念存在于各种编程语言中，不论是Java和还是DB，其本质也都类似。

一种最基本的分类方法为：共享锁，独享锁。除此之外还有很多其他各种划分方法。

## 共享锁 v.s. 独享锁

共享锁：该锁可被多个线程持有。一种实现是互斥锁，在Java中就是`ReadWriteLock`。读共享，写互斥。

独享锁：该锁一次只能被一个线程持有。一种实现是互斥锁，在Java中就是`ReentrantLock`。

## 公平锁 v.s. 非公平锁

公平锁：多个线程 按照 申请锁的顺序 来 获取锁。

非公平锁：多个线程 不 按照 申请锁的顺序 来 获取锁。（有可能后申请的线程比先申请的线程优先获取锁。）

举例1：`ReentrantLock`，通过构造函数指定该锁是否是公平锁，默认是非公平锁。

举例2：`Synchronized`是非公平锁。

问题：非公平锁是通过什么来分配的呢？TODO

## 分段锁

其实是一种锁的设计，将一个大的对象切分为多个小的对象，在细微粒度下加锁，即可达到并发操作这一整个对象的目的。

举例：`ConcurrentHashMap`。

## 自旋锁

尝试获取锁的线程不会立即阻塞，而是采用循环的方式不停尝试获取锁。

好处是响应速度更快，缺点是消耗性能。

[java锁的种类以及辨析（一）：自旋锁](http://ifeve.com/java_lock_see1)

## Link
- [Java中的锁分类](https://www.cnblogs.com/qifengshi/p/6831055.html)
