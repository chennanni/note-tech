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

个人理解：首先，要搞清楚单例`Singleton`和单线程，这是两个不同的概念。
- 单例是指，JVM中只有一个对象，它可能被多个线程用到。
- 单线程是指，同一时间，JVM中只有一个线程在工作。

高并发的情况，（几乎）一定是使用多线程的，否则一个一个排队处理，前端页面要卡住半天不动了。而在多线程的情况下：
- 使用单例，有一个好处是，避免线程切换开销，但是需要保证的是，避免出现线程安全问题。
- 使用多例，可以保证线程安全，但是会有额外开销。而在大量请求的情况下，这种开销特别大。

综合比较来看，使用单例是更合适的解决方案。

至于线程安全，三点：
- 要么保证request是stateless无状态的，每个请求之间互不影响，不定义类变量，那各个thread都使用自己的本地变量，互不影响
- 如果实在不行request是stateful有状态的，需要定义一些类变量，那可以使用ThreadLocal类，但是会有一定额外开销
- 慎用锁！比如synchronized关键字，在高并发情况可能会阻塞

参考 -> <https://www.cnblogs.com/areyouready/p/7780893.html>

## Links

- <http://docs.spring.io/docs/Spring-MVC-step-by-step>
- <http://www.journaldev.com/3531/spring-mvc-hibernate-mysql-integration-crud-example-tutorial>
