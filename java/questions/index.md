---
layout: default
title: Java - Questions
folder: questions
permalink: /archive/java/questions/
---

# Java - Questions

## How to Say These Characters
```
() open/close parenthesis, round brackets
[] square brackets
{} brace
/ slash
, comma
; semicolon
. period
- hyphen
-- dash dash
```

## Static
- declare a static variable with same name in super & sub class? Yes. Either variable belongs to its own class.
- override static mehtod ? No compile error. It acts like override, but it's not exactly like that.
- use super keyword in static methods? No, you can't. super keyword is a non-static variable
- declare a method with both abstract and static? No, you can't.

## Volatile
- volatile is used to indicate that a variable's value will be modified by different threads
- The value of this variable will never be cached thread-locally: all reads and writes will go to "main memory"

## Transient
- marks a member variable not to be serialized when it is persisted to streams of bytes

## Overriding & Overloading

- Overloading: define two methods with the same name, in the same class, distinguished by their parameter types
- Overriding: redefine a method that has already been defined in a parent class(using the exact same signature and return type)

- Overloading: resolved at compile time; Overriding: resolved at runtime
- When overriding, you can only give more privilege, can not add more access restriction, e.g. public -> default

e.g. Override toString() to get class's info

~~~ java
class Test {
     ...
     public String toString(){ // override toString() in Object
          return "This is Test class";
     }
}
...
{
	Test test = new Test();
	System.out.print(test);
}
~~~

## Local variables v.s. Instance variables
 - A local variable is declared within the body of a method. An instance variable is declared side a class but outside of any method.
 - Local variables are not given initial default values. Instance variables do.
 - Local variables are initialized within the method and it will be destroyed when the method has completed. Instance variables have the same life cycle of the class.

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

http://blog.csdn.net/vking_wang/article/details/14166593
