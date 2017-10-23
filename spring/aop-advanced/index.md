---
layout: default
title: Spring - AOP Advanced
folder: aop-advanced
permalink: /archive/spring/aop-advanced/
---

# Spring AOP Advanced

AOP的实现原理：
- 通过预编译方式
- 运行期动态代理

两者比较：
- AspectJ在编译时就增强了目标对象，Spring AOP的动态代理则是在每次运行时动态的增强，生成AOP代理对象。区别在于生成AOP代理对象的时机不同。
- 相对来说AspectJ的静态代理方式具有更好的性能，但是AspectJ需要特定的编译器进行处理，而Spring AOP则无需特定的编译器处理。

## 使用AspectJ在编译时修改class文件

原理：在编译阶段，在切面上，使用AOP代理类替换原有的类。

## 使用Spring AOP并采用动态代理的模式

- JDK动态代理：通过”接口”的方式实现动态代理
- CGLIB动态代理：通过”继承”的方式实现动态代理

## Links

- <http://www.importnew.com/24305.html>
- <http://blog.csdn.net/jeffleo/article/details/61205623>