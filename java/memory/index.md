---
layout: default
title: Java - JVM Memory
folder: memory
permalink: /archive/java/memory/
---

# Java - JVM Memory

Java Runtime JVM memory allocaiton

## JDK 1.7 模型

![java-memory](img/java-memory.png)

- Stack，栈
  - `Program Counter`，程序计数器
  - `Java Stack`，Java栈，存放`local variables`, `return values`, `operand stack`等
  - `Native Method Stack`，本地方法栈
- Heap，堆，存放Objects
  - Young Generation
  - Old Generation
- Method Area 方法区 / （约等于）PermGen space 永久代
  - （总体来说，是用来存放 class data）
  - 常量池 （静态常量+动态常量）
    - 静态常量：字面量(Literal) + 符号引用量(Symbolic References，编译概念，如类名，接口名，方法名)
    - 动态常量：jvm在完成类装载操作后，class文件中的常量，一个典型的就是`String.intern()`
  - 静态变量 static variable

参考 -> Java中静态常量和静态变量的区别 <https://blog.csdn.net/luzhensmart/article/details/86855029>

## JDK 1.8 模型

Method Area 方法区；存在JVM中

改动 -> 

Metaspace 元数据区；存在内存中

- 类和方法的信息等比较难确定大小，因此对于方法区大小的指定比较困难
- 字符串常量也跟着放到了内存中，防止出现性能问题和内存溢出

## 常见OutOfMemoryError演示与分析

### java.lang.OutOfMemoryError: Java heap space

java堆内存溢出，此种情况最常见，一般由于内存泄露或者堆的大小设置不当引起。
下例中，我们不断new对象出来，导致OOM。

~~~ java
// VM options: -Xms10M -Xmx10M
public class HeapOOM {
  public static void main(String[] args){
      long i= 0;
      try {
          List<Object> objects = new ArrayList<Object>();
          while (true) {
              i++;
              objects.add(new Object());
              System.out.println(i);
          }
      } catch(Throwable ex) {
          System.out.println(i);
          ex.printStackTrace();
      }
  }
}
~~~

### java.lang.OutOfMemoryError: PermGen space

java永久代溢出，即方法区溢出了，一般出现于大量Class或者JSP页面，或者采用CGLIB等反射机制的情况，因为上述情况会产生大量的Class信息存储于方法区。

~~~ java
// -XX:MaxPermSize=10M
public class HeapOOM {
  public static void main(String[] args) throws Exception {
      for (int i = 0; i < 100_000_000; i++) {
          generate("cn.paul.test" + i);
      }
  }

  public static Class generate(String name) throws Exception {
      ClassPool pool = ClassPool.getDefault();
      return pool.makeClass(name).toClass();
  }
}
~~~

### java.lang.StackOverflowError

java栈溢出，一般是由于程序中存在死循环，或者深度递归调用造成的。
下例中，是一个无限的递归。

~~~ java
public class HeapOOM {
  public static void main(String[] args){
     stackOverFlow(new AtomicLong(1));
  }

  public static void stackOverFlow(AtomicLong counter){
      System.out.println(counter.incrementAndGet());
      stackOverFlow(counter);
  }
}
~~~

## Escape Analysis

### 什么是逃逸

一个对象（的指针）被多个方法或者线程引用时，那么我们就称这个对象（的指针）的逃逸 Escape 。

- 方法逃逸：在一个方法内，定义一个局部变量，它可能被外部方法引用，比如作为调用参数传递给方法，或作为对象直接返回。（可以理解成对象跳出了方法。）
- 线程逃逸：某个对象被其他线程访问到，比如赋值给了实例变量。（可以理解成对象逃出了当前线程。）

### 什么是逃逸分析

JVM可以对对象进行逃逸分析。
- 如果对象会发生逃逸，那么就分配在堆上（等待GC回收）
- 如果对象不会发生逃逸，就分配在栈上（当方法调用完毕，直接出栈释放资源）

~~~
-XX:+DoEscapeAnalysis开启逃逸分析（JDK 6u23以上默认开启）
-XX:-DoEscapeAnalysis 关闭逃逸分析
 
#标量替换基于分析逃逸基础之上，开启标量替换必须开启逃逸分析
-XX:+EliminateAllocations开启标量替换（jdk1.8默认开启，其它版本未测试）
-XX:-EliminateAllocations 关闭标量替换
 
#锁消除基于分析逃逸基础之上，开启锁消除必须开启逃逸分析
-XX:+EliminateLocks开启锁消除（jdk1.8默认开启，其它版本未测试）
-XX:-EliminateLocks 关闭锁消除
~~~

## 常见提问

1
- 问：Java 中各个对象、变量、类的存储位置？
- 答：如果你已经掌握了上面的内容，这个问题应该是不难的。NEW 出来的对象存储在堆中，局部变量和方法的引用存在栈中，类的相关信息、常量和静态变量存在方法区中，1.8以后使用元空间存储类相关信息。

2
- 问：Java 中会有内存溢出问题吗？发生在哪些情况下？
- 答：JVM 的堆、栈、方法区、本地方法栈、直接内存都会发生内存溢出问题。典型的堆溢出的例子：集合持有大量对象并且长期不释放。典型的栈溢出例子：无法快速收敛的递归。典型的方法区溢出例子：加载了大量的类或者 JSP 的程序。

## Links
- <https://stackoverflow.com/questions/10209952/what-is-the-purpose-of-the-java-constant-pool>
- <https://stackoverflow.com/questions/13624462/where-does-class-object-reference-variable-get-stored-in-java-in-heap-or-stac>
- JVM 知识点 <https://gitbook.cn/books/5cda388b92757c1b0b325fd4/index.html>

