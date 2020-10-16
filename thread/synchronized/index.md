---
layout: default
title: Java - Synchronized
folder: synchronized
permalink: /archive/java/synchronized/
---

# Java - Synchronized

## 什么是Synchronized

synchronize 同步

使用`synchronized`关键字修饰的代码块，同一时间只能有一个线程进行访问。
通过加锁，保证**多线程访问共享资源时的线程安全**。

## 锁的是什么

首先，强调一点：锁是加在**对象**上面的。
`synchronized`关键字可以用在各种地方（见下面的作用范围），但不管怎样，最终，是一个**对象**被加锁了。

需要注意的是，一个对象被加锁了，不代表其它线程就完全不能使用这个对象了。
而是说其他线程无法访问该对象的任何`synchronized`方法。但是可以调用其他非`synchronized`的方法。

## 作用范围

一般说是，可以分为三类：

- 在**静态方法**上 使用`synchronized`
  - 加锁的作用的对象是，这个方法所属于的**类对象**
- 在**非静态方法**上 使用`synchronized`
  - 加锁的作用的对象是，调用这个方法的**实例对象**
- 在**代码块**上 使用`synchronized`
  - 加锁的作用的对象是，根据所修饰的对象的类型而定（静态对象/非静态对象）

其实，个人感觉是两类，就看`synchronized`修饰的是**静态**的方法/对象，还是**非静态**的。
与之对应的，加的是**类对象锁**，还是**实例对象锁**。

~~~ java
public class SynchronizedSample {

   private final Object lock = new Object();

   private static int money = 0;
   
   //静态方法
   public static synchronized void staticMethod(){
	   money++;
   }
   
   //非静态方法
   public synchronized void noStaticMethod(){
	   money++;
   }
   
   public void codeBlock(){	   
	   //代码块
	   synchronized (lock){
		   money++;
	   }
   }
}
~~~

## 作用范围验证

### 非静态方法锁的是实例对象

首先，我们来验证非静态方法上使用`synchronized`，加锁的对象是调用这个方法的实例对象。

首先，我们定义了一个非静态方法 `minus1()`。它会倒计时5秒然后print出来。

~~~ java
public class TestSynchronized {

    public synchronized void minus1() {
        int count = 5;
        for (int i = 0; i < 5; i++) {
            count--;
            System.out.println(Thread.currentThread().getName() + " - " + count);
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
            }
        }
    }

}
~~~

然后，我们创建两个线程，创建一个实例化对象，两个线程都调用了这个对象的方法。

~~~ java
public static void main(String[] args) {

	TestSynchronized test1 = new TestSynchronized();
	
	Thread thread1 = new Thread(new Runnable() {

		@Override
		public void run() {
			test1.minus1();
		}
	});

	Thread thread2 = new Thread(new Runnable() {

		@Override
		public void run() {
			test1.minus1();
		}
	});

	thread1.start();
	thread2.start();
}
~~~

结果 ->

~~~
Thread-0 - 4
Thread-0 - 3
Thread-0 - 2
Thread-0 - 1
Thread-0 - 0
Thread-1 - 4
Thread-1 - 3
Thread-1 - 2
Thread-1 - 1
Thread-1 - 0
~~~

分析：一个线程执行完了，才轮到另一个执行。此时有加锁。

作为对比组，我们创建两个实例化对象。每个线程内各自调用一个实例化对象的方法。

~~~ java
public static void main(String[] args) {

	TestSynchronized test1 = new TestSynchronized();
	TestSynchronized test2 = new TestSynchronized();

	Thread thread1 = new Thread(new Runnable() {

		@Override
		public void run() {
			test1.minus1();
		}
	});

	Thread thread2 = new Thread(new Runnable() {

		@Override
		public void run() {
			test2.minus1();
		}
	});

	thread1.start();
	thread2.start();
}
~~~

结果 -> 

~~~
Thread-0 - 4
Thread-1 - 4
Thread-0 - 3
Thread-1 - 3
Thread-0 - 2
Thread-1 - 2
Thread-0 - 1
Thread-1 - 1
Thread-0 - 0
Thread-1 - 0
~~~

分析：两个线程"同时"执行各自实例化对象的方法，此时没有竞争，没有加锁。

总结：非静态方法上使用`synchronized`，加锁的作用的对象是调用这个方法的实例对象。

### 锁只作用于synchronized方法，而不是其它方法

再做一个实验，一个类中，有一个`synchronized`方法，一个普通方法。

~~~ java
public class TestSynchronized {

