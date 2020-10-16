---
layout: default
title: Java - Volatile
folder: volatile
permalink: /archive/java/volatile/
---

# Java - Volatile

## 引出volatile

volatile 挥发性的，不稳定的

- 保证了不同线程对这个变量进行操作时的**可见性**，即一个线程修改了某个变量的值，这新值对其他线程来说是立即可见的。
- 禁止进行指令**重排序**。

第一点很好理解，第二点是什么意思呢，下面解释。

在解释之前，需要普及很多知识点。

参考了 -> 细说 Volatile <https://gitbook.cn/books/5db54b448190041c0d50b530/index.html#volatile>

## 指令重排序

首先要讲一个点，我们写的代码，编译成字节码指令，最终到CPU中的执行顺序，可能不是原来的顺序，
CPU可以根据需要**重排序**，从而提高效率。也有人把这个称为**乱序执行**。

比如如下代码：

~~~
a = a + 1;  // 语句1
b = b + 1;  // 语句2
a = a * 2;  // 语句3
~~~

我把语句2和语句3的顺序换下，这样，CPU可以一次性把a的值处理完，效率提高了。

当然，不是所有的指令都能被重排序，是有一个规则的。

参考 -> 当我们在谈论CPU指令乱序的时候，究竟在谈论什么？<https://zhuanlan.zhihu.com/p/45808885>

## 并发编程的三个概念

### 原子性

原子性：一个操作（或者多个操作），要么全部执行（并且执行的过程不会被任何因素打断），要么就都不执行。

比如`a = b + c;`，这一句话，在翻译成字节码（或者更底层的语言）后，会变成多个指令，如下：

~~~ 
步骤1：读取 b 的值
步骤2：读取 c 的值
步骤3：将 b 与 c 的值相加，赋值给 a
~~~

在多线程的情况下，有可能发生如下情形，线程1的操作的原子性就被打破了。

~~~ 
（线程1）步骤1：读取 b 的值
---------------------------
（线程2）给 c 重新赋值
---------------------------
（线程1）步骤2：读取 c 的值
（线程1）步骤3：将 b 与 c 的值相加，赋值给 a
~~~

### 可见性

可见性：当多个线程访问同一个变量时，一个线程修改了这个变量的值，其他线程能够立即看得到修改的值。

~~~
int i = 0;

//线程1
i = 10;
 
//线程2
i++;
~~~

如果没有可见性，线程2执行完，值就是1。
如果有可见性，线程2执行完，值就是11。

### 有序性

有序性：程序执行的顺序按照代码的先后顺序执行。

我们知道CPU会对指令进行重排序，这在单线程情况下没有什么问题，但是多线程情况下可能就有问题了。

如下所示，线程1会先`loadContext()`，然后将flag置为true，线程2会一直等flag，直到变化了，才开始`startProcess(context)`。
如果语句1和语句2顺序颠倒，对于线程2来说，可能会出错，即没有初始化完成就开始处理。

~~~
//线程1
context = loadContext();   //语句1
inited = true;             //语句2
 
//线程2:
while(!inited){
  sleep();
}
startProcess(context);
~~~

所以，要想并发程序正确地执行，必须要保证原子性、可见性以及有序性。只要有一个没有被保证，就有可能会导致程序运行不正确。

## 缓存一致性问题

以上的例子，是两条不相关的语句发生了重排序。如果，两条语句都用到了同一个变量会发生什么呢？见下例：

~~~
a = 0

cmd 1: a = a + 1
cmd 2: b = a
~~~

这种情况下，cmd 1和cmd 2可以重排吗？

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

在CPU1上，先执行cmd 1
从内存读取a到Cache1上，Cache1_a = 0
然后进行计算，a = a + 1 = 1
将数据写回到Cache1上，Cache1_a = 1
（还没来得及写回内存）

同时

在CPU2上，执行cmd 2
从内存读取a到Cache2上，Cache2_a = 0
然后进行计算，b = a = 0
一路将b写回到内存上

b=0
~~~

最终的结果，好像是把cmd 2和cmd 1的顺序颠倒了（发生了重排序）。

~~~
a = 0
cmd 2: b = a = 0
cmd 1: a = a + 1 = 1
~~~

