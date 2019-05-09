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

## Database

SQL Query -- see [here](https://github.com/chennanni/note-tech/blob/master/sql/query/index.md)
- find duplicate
- reusable sql

JDBC -- see [here](http://chennanni.github.io/note-tech/archive/jdbc)
- Describe data flow/module from Java App to DB.
- How to use JDBC?
- sp1, sp2, sp3, fail in sp2, is sp1 saved to db? - depends on the program, autocommit & savepoint
- Why `Class.forName("oracle.jdbc.driver.OracleDriver")`, not decide from url when creating Connection? - design approach, open for all driver impl

Oracle DB
- ACID? - Atomicity, Consistency, Isolation, Durability.
- How to ensure Transaction atomicity? -> log
- Transaction Isolation Level? What's the default setting for Oracle/JDBC?

## Dev - Shell

- Check log in real time? - `tail -fn 100`
- Delete old date's data to free at least 50% of space?
- xargs cmd?

## Dev - Build

Maven
- Where Maven download dependency? - local -> central -> remote
- A->B(v1.1), C->D->E->B(v1.2), how many B in project? 一个，短路优先，先声明优先。
- How to solve dependency conflict? - Exclusion.

[https://github.com/chennanni/note-tech/blob/master/build/maven/index.md](https://github.com/chennanni/note-tech/blob/master/build/maven/index.md)

## Dev - Test

JUnit Test
- Given a funciton `void removeHeadAndPersistToDb(List<Obj> list)`, write test cases/code.
- What is mock and Why using it? - Mokito/Power Mock
- How to check test coverage? - Jacoco

## Dev - Log

Log4j
- How to avoid too many processing log? - set debug level
- How to rename log file name? - change in property file

[http://chennanni.github.io/note-tech/archive/log/](http://chennanni.github.io/note-tech/archive/log/)

## Dev - Version Control

Git 
- Branching Strategy?
- Commit, push, and found error msg saying remote is ahead of local, what to do in this case? - Rebase.
- Rebase v.s. Merge? - Rewrite commit history or not.
- Release branch is applied several ad-hoc fix commits, how to apply that to current dev branch? - Cherry-pick.

[http://chennanni.github.io/note-tech/archive/git](http://chennanni.github.io/note-tech/archive/git)

## Framework - Design Pattern

- Singleton
- Factory
- Template
- Decorator
- Proxy

## Framework - Web

TCP/IP
- 三次握手?

Servlet
- Explain Servlet life cycle? init, service, destory
- Is Servlet thread safe? - no
- Is Spring MVC thread safe? - yes

RESTful
- What is RESTful?
- What's response format? - json, xml, csv...

Spring
- Explain DI? 
- Explain AOP?

Struts
- Explain Workflow.
- Is Action class thread safe?

Hibernate
- Why use hibernate?
- Explain lazy loading in hibernate?
- Explain cache in hibernate?

[https://www.cnblogs.com/Java3y/p/8535459.html](https://www.cnblogs.com/Java3y/p/8535459.html)
