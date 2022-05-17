---
layout: default
title: Computer - Cache Coherency
folder: cache
permalink: /archive/computer/cache/
---

# Computer - Cache Coherency

## CPU的存储结构

CPU运行速度非常快，而主内存相对来说很慢，因此CPU并不直接访问主内存，两者之间有多次缓存结构。

~~~
  CPU
   |
L1 Cache
   |
L2 Cache
   |
L3 Cache
   |
Main Memory
~~~

## 引出一致性问题

如果多个CPU共享一个Cache，那从数据正确性角度没有问题，但是这样处理效率低下，因为多个CPU要争抢一个缓存。

所以，实际的设计是每个CPU有自己单独的Cache。如下：

~~~
CPU1 - Cache 1 - Main Memory
CPU2 - Cache 2 - Main Memory
...
~~~

但是，这样会有一个问题：Cache 1和Cache 2同时修改一个变量，那么到底谁说了算呢？这就是一致性问题。

## 一致性问题的解决思路

一致性问题的本质是两个人竞争同一个资源，怎么办？

解决方案，有人总结说是3种，笔者认为是2.5种吧。

**排队**：排好队，先到先得。实现是各种锁，屏障等等。

**投票**：多个人可以同时发表意见，最后投票表决听谁的。实现是分布式系统中常见的Paxos和Raft算法。

**避免**：把一个资源复制多份，分给每个人，然后大家就可以自己玩自己的了。实现是Java的ThreadLocal。
（笔者认为，这个只能算半个方法，因为最后多个拷贝汇总起来还是会有竞争问题，所以ThreadLocal没有做汇总的功能）

参考 -> 什么是ThreadLocal <https://juejin.im/post/6844904197524029447#heading-10>

## 缓存一致性问题分析

这里对缓存一致性问题作出具体分析。

举个例子：两个CPU分别执行指令，如下：

~~~
a = 0

CPU 1 -> cmd 1: a = a + 1
CPU 2 -> cmd 2: b = a
~~~

按照正常思路，一种可能的结果是：

~~~
cmd 1先执行完，然后执行cmd 2

结果

a = 1
b = 1
~~~

另外，还有一种可能的执行过程如下：

~~~
在CPU1上，先执行cmd 1
从内存读取a到Cache1上，Cache1_a = 0
然后进行计算，a = a + 1 = 1
将数据写回到Cache1上，Cache1_a = 1
（还没来得及写回内存！！！）

同时

在CPU2上，执行cmd 2
从内存读取a到Cache2上，Cache2_a = 0
然后进行计算，b = a = 0
一路将b写回到内存上

最终

a = 1
b = 0
~~~

这就是**缓存一致性问题**。（在上例中，缓存1和缓存2的中a的值不一致。）
也可以称为**缓存可见性问题**。（在上例中，缓存1和缓存2中的a互不可见。）

同样的代码，跑两次结果不一样，显然（在这里）这是不能接受的。

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


Cache 由 Cache Line 组成，每个 Cache Line 是64位（根据不同架构，也可能是32位或128位），
这个Cache Line可以理解为 Cache 的最小组成单位。


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

多核CPU，从硬件设计的角度上来说，存在缓存一致性问题。

为了解决这个问题，可以使用总线锁（但是代价太大），也可以使用缓存锁（缓存一致性协议）。

为了优化缓存一致性协议，还使用了Store Buffer + Store Forwarding，以及Invalid Queue技术。
同时，必须搭配使用Memory Barrier技术（需要从软件层面实现）。