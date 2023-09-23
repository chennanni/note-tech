---
layout: default
title: Thread - Executor
folder: executor
permalink: /archive/thread/executor/
---

# Thread - Executor

## 什么是Executor

> An object that executes submitted Runnable tasks. This interface provides a way of decoupling task submission from the mechanics of how each task will be run, 
including details of thread use, scheduling, etc. An Executor is normally used instead of explicitly creating threads.

Executor是一个对象，用来执行Runnable/Callable任务。并且它能将任务的提交和任务的执行解耦。
我们知道，Thread的创建和销毁的开销不小，在大量运用Thread的场景下，反复创建和销毁Thread是非常浪费资源的。那么在多线程编程时，势必需要考虑如何进行优化。
Executor框架很好地解决了这个问题。它可以统一创建线程，并把它当作一种资源来动态调配。

所以，我们只需要关心
- 在一开始如何配置Executor
- 需要执行什么样的任务

至于任务如何被分配执行，Thread资源如何调度，就不需要多操心了。

## Executor组成

Executor框架主要包含三个部分:

- 执行任务的资源：包括Executor框架的核心接口Executor以及其子接口ExecutorService
- 任务：包括Runnable和Callable，其中Callable表示一个会产生结果的任务
- 异步计算的结果：包括接口Future和其实现类FutureTask

![executor-uml.png](img/executor-uml.png)

## Executor API

Executor接口

~~~ java
// execute method: to handle normal task
public interface Executor {
    void execute(Runnable command);
}
~~~

ExecutorService接口：有三个线程池的核心实现类

- SingleThreadExecutor:使用单线程执行任务
- FixedThreadPool:可以限制当前线程数量。适用于负载较重的服务器环境
- CachedThreadPool:适用于执行很多短期异步任务的小程序，适用于负载较轻的服务器

~~~ java
// submit method: to execute task with return values
<T> Future<T>   submit(Callable<T> task)
Future<?>       submit(Runnable task)
<T> Future<T>   submit(Runnable task, T result)

// constructor
public static ExecutorService newSingleThreadExecutor();
public static ExecutorService newFixedThreadPool(int nThreads);
public static ExecutorService newCachedThreadPool();
~~~

ScheduledExecutorService接口：可以在给定的延迟时间后执行命令，或者定期执行命令

- ScheduledThreadPoolExecutor

~~~ java
// schedule method
<V> ScheduledFuture<V>	schedule(Callable<V> callable, long delay, TimeUnit unit)

// constructor
public static ScheduledExecutorService newScheduledThreadPool(int corePoolSize);
~~~

Future接口：用来表示异步计算的结果，可以对其进行取消，查询是否取消，查询是否完成，查询结果等操作

- FutureTask

## 举例


交错打印两个字符串

~~~ java
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

public class ExecutorTest {
    public static void main(String[] args) {
        Runnable hello = () -> {
            for (int i = 0; i < 100; i++) {
                System.out.println(i + " hello");
            }
        };
        Runnable bye = () -> {
            for (int i = 0; i < 100; i++) {
                System.out.println(i + " bye");
            }
        };
        Executor executor = Executors.newCachedThreadPool();
        executor.execute(hello);
        executor.execute(bye);
    }
}
~~~

## TODO

## 链接
- <https://www.cnblogs.com/micrari/p/5634447.html>
- <https://www.cnblogs.com/MOBIN/p/5436482.html>
