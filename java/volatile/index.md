---
layout: default
title: Java - Volatile
folder: volatile
permalink: /archive/java/volatile/
---

# Java - Volatile

## 引出volatile

volatile 挥发性的，不稳定的

- 表示一个变量**可以**被多个线程修改。即，它实现了**共享变量的可见性**
  - 这个变量存在内存 main memory，在Java中，也就是堆 heap（不是硬盘！）
- 具体的底层实现是：禁止指令重排序，通过内存屏障 memory barrier 实现

第一点很好理解，第二点是什么意思呢，下面解释。

在解释之前，需要普及很多知识点。

## 重排序

首先要讲一个点，我们写的代码，编译成字节码指令，最终到CPU中的执行顺序，可能不是原来的顺序，
CPU可以根据需要**重排序**，从而提高效率。有人把这个称为乱序执行。

比如双核的CPU，处理如下代码：

~~~
a = long_query();
b = short_query();
~~~

CPU_1处理a，CPU_2处理b，很可能CPU_2先处理完。实际的执行顺序是这样的：

~~~
b = short_query();
a = long_query();
~~~

两个语句的顺序被颠倒了，这就是**乱序执行**。

当然，不是所有的指令都能被重排序，是有一个规则的。

参考 -> 当我们在谈论CPU指令乱序的时候，究竟在谈论什么？<https://zhuanlan.zhihu.com/p/45808885>

## 缓存一致性问题

以上的例子，是两条独立的赋值语句发生了重排序。如果，两条赋值语句都修改了同一个变量会发生什么呢？见下例：

~~~
a = 0

cmd 1: a = a + 1
cmd 2: a = a - 1
~~~

按照正常逻辑，不管cmd 1，cmd 2是什么顺序，最终a的值都应该是0。实际结果是这样吗？

### 缓存介绍

先介绍一下缓存Cache。对于现代计算机（多核CPU），数据交换的流程是，`CPU-缓存-内存`，如下：

~~~
CPU1 -> Cache1 -> Main Memory
CPU2 -> Cache2 -> Main Memory
...
~~~

Cache 由 Cache Line 组成，每个 Cache Line 是64位（根据不同架构，也可能是32位或128位），
这个Cache Line可以理解为 Cache 的最小组成单位。

### 问题分析

两个CPU分别执行上述指令，如下：

~~~
初始变量a = 0

在CPU1上，执行cmd 1，a = a + 1 = 1，数据写入到Cache1上。（还没来得及写回内存）

同时

在CPU2上，执行cmd 2，a = a - 1 = -1，数据写入到Cache2上。（还没来得及写回内存）
~~~

最终，缓存1和2的值不一致，写回内存的时候会出错。这就是**缓存一致性问题**。

也可以称为**缓存可见性问题**。因为变量a，它的值在不同缓存中互不可见，所以才导致了问题。

## 缓存一致性协议

以上问题的解决的方案，就是缓存一致性协议 cache protocol。

缓存一致性协议有很多种，可以分为两类：
- 窥探 snooping 协议
- 基于目录的 directory-based 协议

### 窥探协议

首先，要明确一个概念：CPU总线。所有CPU与内存的数据交换，都发生在这条总线上。

snooping的本质，就和它的名字一样，Cache会不停地 snoop “窥探” 总线上的数据交换，了解其它Cache在做什么。
当一个Cache代表它所属的CPU去读写内存时，其它CPU都会得到通知，以此保持Cache同步。

### MESI协议

**MESI协议属于一种窥探协议**。它有两个重要组成部分：Cache Line的状态 和 消息通知机制。

Cache Line的状态：

- Modified：有**已经被修改**的数据
- Exclusive：有**独享**的数据
- Shared：有**共享**的数据
- Invalid：数据已**失效**

消息机制：

- Read，CPU发起读请求
- Read Response，其它CPU或者内存说：读请求收到
- Invalidate，CPU发出写请求：我要独占一个Cache Line
- Invalidate ACK，其它CPU说，写请求收到，我会把自己的Cache Line置为Invalid
- Write back，把状态为Modified的Cache Line写回到内存

结合起来:
- CPU要写的时候，发起写请求`Invalidate`，然后等待其它CPU的回应
  - （如果另外一个CPU正在独占这一块数据，那写请求失败。下面也就进行不下去了）
  - 其它CPU把自己的Cache Line置为`Invalid`，然后发送`Invalidate ACK`。
  - 该CPU收到了所有的响应之后，知道自己可以独占，于是把状态置为`Exclusive`。
  - 该CPU修改完了之后，把状态置为`Modified`。
  - 最终再发送`Write back`请求，把数据写回内存。
- CPU要读的时候，发起读请求`Read`
  - 先看看其它CPU有没有处于`Modified`的状态，如果有，读修改后的值；如果没有，直接从内存中读取。
  - 把这一块的状态置为`Shared`。

打个比方，就好一群人围坐在一起喝酒，只有拿到酒瓶的人才能喝（写），其他人只能看着（读）。

但是，缓存一致性协议的工作效率不高，因为每次修改数据，都要等其它CPU的反馈。
于是，在此基础上又有了一系列的优化。

## Store Buffer + Store Forwarding

一个优化思路是，采用异步。

原来的Flow是这样的：

~~~
CPU想要写 
-> 给其它CPU发送 Invalidate 消息 
-> 等待
-> 收到其它CPU都发送的 Invalidate ACK 消息之后 
-> 将数据写进 Cache Line
~~~

