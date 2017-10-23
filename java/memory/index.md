---
layout: default
title: Java - Memory
folder: memory
permalink: /archive/java/memory/
---

# Java - Memory

Java Runtime JVM memory allocaiton

![java-memory](img/java-memory.png)

- Stack，栈
  - Program Counter，程序计数器
  - Java Stack，Java栈，存放local variables
  - Native Method Stack，本地方法栈
- Heap，堆，存放Objects
  - Young Generation
  - Old Generation
- Non Heap，非堆
  - Method Area，存放class files
  - Code Cache

- Java stack: Storage are for local variables(primitive variables and object references), results of intermediate operations. (One per thread)
- Native method stacks : Helps in executing native methods(methods written in languages other than java). (One per thread)
- PC Register : Stores the address of the next instruction to be executed if the next instruction is native method then the value in pc register will be undefined. (One per thread)
- Heap : Storage area for Objects. (One per JVM instance)
- Method Area : Storage area for compiled class files. (One per JVM instance)

## Links
- <https://stackoverflow.com/questions/10209952/what-is-the-purpose-of-the-java-constant-pool>
- <https://stackoverflow.com/questions/13624462/where-does-class-object-reference-variable-get-stored-in-java-in-heap-or-stac>