    public synchronized void minus1() {
        int count = 5;
        for (int i = 0; i < 5; i++) {
            count--;
            System.out.println(Thread.currentThread().getName() + " - " + count);
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
            }
        }
    }

    public void minus2() {
        int count = 5;
        for (int i = 0; i < 5; i++) {
            count--;
            System.out.println(Thread.currentThread().getName() + " - " + count);
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
            }
        }
    }

}
~~~

两个线程，分别调用一个实例对象的这两个方法。

~~~ java
public static void main(String[] args) {

	TestSynchronized test1 = new TestSynchronized();

	Thread thread1 = new Thread(new Runnable() {

		@Override
		public void run() {
			test1.minus1();
		}
	});

	Thread thread2 = new Thread(new Runnable() {

		@Override
		public void run() {
			test1.minus2();
		}
	});

	thread1.start();
	thread2.start();
}
~~~

结果 ->

~~~
Thread-0 - 4
Thread-1 - 4
Thread-0 - 3
Thread-1 - 3
Thread-0 - 2
Thread-1 - 2
Thread-0 - 1
Thread-1 - 1
Thread-0 - 0
Thread-1 - 0
~~~

分析总结：两个方法并行执行。锁只作用于`synchronized`方法，而不是其它方法。

如果不信，可以把`minus2()`加上`synchronized`关键字，再运行一遍。这里就不演示了。
（结果是一个Thread执行完了，另一个Thread才执行。）

### 静态方法锁的是类对象

接着测试，一个方法是`synchronized`，一个方法是`static` + `synchronized`。

~~~ java
public class TestSynchronized {

    public synchronized void minus1() {
        int count = 5;
        for (int i = 0; i < 5; i++) {
            count--;
            System.out.println(Thread.currentThread().getName() + " - " + count);
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
            }
        }
    }

    public synchronized static void minus2() {
        int count = 5;
        for (int i = 0; i < 5; i++) {
            count--;
            System.out.println(Thread.currentThread().getName() + " - " + count);
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
            }
        }
    }

}
~~~

运行一遍。

~~~ java
public static void main(String[] args) {

	TestSynchronized test1 = new TestSynchronized();

	Thread thread1 = new Thread(new Runnable() {

		@Override
		public void run() {
			test1.minus1();
		}
	});

	Thread thread2 = new Thread(new Runnable() {

		@Override
		public void run() {
			TestSynchronized.minus2();
		}
	});

	thread1.start();
	thread2.start();
}
~~~

结果如下：

~~~
Thread-0 - 4
Thread-1 - 4
Thread-1 - 3
Thread-0 - 3
Thread-1 - 2
Thread-0 - 2
Thread-1 - 1
Thread-0 - 1
Thread-0 - 0
Thread-1 - 0
~~~

很神奇，两个并行执行了。原因是静态方法加的是类锁，而非静态方法加的是对象锁。
两个是不一样的。

### 代码块的特殊情况

代码块的常见情形就不测试了，考虑下面的情况：`synchronized`修饰了一个对象，且这个对象是在本地方法内创建的。
理论上说，每次运行该方法，都会创造一个新的对象。那锁还有用吗？

~~~ java
public class TestSynchronized {

    //Object obj = new Object(); // common scenario 1
    //static Object obj = new Object(); // common scenario 2

    public void minus3() {
        Object obj = new Object();
        synchronized (obj) {
            int count = 5;
            for (int i = 0; i < 5; i++) {
                count--;
                System.out.println(Thread.currentThread().getName() + " - " + count);
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                }
            }
        }
    }
	
}
~~~

运行一下。

~~~ java
public static void main(String[] args) {

    TestSynchronized test1 = new TestSynchronized();

    Thread thread1 = new Thread(new Runnable() {

        @Override
        public void run() {
            test1.minus3();
        }
    });

    Thread thread2 = new Thread(new Runnable() {

        @Override
        public void run() {
            test1.minus3();
        }
    });

    thread1.start();
    thread2.start();
}
~~~

结果 -> 

~~~
Thread-0 - 4
Thread-1 - 4
Thread-0 - 3
Thread-1 - 3
Thread-1 - 2
Thread-0 - 2
Thread-1 - 1
Thread-0 - 1
Thread-0 - 0
Thread-1 - 0
~~~

最后并行执行了。这样写其实`synchronized`关键字就没有任何效果了，加了和没加一样。

这个例子在实际开发中可能不会遇到，但是，对于理解`synchronized`很有帮助！

## 参考

- 一个 Synchronized <https://gitbook.cn/books/5ea56078f132164fa8090853/index.html>
- Java中synchronized同步锁用法及作用范围 <https://blog.csdn.net/yx0628/article/details/79086511>
