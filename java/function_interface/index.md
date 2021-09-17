---
layout: default
title: Java 8 - Function Interface
folder: stream
permalink: /archive/java/function_interface/
---

# Java 8 - Function Interface

## Consumer

消费者接口，直接操作 Object ，没有输出。

Abstract Methods: `void accept(T t)`
	
常用于 `stream.forEach(s -> System.out.println(s))`， forEach 里面的就是一个 Consumer，这里用于打印流里面的值。

## Supplier

提供者接口，传入一个 Object ，然后输出。

Abstract Methods: `T get()`

常用于 `stream.filter(i -> i > 10).findFirst().orElseGet(-1)`，orElseGet 里面就是一个 Supplier，这里用于返回一个默认值。

## Predicate

判断接口，传入一个 Object ，然后做一些判断，输出 true / false 。

Abstract Methods: `boolean test(T t)`

常用于 `stream.filter(i -> i > 10).collect(Collectors.toList());`，filter 里面就是一个 Predicate，这里用于找出所有大于10的数。

## Function

函数接口，做转换，传入一个类型为 T 的对象，输出一个类型为 R 的对象。

Abstract Methods: `R apply(T t)`

常用于 `stream.map(s -> s.length);`，map 里面就是一个 Function，这里是把统计流里面的字符串的长度。

## 参考

- <https://www.cnblogs.com/SIHAIloveYAN/p/11288064.html>
