---
layout: default
title: Java - Semaphore
folder: semaphore
permalink: /archive/java/semaphore/
---

# Java Semaphore

## What

Semaphore表示信号量。其作用是：管理一系列许可证（permits），从而限制可以操作某些资源的线程数。

> Semaphores are often used to restrict the number of threads than can access some (physical or logical) resource.
-- from java7 api

具体来说：首先，我们指定permit的数量。然后，规定对于某项操作/资源，需要先获取（acquire）一个permit，如果都用光了，线程就阻塞等待。等有空的permits可以用了，再继续执行。执行完毕，释放（release）该permit。

## Usage

在创建Semaphore对象时有两个需要注意的参数：

- int permits: 允许的permits数量
- boolean fair: 采取公平模式还是非公平模式

构造方法如下：

~~~ java
Semaphore(int permits)
Creates a Semaphore with the given number of permits and nonfair fairness setting.

Semaphore(int permits, boolean fair)
Creates a Semaphore with the given number of permits and the given fairness setting.
~~~

在使用Semaphore时有两个常用的方法，很好理解，用acquire来获取permit，用完了release。

~~~ java
void	acquire()
Acquires a permit from this semaphore, blocking until one is available, or the thread is interrupted.

void	acquire(int permits)
Acquires the given number of permits from this semaphore, blocking until all are available, or the thread is interrupted.

void	release()
Releases a permit, returning it to the semaphore.

void	release(int permits)
Releases the given number of permits, returning them to the semaphore.
~~~

## Fair or Not

非公平模式：就是抢占式的，当一个permit释放时，恰好被谁抢到就是谁的。

公平模式：就是大家老老实实排队，FIFO，谁先调用acquire，谁就先获取释放的permit。

## Example

- 首先，定义了一个KeyObjects类，这个类有两个public方法：getKeyObj(), releaseKeyObj()。且该类使用了Semaphore，限制了同时获取KeyObject的线程数。
- 其次，定义了一个SomeService类，这个类implements Runnable。该类尝试获取KeyObject并进行一些操作。
- 最后，在main函数中，开了10个线程去做SomeService，由于有Semaphore限制，可以看到在同一时间内，只有三个object可以被使用。

代码：

~~~ java
public class SemaphoreTest {
    // part 1
    static class KeyObjects {
        private String[] objects = {"1", "2", "3"};
        private boolean[] used = new boolean[3];
        private final Semaphore availableLock = new Semaphore(3, true);

        public String getKeyObj() throws InterruptedException {
            availableLock.acquire();
            return getNextAvailableObj();
        }

        public void releaseKeyObj(String obj) {
            if (markAsUnused(obj)) {
                availableLock.release();
            }
        }

        // get the next available object, and mark the used flag
        private synchronized String getNextAvailableObj() {
            for (int i = 0; i < used.length; i++) {
                if (!used[i]) {
                    used[i] = true;
                    return objects[i];
                }
            }
            return null;
        }

        // as this obj is released, try to mark it as unused, return success or not
        private synchronized boolean markAsUnused(String obj) {
            for (int i=0; i<3; i++) {
                if (obj == objects[i]) {
                    if (used[i]) {
                        used[i] = false;
                        return true;
                    } else {
                        return false;
                    }
                }
            }
            return false;
        }
    }
    
    // part 2
    static class SomeService implements Runnable {
        KeyObjects keyObjects;
        long startTime;
        SomeService(KeyObjects keyObjects, long startTime) {
            this.keyObjects = keyObjects;
            this.startTime = startTime;
        }

        @Override
        public void run() {
            serve();
        }
        private void serve() {
            try {
                String obj = this.keyObjects.getKeyObj();
                System.out.println(Thread.currentThread().getName() + 
                  " at time (" + (System.currentTimeMillis()-this.startTime)/1000 + "), serving: " + obj + "...");
                Thread.sleep(1000); //mock some taking time service
                this.keyObjects.releaseKeyObj(obj);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    // part 3
    public static void main(String args[]) throws Exception{
        long startTime = System.currentTimeMillis();
        KeyObjects keyObjects = new KeyObjects();
        Executor executor = Executors.newFixedThreadPool(10);
        for (int i=0; i<10; i++) {
            executor.execute(new SomeService(keyObjects, startTime));
        }
    }
}
~~~

输出如下：

~~~
pool-1-thread-1 at time (0), serving obj (1)...
pool-1-thread-3 at time (0), serving obj (3)...
pool-1-thread-2 at time (0), serving obj (2)...
pool-1-thread-4 at time (1), serving obj (1)...
pool-1-thread-5 at time (1), serving obj (2)...
pool-1-thread-6 at time (1), serving obj (3)...
pool-1-thread-7 at time (2), serving obj (1)...
pool-1-thread-8 at time (2), serving obj (2)...
pool-1-thread-9 at time (2), serving obj (3)...
pool-1-thread-10 at time (3), serving obj (1)...
~~~

## Link

- [Java 7 API](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Semaphore.html)
- [深入理解Semaphore](https://blog.csdn.net/qq_19431333/article/details/70212663)
- [Semaphore原理](https://www.cnblogs.com/NewMan13/p/7792365.html)
