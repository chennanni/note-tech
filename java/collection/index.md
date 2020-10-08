---
layout: default
title: Java - Collection
folder: collection
permalink: /archive/java/collection/
---

# Java Collection Framework

## Outline

<https://docs.oracle.com/javase/7/docs/technotes/guides/collections/reference.html>

## Collections

4大数据类型

- List （列表，有序）, an ordered collection
- Set （集合，唯一对象）, a collection that can't contain duplicate elements
- Queue （队列，先进先出）, order elements in a FIFO manner; Deque, elements can be added and deleted from both sides
- Map （键值对，映射关系）, map keys to values

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

### Access Collection Class

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

### Access Map Class

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

## Differences

**ArrayList v.s. LinkedList**

- add(), linkedlist faster
- get(), arraylist faster

**ArrayList v.s. Vector**

- Vector is **thread-safe**, ArrayList is not (Performance)
- Vector has **Enumerator** while ArrayList does not
- Automatic increase its capacity, Vector doubles its size while ArrayList increase by 50%

**HashMap v.s. Hashtable**

- HashMap allows **null** for both key and value, Hashtable does not
- HashMap is **unsynchronized**. So come up with better performance. Hashtable is not

(To successfully store and retrieve objects from a hashtable, the objects used as keys must implement the `hashCode` method and the `equals` method.
parameter: initialCapacity, loadFactor)

**HashMap v.s. ConcurrentHashMap**

- 和上面几乎一样，把Hashtable换成ConcurrentHashMap就行

**Hashtable v.s. ConcurrentHashMap**

- 不论是读写操作，Hashtable都会锁住整个表
- 写操作时，ConcruuentHashMap锁住一个部分，读操作时不锁定

参考 -> <http://blog.csdn.net/wisgood/article/details/19338693>

## Fail-fast and Fail-safe Collection

`fail-safe`和`fail-fast`是修饰Collection的概念。它们关心的问题是：当在 iterate 一个 collection 时，这个 collection 本身发生了变化怎么办？

- `fail-safe`：顾名思义，safe，不会报错
- `fail-fast`：会报错`ConcurrentModificationException`

### fail-fast

~~~ java
ArrayList<Integer> integers = new ArrayList<>();
integers.add(1);
integers.add(2);
integers.add(3);
Iterator<Integer> itr = integers.iterator();

while (itr.hasNext()) {
    Integer a = itr.next();
    integers.remove(a);
}
~~~

原理：集合内部有一个flag `modCount`，每当集合发生了变化，就+1。如果在循环中，发现 `modCount` 和初始值不一样时，就抛出异常。

需要特别注意的是：如果我们修改的是`iterator`，而不是`collection`，是不会报错的！因为`iterator`内部调用了`collection`的API去修改值，且会重置`modCount`的初始值。见下例：

~~~ java
Iterator<Integer> itr = integers.iterator();
while (itr.hasNext()) {
    if (itr.next() == 2) {
        // will not throw Exception
        itr.remove();
    }
}
~~~

### fail-safe

~~~ java
List<Integer> integers = new CopyOnWriteArrayList<>();
integers.add(1);
integers.add(2);
integers.add(3);
Iterator<Integer> itr = integers.iterator();

while (itr.hasNext()) {
    Integer a = itr.next();
    integers.remove(a);
}
~~~

`CopyOnWriteArrayList`，顾名思义，是`ArrayList`的一个线程安全的变体，其中所有可变操作`add`, `set` 等等，都是通过对底层数组进行一次新的**复制**来实现的。

参考以下文章：
- fail-fast机制 <https://blog.csdn.net/chenssy/article/details/38151189>
- Fail-fast and Fail-safe iterations in Java Collections <https://medium.com/@mr.anmolsehgal/fail-fast-and-fail-safe-iterations-in-java-collections-11ce8ca4180e>

## Links

- http://tutorials.jenkov.com/java-collections/index.html
- http://beginnersbook.com/java-collections-tutorials/
- http://tutorials.jenkov.com/java-collections/overview.html
