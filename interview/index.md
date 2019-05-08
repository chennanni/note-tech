---
layout: default
title: Interview
folder: interview
permalink: /archive/interview/
---

# Interview

## Overview

- Project
  - What is the task?
  - What you did?
  - (How you implemented it?)
  - Other Questions
    - Can you describe one of the things that brings you the most sense of achievement in your career?
    - Can you describe a memorable bug fix experience?
- Tech Questions
  - What is the tech?
  - How you use it?
  - How it's implemented? 
- [Algorithm/Code](https://github.com/chennanni/crack-leetcode)

## Java - Basic
- Access Modifiers
  - Explain private (class) < default(package) < protected(subclass) < public(global).
  - Can subclass access superclass's private variable? - Yes if in the same package, else no.
- Collection 集合
  - Collection Hierarchy -- see [here](https://github.com/chennanni/note-tech/blob/master/java/collection/index.md)
  - ArrayList vs LinkedList -- see [here](https://github.com/chennanni/note-tech/blob/master/java/questions/index.md)
  - HashMap vs Hashtable vs ConcurrentHashMap -- see [here](https://github.com/chennanni/note-tech/blob/master/java/collection/index.md)
  - HashMap Implementation -- see [here](http://blog.csdn.net/vking_wang/article/details/14166593) and [here](https://github.com/chennanni/note-tech/blob/master/java/questions/index.md)
- Exception
  - Exception Hierarchy -- see [here](https://github.com/chennanni/note-tech/blob/master/java/basic/index.md)
  - When to catch v.s. throw exception?
- Generic
  - What is Generic and why using it? -- see [here](http://chennanni.com/tech-note/archive/java/basic/)
- Misc
  - static -- see [here](https://github.com/chennanni/cheat-sheet/blob/master/java-interview-questions.md)
  - volatile -- see [here](https://github.com/chennanni/note-tech/blob/master/java/basic/index.md)
  - transient -- see [here](https://github.com/chennanni/note-tech/blob/master/java/basic/index.md)
  - Overriding vs Overloading -- see [here](https://github.com/chennanni/cheat-sheet/blob/master/java-interview-questions.md)

## Java - Advanced 
- Concurrency 并发
  - Life Cycle of a thread -- see [here](https://github.com/chennanni/note-tech/blob/master/thread/basic/index.md)
  - Implement a multithread program like "Producer & Consumer" -- see [here](http://www.cnblogs.com/linjiqin/p/3217050.html)
  - How to ensure Thread Safety -- see [here](https://github.com/chennanni/note-tech/blob/master/thread/basic/index.md)
  - Explain ReentrantLock?
  - Explain Semaphore?
- JVM
  - Class Loading
- GC
- Java 8 New Feature
  - Lambda Expressions -- see in [blog](http://www.cnblogs.com/maxstack/p/7550153.html)
    - What's the feature of Lambda Expression?
    - Write Code: sort an array in ascending order.
    - What's the return type/Object type of Lambda Expression?
  - Stream -- see in java note
    - What's the feature of Stream?
    - Does Stream processes element in serial?
    - Write Code: given a List\<Integer\>, filter out the negative values.
  - Method Reference
  - Date and Time API
  
## SQL

- Query题型 -- see [here](https://github.com/chennanni/note-tech/blob/master/sql/query/index.md)

## Shell

- Check log in real time?
- Delete old date's data to free at least 50% of space?
- xargs cmd?

## Web

  TCP/IP
  - 三次握手?

  Spring
  - Explain DI? 
  - Explain AOP?
  
  Struts

  Hibernate

## Server Side Tech

  Servlet

  EJB

  Weblogic

## Web Service

  RESTful

  SOAP

## Database Tech

- How to ensure Transaction atomicity? -> log

  JDBC

  Oracle DB

## Design Pattern
- Singleton
- Factory
- Template
- Decorator
- Proxy

## Test

### JUnit Test ###
  
  - Given a specific senario, write all test cases and test code
  - What is mock and Why using it?
  
### Testing Tools ###
  
  - Mokito
  - Power Mock
  - Jacoco
  - Sonar Cube

## Build

Maven
- Where Maven download dependency? - local -> central -> remote
- A->B(v1.1), C->D->E->B(v1.2), how many B in project? 一个，短路优先，先声明优先。
- How to solve dependency conflict? - Exclusion.

## Version Control

Git 
- Branching Strategy?
- Commit, push, and found error msg saying remote is ahead of local, what to do in this case? - Rebase.
- Rebase v.s. Merge? - Rewrite commit history or not.
- Release branch is applied several ad-hoc fix commits, how to apply that to current dev branch? - Cherry-pick.

[Link](http://chennanni.github.io/note-tech/archive/git/)
