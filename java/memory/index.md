---
layout: default
title: Java - JVM Memory
folder: memory
permalink: /archive/java/memory/
---

# Java - JVM Memory

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

## Links
- <https://stackoverflow.com/questions/10209952/what-is-the-purpose-of-the-java-constant-pool>
- <https://stackoverflow.com/questions/13624462/where-does-class-object-reference-variable-get-stored-in-java-in-heap-or-stac>
