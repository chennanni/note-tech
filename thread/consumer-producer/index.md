---
layout: default
title: Thread - Consumer and Producer
folder: consumer-producer
permalink: /archive/thread/consumer-producer/
---

# Thread - Consumer and Producer

生产者消费者模型具有以下特点：
- 有一块缓冲区作为仓库，生产者可将产品放入仓库，消费者可以从仓库中取出产品。
- 生产者在仓储未满时候生产，仓满则等待，同时通知消费者去消费。
- 消费者在仓储有产品时消费，仓空则等待，同时通知生产者生产。

其设计关键点在于：缓冲区（仓库）的设计和等待、通知机制的实现

## 例子1：缓冲区大小为1，生产者消费者共用一把锁

生产者
~~~ java
public class Producer {
	private Object lock;
	private List<Integer> container;

	public Producer(Object lock, List<Integer> container) {
		this.lock = lock;
		this.container = container;
	}

	public void produce() {
		try {
			synchronized (lock) {
				if (!container.isEmpty()) // 如果容器满了，则当前线程等待，释放lock monitor的锁
					lock.wait();
				System.out.println("Produce start ...");
				int value = new Random().nextInt(10);
				container.add(value);
				Thread.sleep(500);
				System.out.println("Produce end. Value: " + value);
				lock.notify();
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
~~~

消费者
~~~ java
public class Consumer {
	private Object lock;
	private List<Integer> container;

	public Consumer(Object lock, List<Integer> container) {
		this.lock = lock;
		this.container = container;
	}

	public void consume() {
		try {
			synchronized (lock) {
				if (container.isEmpty()) // 如果容器为空，则当前线程等待，释放lock monitor的锁
					lock.wait();
				System.out.println("Consume start ...");
				int value = container.get(0);
				container.remove(0);
				Thread.sleep(1000);
				System.out.println("Consume end. Value " + value);
				lock.notify();
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
~~~

主函数
~~~ java
  public static void main(String[] args) {
	    Object lock = new Object();
	    List<Integer> container = new ArrayList<Integer>();
	    final Producer producer = new Producer(lock, container);
	    final Consumer consumer = new Consumer(lock, container);
	    Runnable producerRunnable = new Runnable() {
	        public void run() {
	            while (true) {
	                producer.produce();
	            }
	        }
	    };
	    Runnable consumerRunnable = new Runnable() {
	        public void run() {
	            while (true) {
	                consumer.consume();
	            }
	        }
	    };
	    Thread producerThread = new Thread(producerRunnable);
	    Thread CustomerThread = new Thread(consumerRunnable);
	    producerThread.start();
	    CustomerThread.start();
	}
~~~

<http://blog.csdn.net/zhangyuan19880606/article/details/51153035>

## 例子2：缓冲区大小为N，生产者消费者共用一把锁

这里的关键在于：生产过程和消费过程，不能放到synchronized block里。只有当等待，通知的时候，两者才会去抢同一把锁。

生产者
~~~ java
public class Producer {
	private int MAX_SIZE = 10;
	private Object lock;
	private List<Integer> container;

	public Producer(Object lock, List<Integer> container) {
		this.lock = lock;
		this.container = container;
	}

	public void produce() {
		try {
			// 等待过程
			if (container.size() == MAX_SIZE) {
				synchronized (lock) {
					lock.wait();
				}
			}
			// 生产过程
			System.out.println("Produce start ...");
			int value = new Random().nextInt(10);
			container.add(value);
			Thread.sleep(500);
			System.out.println("Produce end. Value: " + value);
			// 通知过程
			synchronized (lock) {
				lock.notify();
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
~~~

消费者
~~~ java
public class Consumer {
	private Object lock;
	private List<Integer> container;

	public Consumer(Object lock, List<Integer> container) {
		this.lock = lock;
		this.container = container;
	}

	public void consume() {
		try {
			// 等待过程
			if (container.isEmpty()) {
				synchronized (lock) {
					lock.wait();
				}
			}
			// 消费过程
			System.out.println("Consume start ...");
			int value = container.get(0);
			container.remove(0);
			Thread.sleep(1000);
			System.out.println("Consume end. Value " + value);
			// 通知过程
			synchronized (lock) {
				lock.notify();
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
~~~

主函数
~~~ java
	public static void main(String[] args) {
		Object lock = new Object();
		List<Integer> container = Collections.synchronizedList(new ArrayList<Integer>());
		final Producer producer = new Producer(lock, container);
		final Consumer consumer = new Consumer(lock, container);
		Runnable producerRunnable = new Runnable() {
			public void run() {
				while (true) {
					producer.produce();
				}
			}
		};
		Runnable consumerRunnable = new Runnable() {
			public void run() {
				while (true) {
					consumer.consume();
				}
			}
		};
		Thread producerThread = new Thread(producerRunnable);
		Thread CustomerThread = new Thread(consumerRunnable);
		producerThread.start();
		CustomerThread.start();
	}
~~~

## 例子3：用BlockingQueue实现缓冲区

通过BlockingQueue实现缓冲区，不需要去额外实现等待、通知机制

生产者
~~~ java
public class Producer {
	private BlockingQueue<Integer> container;

	public Producer(BlockingQueue<Integer> container) {
		this.container = container;
	}

	public void produce() {
		try {
			System.out.println("Produce start ...");
			int value = new Random().nextInt(10);
			container.put(value);
			Thread.sleep(500);
			System.out.println("Produce end. Value: " + value);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
~~~

消费者
~~~ java
public class Consumer {
	private BlockingQueue<Integer> container;

	public Consumer(BlockingQueue<Integer> container) {
		this.container = container;
	}

	public void consume() {
		try {
			System.out.println("Consume start ...");
			int value = container.take();
			Thread.sleep(1000);
			System.out.println("Consume end. Value " + value);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

	}
}
~~~

主函数
~~~ java
	public static void main(String[] args) {
	    final BlockingQueue<Integer> container = new ArrayBlockingQueue<Integer>(10);
	    final Producer producer = new Producer(container);
	    final Consumer consumer = new Consumer(container);
	    Runnable producerRunnable = new Runnable() {
	        public void run() {
	            while (true) {
	                producer.produce();
	            }
	        }
	    };
	    Runnable consumerRunnable = new Runnable() {
	        public void run() {
	            while (true) {
	                consumer.consume();
	            }
	        }
	    };
	    Thread producerThread = new Thread(producerRunnable);
	    Thread customerThread = new Thread(consumerRunnable);
	    producerThread.start();
	    customerThread.start();
	}
~~~

- <http://blog.csdn.net/zhangyuan19880606/article/details/51153224>
- <http://www.cnblogs.com/linjiqin/p/3217050.html>

## 例子4：多生产者，多消费者的模型

<http://www.infoq.com/cn/articles/producers-and-consumers-mode/#>
