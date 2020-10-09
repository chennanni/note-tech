---
layout: default
title: Java - Monitor - VisualVM
folder: visualvm
permalink: /archive/java/visualvm/
---

# Java - Monitor - VisualVM

> JVisualVM，能够监控线程Thread，内存Memory，CPU时间和对象Class。

## 启动

路径：`...\Java\jdk1.8.0_74\bin\jvisualvm.exe`

- 本地的**正在运行**的java程序会自动显示在Local标签下。
- 如果需要连接Server端，在Remote标签下 -> Add JMX Connection -> input hostname:port

## 如何查看服务器端口号

`ps aux | grep java | grep jmxremote --color` 

->

~~~
-Dcom.sun.management.jmxremote.port=1234
-Dcom.sun.management.jmxremote.ssl=false 
-Dcom.sun.management.jmxremote.authenticate=false"
~~~

## 实例

**mock CPU usage**

~~~ java
public static void main(String[] args) {
	Scanner sc = new Scanner(System.in);
	System.out.println("Please Enter when VM is ready.");
	sc.nextLine();
	System.out.println("START");
	double input = 123;
	while (true) {
		input = (Math.exp(input) + 456) * 789 - 546;
	}
}
~~~

写了一个死循环不停做计算，可以看到CPU一直保持在25%左右的使用。

![cpu.1.PNG](img/cpu.1.PNG)

**mock GC**

~~~ java
public static void main(String[] args) {
	Scanner sc = new Scanner(System.in);
	System.out.println("Please Enter when VM is ready.");
	sc.nextLine();
	System.out.println("START");
	double input = 123;
	while (true) {
		String s = new String(Double.toString(input++));
	}
}
~~~

写了一个死循环不停创建String对象，可以看到Heap size一直飙升，直到`3:32:00`，做了一次GC（见左图左下方不太明显的一个蓝色小波动），内存就降下来一点（见右图的第一个波谷）。之后一直频繁GC（蓝线），使得Heap size保持基本在700m左右（黄线）。

![cpu.2.PNG](img/cpu.2.PNG)

## 链接

- [jvisualvm 工具使用](https://www.cnblogs.com/kongzhongqijing/articles/3625340.html)
- [java_监控工具jvisualvm](https://www.cnblogs.com/caroline4lc/p/4932937.html)
