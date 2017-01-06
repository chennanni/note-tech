---
layout: default
title: Java - Collection
folder: collection
permalink: /archive/java/collection/
---

# Java Collection

## API

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

## Collection Class

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

## Map Class

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

## Links

- http://tutorials.jenkov.com/java-collections/index.html
- http://beginnersbook.com/java-collections-tutorials/
- http://tutorials.jenkov.com/java-collections/overview.html
