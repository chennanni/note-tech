---
layout: default
title: Java - Monitor - Cmd
folder: monitor
permalink: /archive/java/monitor/
---

# Java - Monitor - Cmd

## 监控 JVM 运行情况

有两种类型的工具
- 图形化GUI界面：如`jvisualvm`, `jconsole`等
- 命令行Cmd工具：如`jstat`, `jstack`, `jmap`等

在开发环境，使用GUI可能看起来更直观一点。但是，在实际生产环境，使用GUI连接，会对应用的性能有影响，一般都是用命令行工具。

## jstat

它可以显示JVM的各种信息：类装载，内存，垃圾收集，JIT编译等运行数据。
常用的是查看**GC**情况。

如下：

~~~
jstat -gcutil 28934 2000 10
~~~

- 28934： Java process PID, 可以使用`jps`查看
- 2000: 每隔多少时间（2000ms）收集一次
- 10: 收集多少（10）次

结果 ->

~~~
S0     S1     E      O      M     CCS    YGC     YGCT    FGC    FGCT     GCT
0.00 100.00  92.50  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.50  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.50  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.50  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.50  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.68  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.68  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.68  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.68  11.51  96.95      -     57   18.833     1   21.911   40.744
0.00 100.00  92.68  11.51  96.95      -     57   18.833     1   21.911   40.744
~~~

有一项指标：FGC。如果数字非常大，比YGC多很多，说明发生了频繁的FGC，可能存在问题。

## jmap

一般用于生成堆转储快照，即**heapdump**。

如下：

~~~
jmap -histo 18264 | head -10
~~~

- 18264： Java process PID, 可以使用`jps`查看

结果 ->

~~~
 num     #instances         #bytes  class name
----------------------------------------------
   1:         17874    21878767104  [C
   2:          1366       23338808  [I
   3:          1842         207544  java.lang.Class
   4:          6524         156576  java.lang.String
   5:          5503         132072  java.lang.StringBuilder
   6:          1304         114752  java.lang.reflect.Method
   7:           346         113480  [B
   8:          2294         105424  [Ljava.lang.Object;
   9:           125          47000  java.lang.Thread
  10:          1195          38240  java.util.HashMap$Node
~~~

从上面，我们可以看到heap上的对象按大小排序，`[C`是指char array，`[I`是指int array。

具体参考这里：

~~~
Element Type        Encoding
boolean             Z
byte                B
char                C
class or interface  Lclassname;
double              D
float               F
int                 I
long                J
short               S 
~~~

-> <https://stackoverflow.com/questions/1087177/what-do-those-strange-class-names-in-a-java-heap-dump-mean>

## jstack

一般用于生成JVM当前线程的快照，即**threaddump**。

如下：

~~~
jstack 28934 > thread_dump_1.txt
~~~

- 18264： Java process PID, 可以使用`jps`查看

结果 ->

~~~
Full thread dump Java HotSpot(TM) 64-Bit Server VM (25.45-b02 mixed mode):

"ServerConnection on port 40404 Thread 6" #668 prio=5 os_prio=0 tid=0x00007fcb30002800 nid=0x9a1d waiting on condition [0x00007fce37ffe000]
   java.lang.Thread.State: WAITING (parking)
        at sun.misc.Unsafe.park(Native Method)
        - parking to wait for  <0x00007fd29ea652b8> (a java.util.concurrent.SynchronousQueue$TransferStack)
        at java.util.concurrent.locks.LockSupport.park(LockSupport.java:175)
        at java.util.concurrent.SynchronousQueue$TransferStack.awaitFulfill(SynchronousQueue.java:458)
        at java.util.concurrent.SynchronousQueue$TransferStack.transfer(SynchronousQueue.java:362)
        at java.util.concurrent.SynchronousQueue.take(SynchronousQueue.java:924)
        at java.util.concurrent.ThreadPoolExecutor.getTask(ThreadPoolExecutor.java:1067)
        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1127)
        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
        at org.apache.geode.internal.cache.tier.sockets.AcceptorImpl$1$1.run(AcceptorImpl.java:523)
        at java.lang.Thread.run(Thread.java:745)
~~~

## 总结

查看进程情况 `top `

查看线程情况 `top -H p[java_process_id]`

查看 heapdump `jmap -histo [java_process_id] head -20 `

查看 threaddump `jstack [java_process_id] > [thread_dump_file_name.txt]`

查看基本GC情况 `jstat -gcutil [java_process_id] [interval_in_ms] [try_times] `

查看详细GC情况 `vim [path_to_gc_log]` + 使用工具 (GCeasy) 分析

## 其他工具
- [[monitor_arthas]]
- [[monitor_visualvm]]

## 参考

- Java性能排查实战模拟 <https://www.cnblogs.com/maxstack/p/12988744.html>
- JVM 知识点 <https://gitbook.cn/books/5cda388b92757c1b0b325fd4/index.html>
- 图书 《深入理解Java虚拟机：JVM高级特性与最佳实践》
