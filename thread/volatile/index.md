---
layout: default
title: Thread - Volatile
folder: volatile
permalink: /archive/thread/volatile/
---

# Thread - Volatile

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

参考 -> Java并发编程：volatile关键字解析 <https://www.cnblogs.com/dolphin0520/p/3920373.html>

### 后续思考

其实，原子性和有序性的破坏，本质是我们写代码用的是高级语言，而实际执行的是机器语言，而这两者有时候会存在一些差异。这个（可能）只存在于多线程（并发编程）。
而可见性，既存在于多线程（并发编程），也存在于多缓存（并行编程）。

## Java内存模型

为了应对并发编程的三个问题，JMM - `Java Memory Model` - `Java内存模型` 做出了一些规定。

### 保证 - 原子性

在Java中，对基本数据类型的变量的读取和赋值操作是原子性操作，即这些操作是不可被中断的，要么执行，要么不执行。

举例如下：只有语句1是原子性的，其它都不是。

~~~
x = 10;        //语句1
y = x;         //语句2
x++;           //语句3
x = x + 1;     //语句4
~~~

如果要实现更大范围操作的原子性，可以通过`synchronized`和`Lock`来实现。

### 保证 - 可见性

Java提供了`volatile`关键字来保证可见性。

另外，通过`synchronized`和`Lock`也能够保证可见性，`synchronized`和`Lock`能保证同一时刻只有一个线程获取锁然后执行同步代码，并且在释放锁之前会将对变量的修改刷新到主存当中。因此可以保证可见性。

### 保证 - 有序性

Java通过volatile关键字来保证一定的"有序性"。

另外，通过`synchronized`和`Lock`也能够保证有序性，使用锁把多线程在短时间内"变成"单线程，可以规避掉大多数并发问题。

另外，Java创造了 happen-before 规则，来保证有序性。

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

`volatile`具体怎么操作呢？加内存屏障啊！

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

### volatile的原子性问题

需要注意的是，volatile无法保证原子性。
看下例：创建了10个线程，每个线程对一个共享 volatile 变量执行自增1万次。理论上，最后结果输出应该是10万次。

~~~ java
public class Test {
    public volatile int inc = 0;

    public void increase() {
        inc++;
    }

    public static void main(String[] args) {
        final Test test = new Test();
        for(int i=0;i<10;i++){
            new Thread(){
                public void run() {
                    for(int j=0;j<10000;j++) {
                        test.increase();
                    }
                    System.out.println(Thread.currentThread().getName() + ": " + test.inc);
                };
            }.start();
        }

        while(Thread.activeCount()>2) {
            //保证前面的线程都执行完
            //System.out.println(Thread.activeCount());
            Thread.yield();
        }

        System.out.println(test.inc);
    }
}
~~~

实际结果（值是小于10万次的随机数） ->

~~~
Thread-2: 19420
Thread-4: 30130
Thread-0: 38377
Thread-1: 47181
Thread-5: 57181
Thread-7: 67600
Thread-8: 76001
Thread-9: 86001
Thread-6: 96001
Thread-3: 96001
96001
~~~

原因：`inc++`这个操作不是原子性的。可以分为三步：

~~~
步骤1：读取inc的值
步骤2：将inc的值+1
步骤3：将新的值赋予inc
~~~

有可能，线程1执行完1，2步，然后就被线程2打断。线程2执行完了1，2，3步，然后再切换回线程1。线程1再执行步骤3，将线程2的结果覆盖了（总体里看，相当于少自增一次）。

### 怎么用volatile

由于volatile不保证原子性，使用起来要很小心。

总结来说，需要保证：

- 对 volatile 变量的 写 操作，不依赖于当前值（比如，自增操作是不行的）
- 对 volatile 变量的 读 操作，不能用于计算其它变量（比如，y = x + 1 是不行的，x 是 volatile 变量）

### volatile的常用场景

1. 状态量标记，多线程中需要共享一个flag

~~~ java
volatile boolean flag = false;
 
while(!flag){
    doSomething();
}
 
public void setFlag() {
    flag = true;
}
~~~

2. 双重检查锁 double checked locking

~~~ java
public class Singleton {
    private volatile static Singleton uniqueSingleton;

    private Singleton() {
    }

    public Singleton getInstance() {
        if (null == uniqueSingleton) {
            synchronized (Singleton.class) {
                if (null == uniqueSingleton) {
                    uniqueSingleton = new Singleton();
                }
            }
        }
        return uniqueSingleton;
    }
}
~~~

几个注意点：
- 使用`synchronized`保证多线程下，不会创建多个实例。
- 使用两个check null语句，保证第二次，第三次访问的时候，不需要再获取`synchronized`锁。
- 使用`volatile`，禁止创建实例对象时执行发生重排序，而导致问题。

参考 -> Java中的双重检查锁（double checked locking） <https://www.cnblogs.com/xz816111/p/8470048.html>