改进后，在CPU和Cache之间加一个Store Buffer，
CPU想要写，给其他CPU发送消息之后，可以不用等待，而是把数据先写到**Store Buffer**，然后继续做其它事情。
等收到其它CPU发过来的响应消息，再将数据从Store Buffer移到Cache Line。

同时，如果这时候，其它CPU想要访问这个数据，直接从Store Buffer中取，而不是从Cache Line取。这个技术叫**Store Forwarding**。

Flow变成这样：

~~~
CPU想要写 
-> 给其它CPU发送 Invalidate 消息 
-> （没有等待环节）直接把数据写到 Store Buffer
-> （干其他事去了）
-> 收到其它CPU都发送的 Invalidate ACK 消息之后
-> 将数据从 Store Buffer 写进 Cache Line
~~~

但是，其实这样会有问题，待会再讲。

## Invalid Queue

失效队列

Store Buffer的大小是有限的，如果装满了怎么办？
那就不能再往里面装了，还是要等其它CPU都发送的 Invalidate ACK 消息，然后清空 Store Buffer。

这里的瓶颈在于，其它CPU处理 Invalidate ACK 太慢了。怎么优化呢？还是异步，引入一个Invalid Queue。

原先的其它CPU的Flow是这样的：

~~~
CPU 接收到消息 Invalidate
-> 将 Cache Line 的状态置为 Invalid （耗时）
-> 返回 Invalidate ACK
~~~

现在的Flow是：

~~~
CPU 接收到消息 Invalidate
-> 将这条消息放到 Invalid Queue
-> 直接返回 Invalidate ACK
-> 等有空了，处理Invalid Queue的消息，将 Cache Line 的状态置为 Invalid （耗时）
~~~

OK，效率提高了，但是这样也存在问题。下面讲。

## Memory Barrier

内存屏障

### 问题

上面谈到了 Store Buffer + Store Forwarding 以及 Invalid Queue，它们的本质都是采用了异步的形式，来提高运行效率。

但是，异步和一致性，本来就是不可兼得的。
会带来一系列问题。这里就不分析了，比较复杂，需要结合代码看时序图。

参考这里 -> 为什么需要内存屏障 <https://blog.csdn.net/chen19870707/article/details/39896655>

### 解决

解决的方法就是使用内存屏障。

内存屏障分为：
- 写屏障 Store Memory Barrier (smp_wmb)
  - 告诉处理器，先把Store Buffer处理完，再执行Barrier之后的指令
- 读屏障 Load Memory Barrier (smp_rmb)
  - 告诉处理器，先把Invalid Queue处理完，再执行Barrier之后的指令

需要注意的是，内存屏障是一个软件实现，需要程序员手动写进程序里，如下例：

~~~
void foo(void)
{
  a = 1;
  smp_mb();
  b = 1;
}
~~~

参考：

- 缓存一致性协议的工作方式 <https://zhuanlan.zhihu.com/p/123926004>
- 内存屏障的来历 <https://zhuanlan.zhihu.com/p/125549632>

## 回到 volatile

使用volatile关键字修饰之后，比如`volatile int a = 10;`，变量a直接存在内存。

多线程读写的时候，会不会存在缓存一致性问题？应该是有可能的吧。怎么办呢？加内存屏障啊！

JMM - `Java Memory Model` - `Java内存模型` 规定了四种屏障：
- LoadLoad
- StoreStore
- LoadStore
- StoreLoad

那LoadLoad为例：

~~~
读操作1
LoadLoadBarrier
读操作2
~~~

保证读操作1完了之后，才能进行读操作2，顺序不能重排。

具体的实现是：在编译成字节码时，涉及变量a的读/写操作周围会加一层内存屏障。（但其实这里采用的是Lock锁来实现的，为啥？更方便，虽然性能差一点。）

## happen-before 规则

再介绍一个概念：happen-before。JMM规定，多线程情况下，对于一个变量，读操作和写操作必须满足 happen-before 规则，否则，就会产生重排序问题。

什么是HB规则？有如下组成部分：
- 程序次序规则：一个线程内，按照代码顺序，书写在前面的操作先行发生于书写在后面的操作；
- 锁定规则：在监视器锁上的解锁操作必须在同一个监视器上的加锁操作之前执行。
- volatile变量规则：对一个变量的写操作先行发生于后面对这个变量的读操作；
- 传递规则：如果操作A先行发生于操作B，而操作B又先行发生于操作C，则可以得出操作A先行发生于操作C；
- 线程启动规则：Thread对象的start()方法先行发生于此线程的每一个动作；
- 线程中断规则：对线程interrupt()方法的调用先行发生于被中断线程的代码检测到中断事件的发生；
- 线程终结规则：线程中所有的操作都先行发生于线程的终止检测，我们可以通过Thread.join()方法结束、Thread.isAlive()的返回值手段检测到线程已经终止执行；
- 对象终结规则：一个对象的初始化完成先行发生于他的finalize()方法的开始；

说了一大堆，记住一句话就够了：当一个操作 A HB 操作 B，那么，操作 A 对共享变量的操作结果对操作 B 都是可见的。

参考 -> [Java 使用 happen-before 规则实现共享变量的同步操作](https://ifeve.com/java-%E4%BD%BF%E7%94%A8-happen-before-%E8%A7%84%E5%88%99%E5%AE%9E%E7%8E%B0%E5%85%B1%E4%BA%AB%E5%8F%98%E9%87%8F%E7%9A%84%E5%90%8C%E6%AD%A5%E6%93%8D%E4%BD%9C/)
