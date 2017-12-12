---
layout: default
title: Java - Stream
folder: stream
permalink: /archive/java/stream/
---

# Java - Stream

## 什么是Stream

Stream是对Collection功能的增强，它专注于对集合进行各种便利高效的聚合操作aggregate operation，或者大批量数据操作bulk data operation。

Stream就像一个高级版本的Iterator，用户指明想要进行的操作，它会在内部隐式地遍历，做出相应的数据转换。

## Stream特点

- Stream API借助于Lambda Exrepssion，极大的提高编程效率和程序可读性。
- 它提供串行和并行两种模式进行操作，并发模式能够充分利用多核处理器的优势，使用fork/join并行方式来拆分任务和加速处理过程。

## Stream的构成

一般使用Stream的时候，有三个步骤：

- 获取一个数据源（产生）
- 数据转换（中间操作）
- 执行操作获取想要的结果（最后操作）

每次转换完成后，返回一个新的Stream对象，可以对其继续进行其他转换。这就允许Stream操作可以像链条一样排列，变成一个管道。

## Stream的数据源

Collections, Arrays, or I/O resources
- Collection.stream()
- Collection.parallelStream()
- Arrays.stream(T array)
- Stream.of(T... values)

构造流的几种常见方法
~~~ java
// 1. Individual values
Stream stream1 = Stream.of("a", "b", "c");
// 2. Arrays
String [] strArray = new String[] {"a", "b", "c"};
Stream stream2 = Stream.of(strArray);
Stream stream3 = Arrays.stream(strArray);
// 3. Collections
List<String> list = Arrays.asList(strArray);
Stream stream4 = list.stream();
~~~

流转换为其它数据结构
~~~ java
// 1. Array
String[] strArray1 = stream.toArray(String[]::new);
// 2. Collection
List<String> list1 = stream.collect(Collectors.toList());
List<String> list2 = stream.collect(Collectors.toCollection(ArrayList::new));
Set set1 = stream.collect(Collectors.toSet());
Stack stack1 = stream.collect(Collectors.toCollection(Stack::new));
// 3. String
String str = stream.collect(Collectors.joining()).toString();
~~~

## Stream的操作

流的操作类型分为两种：
- Intermediate： 一个流可以后面跟随零个或多个intermediate操作。其目的主要是打开流，做出某种程度的数据映射/过滤，然后返回一个新的流，交给下一个操作使用。这类操作仅仅调用到这类方法，并没有真正开始流的遍历。
  - map
  - filter
  - distinct
  - sorted
  - peek
  - limit
  - skip
  - parallel
  - sequential
  - unordered
- Terminal：一个流只能有一个terminal操作，当这个操作执行后，流就被使用“光”了，无法再被操作。Terminal操作的执行，才会真正开始流的遍历，并且会生成一个结果，或者一个side effect。
  - forEach
  - forEachOrdered
  - toArray
  - reduce
  - collect
  - min
  - max
  - count
  - anyMatch
  - allMatch
  - noneMatch
  - findFirst
  - findAny
  - iterator

## 常见用例

所有的单词转换为大写
~~~ java
List<String> output = wordList.stream()
	.map(String::toUpperCase)
	.collect(Collectors.toList());
~~~

过滤数组，只留下偶数
~~~ java
Integer[] sixNums = {1, 2, 3, 4, 5, 6};
Integer[] evens = Stream.of(sixNums)
	.filter(n -> n%2 == 0)
	.toArray(Integer[]::new);
~~~


对一个人员集合遍历，找出男性并打印姓名
~~~ java
roster.stream()
 .filter(p -> p.getGender() == Person.Sex.MALE)
 .forEach(p -> System.out.println(p.getName()));
~~~

找出最长一行的长度
~~~ java
BufferedReader br = new BufferedReader(new FileReader("c:\\SUService.log"));
int longest = br.lines()
	.mapToInt(String::length)
	.max()
	.getAsInt();
br.close();
System.out.println(longest);
~~~

## Reference

- <https://www.ibm.com/developerworks/cn/java/j-lo-java8streamapi/>
- <https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html>
