---
layout: default
title: Java
folder: java
permalink: /archive/java/
---

# Java

## Collection

### API

```
Collection
  List
    ArrayList
    LinkedList
    Vector
  Set
    HashSet
    TreeSet
    LinkedHashSet
  Queue
    LinkedList
    PriorityQueue

Map
  HashMap
  Hashtable
  LinkedHashMap
  TreeMap
```

- List, an ordered collection
- Set, a collection that can't contain duplicate elements
- Queue, order elements in a FIFO manner; Deque, elements can be added and deleted from both sides
- Map, map keys to values

![Java Collection Framework Hierarchy](img/Java-collection-framework-hierarchy.png)

### Collection

**Adding and Removing Elements**

```
boolean didCollectionChange = collection.add(anElement);
boolean wasElementRemoved   = collection.remove(anElement); 
```

**Checking if a Collection Contains a Certain Element**

```
boolean containsElement = collection.contains("an element");
boolean containsAll     = collection.containsAll(elements);
```

**Size**

```
int numberOfElements = collection.size();
```

**Iteration**

```
Iterator iterator = collection.iterator();
while(iterator.hasNext()){
    Object object = iterator.next();
    //do something to object;    
}

for(Object object : collection) {
  //do something to object;
}
```

### Map

**Accessing Elements**

```
Map mapA = new HashMap();

mapA.put("key1", "element 1");

String element1 = (String) mapA.get("key1");

// key iterator
Iterator iterator = mapA.keySet().iterator();

// value iterator
Iterator iterator = mapA.values();
```

**Removing Elements**

```
remove(Object key)
```

### Differences

**ArrayList v.s. LinkedList**
- add(), linkedlist faster
- get(), arraylist faster

**ArrayList v.s. Vector**
- Vector is thread-safe, ArrayList is not (Performance)
- Automatic increase its capacity, Vector doubles its size while ArrayList increase by 50%
- Vector has Enumerator while ArrayList does not

**HashMap v.s. Hashtable**
- HashMap allows null for both key and value, Hashtable does not
- HashMap is unsynchronized. So come up with better performance. Hashtable is not.

(To successfully store and retrieve objects from a hashtable, the objects used as keys must implement the `hashCode` method and the `equals` method.
parameter: initialCapacity, loadFactor)

**HashMap v.s. ConcurrentHashMap**
- Thread-safe(ConcurentHashMap is thread-safe)
- Performance(HashMap is better)
- Null Key(ConcurrentHashMap does not allow NULL values while HashMap allows one)

### Links
- http://tutorials.jenkov.com/java-collections/index.html
- http://beginnersbook.com/java-collections-tutorials/
- http://tutorials.jenkov.com/java-collections/overview.html

## Concurrency

### Benefits and Costs
- benefit: better resource utilization
- benefit: more responsive design
- cost: more complex design
- cost: context switching overhead
- cost: increase resource assumption

### Models

Parallel Workers

![concurrency-models-1](img/concurrency-models-1.png)

Assembly Line

![concurrency-models-3](img/concurrency-models-3.png)

**Concurrency v.s. Parallelism**

Concurrency means that an application is making progress on more than one task at the same time.

![concurrency-vs-parallelism-1](img/concurrency-vs-parallelism-1.png)

Parallelism means that an application splits its tasks up into smaller subtasks which can be processed in parallel, for instance on multiple CPUs at the exact same time.

![concurrency-vs-parallelism-2](img/concurrency-vs-parallelism-2.png)

### Java Thread

**create and start thread**: extends Thread / implement Runnable

Steps:
- create a thread object
  - create some object with thread features (implement Runnable / extends Thread )
  - create a thread object
- define the function of the thread
  - override `run()`
  - (optional) override `start()` ; usually the thread instantiation happens here
- start the thread
  - call `start()`

e.g.

```
// Part 1
Class SomeClass implements Runnable { // or extends Thread
     private Thread t;
     public void run() {...}
     public void start() {
          if (t == null) {
               t = new Thread(this, "threadName");
               t.start();
          }
     }
}
...
{
     SomeClass example = new SomeClass(...);
     example.start();
}

// Part 2: using anonymous class
Thread t=new Thread(){  
  public void run(){  
       obj.method();  
  }  
};
```

**race condition**: race condition only occur when multiple threads update shared resources

**thread safety**: if a resource is created, used and disposed within the control of the same thread, and never escapes the control of this thread, the use of that resource is thread safe

**immutability**: immutable object is thread-safe, but the use/reference of it may not be

### Daemon Thread

Daemon thread in java is a service provider thread that provides services to the user thread. Its life depend on the mercy of user threads i.e. when all the user threads dies, JVM terminates this thread automatically.

There are many java daemon threads running automatically, e.g. gc, finalizer etc.

### GC

finalize: The finalize method is called when an object is about to get garbage collected. That can be at any time after it has become eligible for garbage collection.

### Synchronization

Problem: thread interference and memory consistency errors

Lock: Every object has an lock associated with it. By convention, a thread that needs consistent access to an object's fields has to acquire the object's lock before accessing them, and then release the lock when it's done with them.

Synchronization
 - Process Synchronization
 - Thread Synchronization

Multual Exclusive
 - by synchronized method
 - by synchronized block
 - by static synchronization

e.g. usage

```
synchronized method() {...}
synchronized (object reference expression) {...} ; 
//Notice: in this case, the object's all fields are not available
```

### Deadlock Prevention

**Lock Ordering**: make sure that all locks are always taken in the same order by any thread

```
Situation:
	Thread 1:
	  lock A
	  lock B
	Thread 2:
	   wait for A
	   lock C (when A locked)
	Thread 3:
	   wait for A
	   wait for B
	   wait for C

Solve:
	Neither Thread 2 or Thread 3 can lock C until they have locked A first.
```

**Lock Timeout**: if a thread does not succeed in taking all necessary locks within the given timeout, it will backup, free all locks taken, wait for a random amount of time and then retry.

**Deadlock Detection**: every time a thread takes a lock it is noted in a data structure (map, graph etc.) of threads and locks. Additionally, whenever a thread requests a lock this is also noted in this data structure.

When a thread requests a lock but the request is denied, the thread can traverse the lock graph to check for deadlocks.

![concurrency_deadlock_graph](img/concurrency_deadlock_graph.png)

Tools: jps, jconsole, jstack, JMX API

### Links
- http://tutorials.jenkov.com/java-concurrency/index.html

