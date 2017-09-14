---
layout: default
title: Java - Questions
folder: questions
permalink: /archive/java/questions/
---

# Java - Questions

## Abstract class vs Interface
- 用途上的区别：抽象类用来做base class，提供一些已经实现的方法，同时保留一些未实现的方法给子类去实现；接口用来定义behavior。
- 本质上的区别：一个是类，一个是接口；类只能继承一个，接口可以实现多个；类相当于'是'的关系，接口相当于'会'的关系。
- 举例：AbstractMap是一个抽象类，提供了对Map接口的一些方法如size(), get()等的实现，但是保留了entrySet()等方法给子类去实现，根据不同的实现可以衍生出modifiableMap和unmofidiableMap；Serializable是一个接口，String类实现了这个接口，表示String是可以序列化的。

## HashMap Implementation
- Array + LinkList
- 存的是Entry<K, V>(hash, key, value, next)，不仅仅是value
- V put(K key, V value)
  - hash(key)%len -> index，根据index决定在array的什么位置存储Entry
  - 如果该位置已经有了一个Entry，则把它替换成新的Entry，而新Entry的next指向旧Entry
- V get(Object key)
  - hash(key)%len -> index'，根据index'去array的某个位置找Entry
  - 然后遍历链表，根据key比较找到唯一符合的那个
- Set<Map.Entry<K,V>>	entrySet()

## Hashtable vs HashMap vs ConcurrentHashMap
- Hashtable is synchronized, whereas HashMap is not.
- Hashtable does not allow null keys or values. HashMap allows one null key and any number of null values.
- Hashtable has locks on all operations, whereas ConcurrentHashMap does not lock on `get()`. And ConcurrentHashMap
- ConcurrentHashMap is more efficient for threaded applications.

<https://stackoverflow.com/questions/12646404/concurrenthashmap-and-hashtable-in-java>