另外，再思考，如果cmd 1执行得再快一点，数据及时写回内存，那是不是结果又不一样了？

这就是**缓存一致性问题**。（在上例中，缓存1和缓存2的中a的值不一致。）
也可以称为**缓存可见性问题**。（在上例中，缓存1和缓存2中的a互不可见。）

以上问题的解决的方案，有两种：
- 锁总线
  - 简单粗暴，同一时间，只能有一个CPU和内存进行数据交换，也就只有一个缓存，也就不存在缓存不一致了
  - 但是这样开销也很大，把多核玩成了单核，浪费资源
- 锁缓存
  - 把锁的粒度更细化一点，放在缓存级别。也就是缓存一致性协议 cache protocol

## 缓存一致性协议

缓存一致性协议有很多种，可以分为两类：
- 窥探 snooping 协议
- 基于目录的 directory-based 协议

### 窥探协议

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

但是，异步和一致性，本来就是不可兼得的。会带来一系列问题。简单描述如下：

以Store Buffer为例，Invalid Queue也是类似的：

~~~
CPU1要对a进行写操作，把值存在Store Buffer里面，记为CPU1_SB_a = 1。

然后，CPU2要对a进行读操作，会直接读CPU1_SB_a的值（由于Store Forwarding），这里没有问题。

但是CPU3，之前已经读取过a的初始值，还在缓存中，记为CPU3_a = 0。而CPU1给它的Invalidate消息，它还没来得及处理。
这时，CPU3又碰到一个读取a的指令，返回的值就是CPU3_a = 0。（因为缓存还未失效）

所以，CPU1的Store Buffer的值，和CPU3的缓存的值，就不一致了。
~~~

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

## 小结

重排序是一种现象。有的时候是好的，有的时候是不好的。

多核CPU，从硬件设计的角度上来说，存在缓存一致性问题，有可能会带来不好的重排序现象。

为了解决这个问题，可以使用总线锁（但是代价太大），也可以使用缓存锁（缓存一致性协议）。

为了优化缓存一致性协议，还使用了Store Buffer + Store Forwarding，以及Invalid Queue技术。
同时，必须搭配使用Memory Barrier技术（需要从软件层面实现）。

所以，编程语言，应该都（多多少少）实现了内存屏障，包括Java。

## Java 的 happen-before 规则

承接上面说的，Java是怎么应对缓存一致性问题（重排序问题）的呢？

JMM - `Java Memory Model` - `Java内存模型` 规定，多线程情况下，对于一个变量，读操作和写操作必须满足 happen-before 规则，否则，就会产生重排序问题。

什么是HB规则？有如下组成部分：
- 程序次序规则：一个线程内，按照代码顺序，书写在前面的操作先行发生于书写在后面的操作；
- 锁定规则：在监视器锁上的解锁操作必须在同一个监视器上的加锁操作之前执行。
- volatile变量规则：对一个变量的写操作先行发生于后面对这个变量的读操作；
- 传递规则：如果操作A先行发生于操作B，而操作B又先行发生于操作C，则可以得出操作A先行发生于操作C；
- 线程启动规则：Thread对象的start()方法先行发生于此线程的每一个动作；
- 线程中断规则：对线程interrupt()方法的调用先行发生于被中断线程的代码检测到中断事件的发生；
- 线程终结规则：线程中所有的操作都先行发生于线程的终止检测，我们可以通过Thread.join()方法结束、Thread.isAlive()的返回值手段检测到线程已经终止执行；
- 对象终结规则：一个对象的初始化完成先行发生于他的finalize()方法的开始；

说了一大堆，记住一句话：当一个操作 A HB 操作 B，那么，操作 A 对共享变量的操作结果对操作 B 都是可见的。

参考 -> [Java 使用 happen-before 规则实现共享变量的同步操作](https://ifeve.com/java-%E4%BD%BF%E7%94%A8-happen-before-%E8%A7%84%E5%88%99%E5%AE%9E%E7%8E%B0%E5%85%B1%E4%BA%AB%E5%8F%98%E9%87%8F%E7%9A%84%E5%90%8C%E6%AD%A5%E6%93%8D%E4%BD%9C/)

## 回到 volatile

`volatile`也要遵循 HB 原则，具体怎么操作呢？加内存屏障啊！

JMM规定了四种屏障：

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

