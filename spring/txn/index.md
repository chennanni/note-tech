---
layout: default
title: Spring - Txn
folder: txn
permalink: /archive/spring/txn/
---

# Spring - Txn

## 事务的特性

ACID
- 原子性（Atomicity）
- 一致性（Consistency）
- 隔离性（Isolation）
- 持久性（Durability）

说明：
- 前两项，AC，其实是一个意思，即事务要么全部完成，要么全部失败。比如我在一个事务里插入10条数据，要么全部都进到DB了，要么一条都没进。不可能出现进了一部分的情况。
- I，隔离性，即不同事务之间是隔离的，防止并发时发生问题。
- D，持久性，即事务完一旦成了数据就被记录下来了，即使之后宕机也没关系。

## 配置模式

### 1. 编程式事务管理

即使用`TransactionTemplate`或者`PlatformTransactionManager`，显示地将事务操作包裹在其中。如下：

~~~
EntityManagerFactory factory = Persistence.createEntityManagerFactory("PERSISTENCE_UNIT_NAME");
EntityManager entityManager = entityManagerFactory.createEntityManager();
Transaction transaction = entityManager.getTransaction()
try
{
   transaction.begin();
   someBusinessCode();
   transaction.commit();
}
catch(Exception ex)
{
   transaction.rollback();
   throw ex;
}
~~~

### 2. 声明式事务管理

即使用annotations`@`，标记需要进行事务操作的`method`, `class`, `interface`(not recomended as not working in some cases)。

> 声明式事务管理建立在AOP之上，其本质是对方法前后进行拦截，然后在目标方法开始之前创建或者加入一个事务，执行完目标方法之后根据执行的情况提交或者回滚。

Step 1: Config
~~~
<!--  Transaction Manager --> 
<bean id="txManager" class= "org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource"/>
</bean>

<tx:annotation-driven proxy-target-class="true" transaction-manager="txManager" />
~~~

Step 2: Use

~~~
public class SomeDAO {
    @Transactional(propagation= Propagation.REQUIRES_NEW, isolation= Isolation.READ_COMMITTED, readOnly=false)
    public void insert(JdbcTemplate jdbcTemplate) {
        System.out.println("INSERT RECORDS");
        for (int i =0; i<100; i++) {
            System.out.println(i);
            jdbcTemplate.execute(INSERT_SQL);
        }
        System.out.println("INSERT ERROR RECORDS");
    }
}
~~~

## 事务的传播机制 - PROPAGATION

Spring事务传播机制：规定了事务方法发生”嵌套调用”时事务如何进行传播。

- `PROPAGATION_REQUIRED`，如果当前没有事务，就新建一个事务，如果已经存在一个事务中，加入到这个事务中。
- `PROPAGATION_REQUIRES_NEW`，总是新建事务，如果当前存在事务，把当前事务挂起。
- `PROPAGATION_NESTED`，如果当前存在事务，则在嵌套事务内执行。

- `PROPAGATION_SUPPORTS`，支持当前事务，如果当前没有事务，就以非事务方式执行。
- `PROPAGATION_NOT_SUPPORTED`，不支持当前事务，如果当前存在事务，就把当前事务挂起，以非事务方式执行操作。

- `PROPAGATION_MANDATORY`，必须被拥有事务的业务方法调用。
- `PROPAGATION_NEVER`，不能被拥有事务的其它业务方法调用。

<http://www.cnblogs.com/softidea/p/5962612.html>

## 事务的隔离级别 - ISOLATION

并发可能导致的问题
- 脏读（Dirty read）
- 不可重复读（Nonrepeatable read）
- 幻读（Phantom reads）

~~~
ISOLATION_DEFAULT：使用后端数据库默认的隔离级别
ISOLATION_READ_UNCOMMITTED：允许读取尚未提交的更改。可能导致脏读、幻读或不可重复读。
ISOLATION_READ_COMMITTED：（Oracle 默认级别）允许从已经提交的并发事务读取。可防止脏读，但幻读和不可重复读仍可能会发生。
ISOLATION_REPEATABLE_READ：（MYSQL默认级别）对相同字段的多次读取的结果是一致的，除非数据被当前事务本身改变。可防止脏读和不可重复读，但幻读仍可能发生。
ISOLATION_SERIALIZABLE：完全服从ACID的隔离级别，确保不发生脏读、不可重复读和幻影读。这在所有隔离级别中也是最慢的，因为它通常是通过完全锁定当前事务所涉及的数据表来完成的。
~~~

## 链接

- 知识点总结：[有关Spring事务，看这一篇就足够了](https://www.cnblogs.com/mseddl/p/11577846.html)
- 结合代码更加细致的分析：[Effective Spring Transaction Management](https://dzone.com/articles/spring-transaction-management)
- 例子：[Spring Transaction Management JDBC Example](https://www.netjstech.com/2018/08/spring-transaction-management-jdbc-example-using-transactional-annotation.html)
