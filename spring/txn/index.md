---
layout: default
title: Spring - Txn
folder: txn
permalink: /archive/spring/txn/
---

# Spring - Txn

Spring事务传播机制：规定了事务方法发生”嵌套调用”时事务如何进行传播。

⁃ PROPAGATION_REQUIRED，如果当前没有事务，就新建一个事务，如果已经存在一个事务中，加入到这个事务中。
⁃ PROPAGATION_REQUIRES_NEW，总是新建事务，如果当前存在事务，把当前事务挂起。
⁃ PROPAGATION_NESTED，如果当前存在事务，则在嵌套事务内执行。

⁃ PROPAGATION_SUPPORTS，支持当前事务，如果当前没有事务，就以非事务方式执行。
⁃ PROPAGATION_NOT_SUPPORTED，不支持当前事务，如果当前存在事务，就把当前事务挂起，以非事务方式执行操作。

⁃ PROPAGATION_MANDATORY，必须被拥有事务的业务方法调用。
⁃ PROPAGATION_NEVER，不能被拥有事务的其它业务方法调用。

<http://www.cnblogs.com/softidea/p/5962612.html>