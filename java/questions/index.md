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
- use super keyword in static methods? No, you can't. super keyword is a non-static variable.
- declare a method with both abstract and static? No, you can't.

## Overriding & Overloading

- Overloading（重载）
  - Define two methods with the same name, in the same class, distinguished by their parameter types.
  - Overloading is resolved at compile time.
- Overriding（重写）
  - Redefine a method that has already been defined in a parent class(using the exact same signature and return type).
  - Overriding is resolved at runtime.
  - When overriding, you can only give more privilege, can not add more access restriction.

- 重载：在同一个类中，允许有多个方法具有相同名字，但是不同参数（输入值+返回值）。在实际调用时，再根据参数进行匹配，调用对应方法。
- 重写：在继承了一个父类之后，可以重写父类的同名同参数的方法。在实际调用时，优先调用子类方法。（注意：子类函数的访问修饰权限不能少于父类的。）

e.g. Override `toString()` to get class's info

~~~ java
class Test {
	...
	public String toString(){
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

<http://blog.csdn.net/vking_wang/article/details/14166593>

## Java代码编译执行流程
- Java代码 ->
- 字节码 ->
- 根据字节码执行对应的C/C++代码 ->
- C/C++代码被编译成汇编语言 ->
- 和硬件电路交互

## Java Pass-By-Value (Pass-By-Copy)

- For primitives, you pass a **copy** of the actual value.
- For references to objects, you pass a **copy** of the reference (the remote control).

```
Senario 1: primitives

int x = 100; // x's value
addOne(x); // copy of x's value 100 is passed to the method
print(x); // result: 100

Senario 2:

Account a = new Account("1001"); // a is a reference to the Account Object 1001
Account b = a; // b is a copy of a, which also points to Account Object 1001
a == b; // true
a = new Account("1002"); // point a to a new Account Object 1002
b.getAccountNumber(); // result: 1001, b still points to Account Object 1001
```

- <http://www.javaranch.com/campfire/StoryPassBy.jsp>
- <http://stackoverflow.com/questions/40480/is-java-pass-by-reference-or-pass-by-value>

## Main Method in Java Web Project

Why don't I see any main method in the Java web project?

- Web applications don't have a main method.
- The program that is running is actually the web container (Tomcat, Weblogic, whatever) and that program will service the web application(s) you deploy into it.
- Put a breakpoint in some initialization method, such as the init method of some servlet, when the breapoint hits, scroll down the call trace and the main method should be at the bottom.

## Java Constant Pooling

We know that:

```
String a = "hello";
String b = "hello";
a == b // true
```

Because a and b point to the same String literal "hello". But where are they actually stored?

- If a,b are defined inside object:
  - a, b are stored in Heap together with object
- If a,b are defined inside method:
  - a, b are stored in Java Stack as local variables
- "hello" are stored in Non Heap as Runtime Constant Pool

When a new Sting is declared and being assigned a literal, like `String c = "hello"`,
it first goes the the Runtime Constant Pool - String Constants to check if there's any existing value.

## 服务器集群session数据同步问题

- session集中存储，可以存在数据库中或者分布式存储如memcached
- 把服务器信息存在session中
- session存在cookies中，可以从cookies中还原
- session在不同服务器之间同步

- <http://www.cnblogs.com/kevin1215/p/4566668.html>
- <http://blog.csdn.net/kk936321732/article/details/45484121>

## Links

- <http://www.programcreek.com/>
