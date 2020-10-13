---
layout: default
title: Web Framework - Spring MVC
folder: mvc
permalink: /archive/spring/mvc/
---

# Web Framework - Spring MVC

## Flow

![mvc_dispatcherServlet](img/mvc_dispatcherServlet.png)

Request -> Front Dispatcher (Dispatcher Servlet) -> Controller , process (DB access) , return View

## Thread Safe Issue

Spring MVC:
- 默认 controller 是 Singleton 的，即单例，多个request进来，会共用一个 controller 处理，可能出现线程安全问题。需要注意，尽量不要使用类变量；如果一定要使用，可以使用`ThreadLocal`修饰。
- 另外，可以配置修改`scope="prototype"`，每次请求都创建新的 controller ，就不会出现线程安全问题。

Struts 1: 继承Servlet，可能会出现线程安全问题。

Struts 2: 改进之后，每次request创建新的Action Class，不会出现线程安全问题。

参考 -> <https://blog.csdn.net/qq_32575047/article/details/78997488>

## High Concurrency Issue

有一个问题：Spring MVC是单例的，高并发情况下，如何保证性能的？

个人理解：首先，单线程不代表一定“慢”，多线程不代表一定“快”，多线程存在着线程切换开销。
其次，我们要分析系统的瓶颈在哪？是在control层，还是在业务逻辑处理，还是在DB读写。
然后，我们要看这些逻辑所在的类是写在哪里，是单线程还是多线程的。最后综合分析。

- 比如，数据库读写部分特别慢，那就可以在后面做优化，考虑使用多线程将数据切分为很多片段同时写入。
- 比如，业务逻辑处理特别慢，需要调用某个外部公司提供的API参与计算，一直卡在那，于是可以考虑在controller层使用多例或者多线程，提高响应。
- 甚至，我们可以在一个机器起多个Java进程，或者采用分布式，在多个机器起多个Java进程。

参考 -> <https://www.cnblogs.com/areyouready/p/7780893.html>

## Links

- <http://docs.spring.io/docs/Spring-MVC-step-by-step>
- <http://www.journaldev.com/3531/spring-mvc-hibernate-mysql-integration-crud-example-tutorial>
