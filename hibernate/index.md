---
layout: default
title: Hibernate
folder: hibernate
permalink: /archive/hibernate/
---

# Hibernate

## ORM

Object Relational Mapping

converting data between **relational databases** and **object oriented programming languages** such as Java

![hibernate_highlevel](img/hibernate_highlevel.png)

## Advantages

- takes care of mapping Java classes to database tables using XML files and without writing any line of code
- Provides simple APIs for storing and retrieving Java objects directly to and from the database.
- Minimize database access with smart fetching strategies.

总结：千言万语汇成一句，就是用起来方便。对于数据库的读写，Dev不需要写那么多SQL，而是直接进行Object操作就可以。

## Architecture

宏观上看，Hibernate连接了Java Applicaiton和DB。更细节地说，这种linkage通过以下两个方面实现：

- Hibernate.Properties(`hibernate.cfg.xml`) -> link hibernate to database
- XML Mapping(`Entity.xml` or using `Annotation`) -> link object to table

![hibernate_arch_1](img/hibernate_arch_1.png)

更加深入地看：

- Hibernate和DB之间其实还是通过JDBC等连接起来的
- Hibernate自身也可以分为多个模块：Configuration，Session，Query，Txn等等，这些都是我们编程的时候会接触到的

![hibernate_arch_2](img/hibernate_arch_2.png)

## Steps to use Hibernate

- pre 
  - （把需要map的两个东西准备好）
  - create persisted classes
  - create database tables
- core
  - dependency: jar / import
  - link Hibernate to DB: create `hibernate.cfg.xml`
  - do mapping: create xml / annotation
  - start query: create transaction class

**Persistent Class**

需要persist的类

Java classes whose objects or instances will be stored in database tables are called persistent classes in Hibernate.

- All Java classes that will be persisted need a default constructor.
- All classes should contain an ID in order to allow easy identification of your objects within Hibernate and the database. This property maps to the primary key column of a database table.
- All attributes that will be persisted should be declared private and have getXXX and setXXX methods defined in the JavaBean style.

e.g. <code>Employee.java</code>

~~~ java
public class Employee {
   private int id;
   private String firstName; 

   public Employee() {}
   public Employee(String fname) {
      this.firstName = fname;
   }
   public int getId() {
      return id;
   }
   public void setId( int id ) {
      this.id = id;
   }
   public String getFirstName() {
      return firstName;
   }
   public void setFirstName( String first_name ) {
      this.firstName = first_name;
   }
}
~~~

**Hibernate Configuration**

link hibernate to database

e.g. `hibernate.cfg.xml`

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE hibernate-configuration SYSTEM 
"http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">

<hibernate-configuration>
   <session-factory>
	   
	   <property name="hibernate.dialect">
		  org.hibernate.dialect.MySQLDialect
	   </property>
	   <property name="hibernate.connection.driver_class">
		  com.mysql.jdbc.Driver
	   </property>
	   <!-- Assume test is the database name -->
	   <property name="hibernate.connection.url">
		  jdbc:mysql://localhost/test
	   </property>
	   <property name="hibernate.connection.username">
		  root
	   </property>
	   <property name="hibernate.connection.password">
		  root123
	   </property>

	   <!-- List of XML mapping files -->
	   <mapping resource="Employee.hbm.xml"/>
	   
	</session-factory>
</hibernate-configuration>
~~~

**Mapping Files (xml/annotation)**

map persistent class to database table

e.g. `employee.xml`

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE hibernate-mapping PUBLIC 
 "-//Hibernate/Hibernate Mapping DTD//EN"
 "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd"> 

<hibernate-mapping>
   <class name="Employee" table="EMPLOYEE">
      <meta attribute="class-description">
         This class contains the employee detail. 
      </meta>
      <id name="id" type="int" column="id">
         <generator class="native"/>
      </id>
      <property name="firstName" column="first_name" type="string"/>
      <property name="lastName" column="last_name" type="string"/>
      <property name="salary" column="salary" type="int"/>
   </class>
</hibernate-mapping>
~~~

**Transanction Class**

~~~ java
Configuration cfg = new Configuration();
cfg.configure("hibernate.cfg.xml");

SessionFactory factory = cfg.buildSessionFactory();
Session session=factory.openSession();
Transaction t=session.beginTransaction();

// do something ...

t.commit();
session.close();
~~~

## O/R Mapping

**Collection Mapping**

- java.util.Set -> `<set>`
- java.util.List -> `<list>`
- java.util.Map -> `<map>`
- Arrays -> `<array>` or `<primitive-array>`

**Association Mapping**
- many-to-one
- one-to-one
- one-to-many
  - using `<set>`
- many-to-many

**Component Mapping**

mapping a component of an object

e.g.

~~~ java
public class Employee {  
	private int id;  
	private String name;  
	private Address address; // has-a relationship
	...
}
~~~

~~~ xml
<class name="com.XXX.Employee" table="emp">  
	<id name="id">
		<generator class="increment"></generator>  
	</id>
	
	<property name="name"></property>  
	  
	<component name="address" class="com.XXX.Address">  
		<property name="city"></property>  
		<property name="country"></property>  
		<property name="pincode"></property>  
	</component>
</class>  
~~~

## Syntax

### Annotations

**@Entity**

specify the entity class

**@Table**

specify the table used in the database

attributes: name

**@Id & @GenarateValue**

specify the primary key

by default, @id will automatically determine the most appropriate primary key generation strategy
but you can override this by applying the @GeneratedValue annotation which takes two parameters strategy and generator

**@Column**

attributes

- name
- length
- nullable
- unique

~~~ java
import javax.persistence.*;

@Entity
@Table(name = "EMPLOYEE")
public class Employee {
     @Id @GeneratedValue
     @Column(name = "id")
     private int id;

     @Column(name = "first_name")
     private String firstName;
     ...
}
~~~ 

**Logger**

in the hibernate configuration file

`<property name="show_sql">true</property>`

### HQL

Hibernate Query Language, HQL works with persistent objects and their properties.

**FROM**

load a complete persistent object

```
String hql = "FROM Employee";
Query query = session.createQuery(hql);
List results = query.list();
```

**SELECT**

obtain properties of objects

```
String hql = "SELECT E.firstName FROM Employee E";

```

**Using Named Parameter**

accept input from the user easy

```
String hql = "FROM Employee E WHERE E.id = :employee_id";
Query query = session.createQuery(hql);
query.setParameter("employee_id",10);
List results = query.list();
```

**UPDATE**

update properties of objects

```
String hql = "UPDATE Employee set salary = :salary "  + 
             "WHERE id = :employee_id";
Query query = session.createQuery(hql);
query.setParameter("salary", 1000);
query.setParameter("employee_id", 10);
int result = query.executeUpdate();
System.out.println("Rows affected: " + result);
```

**DELETE**

```
String hql = "DELETE FROM Employee "  
	+ "WHERE id = :employee_id";
```

**INSERT**

```
String hql = "INSERT INTO Employee(firstName, lastName, salary)"  
	+ "SELECT firstName, lastName, salary FROM old_employee";
```

**Aggregate Methods**

- avg()
- count()
- max()
- min()
- sum()

**Pagination**

- Query setFirstResult(int startPosition)
- Query setMaxResults(int maxResult)

## Load Type

The fetch type essentially decides whether or not to load all of the relationships of a particular object/table as soon as the object/table is initially fetched.

- (fetch=FetchType.**EAGER**): load it in the first place
- (fetch=FetchType.**LAZY**): load it only when the object is needed

by default, primitive values are fetched EAGER, **collection objects are fetched LAZY**.

当Hibernate在查询数据的时候，数据并没有存在与内存中。当程序真正对数据操作时，对象才存在与内存中，实现了延迟加载。这样节省了服务器的内存开销，从而提高了服务器的性能。

e.g.

~~~ xml
  import javax.persistence.FetchType;
  //....
  @OneToOne(fetch=FetchType.EAGER)
  @JoinColumn(name="user_profile_id")
  private Profile getUserProfile()
  {
    return userProfile;
  }
~~~ 

see more here: <http://stackoverflow.com/questions/2990799/difference-between-fetchtype-lazy-and-eager-in-java-persistence>

## Object Type

Hibernate中对象的三种状态：

- 临时/瞬时状态
  - 直接new出来的对象就是临时/瞬时状态的
- 持久化状态
  - 当调用session的`save/saveOrUpdate/get/load/list`等方法的时候，对象就是持久化状态
  - 当对对象属性进行更改的时候，会反映到数据库中
- 游离状态
  - 当Session关闭了以后，持久化的对象就变成了游离状态

## Caching

![hibernate_caching](img/hibernate_caching.png)

### First Level

The first-level cache is the **Session** cache and is a mandatory cache through which all requests must pass.

一级缓存只在Session范围有效。Session关闭，一级缓存失效。

Session的缓存由 hibernate 维护，用户不能操作缓存内容。如果想操作缓存内容，必须通过 hibernate 提供的`evit`/`clear`方法操作。

### Second Level

The second-level cache can be configured on a per-class and per-collection basis and mainly responsible for caching objects across sessions. It is **Session Factory** cache.

由于一次缓存Session关闭失效，有些常用的静态对象/类，更加适合放在二级缓存中。

二级缓存是基于应用程序的缓存，所有的Session都可以使用。

Hibernate提供的二级缓存有默认的实现，且是一种可**插配**的缓存框架！如果用户想用二级缓存，只需要在`hibernate.cfg.xml`中配置即可。不想用，直接移除，不影响代码。
如果觉得默认的不好用，也可以使用其它缓存框架。

***Step 1***: decide which concurrency strategy to use

~~~ xml
<hibernate-mapping>
   <class name="Employee" table="EMPLOYEE">
      ...
      <cache usage="read-write"/>
     ...
   </class>
</hibernate-mapping>
~~~ 

***Step 2***: configure cache expiration and physical cache attributes using the cache provider

Cache provider

- EHCache
- OSCache
- warmCache
- JBoss Cache

e.g. choose EHCache as our second-level cache provider

~~~ xml
<hibernate-configuration>
    <session-factory>
        <property name="hibernate.cache.provider_class">
         org.hibernate.cache.EhCacheProvider
        </property>
    </session-factory>
</hibernate-configuration>
~~~ 

e.g. specify the properties of the cache regions, like the code below

(EHCache has its own configuration file, ehcache.xml, which should be in the CLASSPATH of the application.)

~~~ xml
<diskStore path="java.io.tmpdir"/>
<defaultCache
maxElementsInMemory="1000"
eternal="false"
timeToIdleSeconds="120"
timeToLiveSeconds="120"
overflowToDisk="true"
/>

<cache name="Employee"
maxElementsInMemory="500"
eternal="true"
timeToIdleSeconds="0"
timeToLiveSeconds="0"
overflowToDisk="false"
/>
~~~ 

## Connection Pooling

Hibernate comes with internal connection pool, but not suitable for production use. 
It's recommended to use a third party connection pool such as `C3P0`.

e.g. `hibernate.cfg.xml`

~~~ 
hibernate.connection.driver_class = org.postgresql.Driver
hibernate.connection.url = jdbc:postgresql://localhost/mydatabase
hibernate.connection.username = myuser
hibernate.connection.password = secret

hibernate.c3p0.min_size=5
hibernate.c3p0.max_size=20
hibernate.c3p0.timeout=1800
hibernate.c3p0.max_statements=50

hibernate.dialect = org.hibernate.dialect.PostgreSQLDialect
~~~ 

- <https://docs.jboss.org/hibernate/orm/3.3/reference/en-US/html/session-configuration.html>
- <http://www.mkyong.com/hibernate/how-to-configure-the-c3p0-connection-pool-in-hibernate>

## Txn

Hibernate本身不提供事务控制行为（没有添加任何附加锁定的行为），而是直接在 Hibernate 底层使用：
- JDBC事务
- JTA事务（分布式事务）
- CMT事务（容器事务）

所以，一般来说，只要为JDBC连接指定一下隔离级别，就够了。

### 隔离级别

~~~
1：Read Uncommitted 
2：Read Committed 
4：Repeatable Read 
8：Serializable 
~~~

例如，把`hibernate.cfg.xml`文件中的隔离级别设为Read Committed： 

~~~
hibernate.connection.isolation=2 
~~~

### 锁

进阶地，也可以给query语句加锁。这里分为两种：

- 乐观锁：不锁定表，一般是通过version实现，如果发现version更新了，就放弃写入。
- 悲观锁：锁定表，只需我自己操作，不许别人操作。

一个悲观锁的例子是：

~~~ java
String hqlStr="from TUser user where user.name='Erica'";  
Query query=session.createQuery(hqlStr);    
query.setLockMode("user"，LockModel.UPGRADE);
~~~

### 操作单元

Unit of work, 有这样一个问题，多久开一次Session？

是每一次数据库读写都开一个Session吗？（也就是`session-per-operation`）显然这样浪费资源。

比较合理是`session-per-request`，每一个请求进来，我们开一个Session，然后把所有数据库读写放一起做。

## Questions

参考 -> Hibernate最全面试题 <https://www.cnblogs.com/Java3y/p/8535459.html>

### JDBC 和 ibatis 和 hibernate 的区别

jdbc:手动
- 手动写sql
- delete、insert、update要将对象的值一个一个取出传到sql中,不能直接传入一个对象。
- select:返回的是一个resultset，要从ResultSet中一行一行、一个字段一个字段的取出，然后封装到一个对象中，不直接返回一个对象。

ibatis的特点:半自动化
- sql要手动写
- delete、insert、update:直接传入一个对象
- select:直接返回一个对象

hibernate:全自动
- 不写sql,自动封装
- delete、insert、update:直接传入一个对象
- select:直接返回一个对象

### hibernate 里 sorted collection 和 ordered collection 有什么区别

sorted collection
- 是在内存中通过Java比较器进行排序的

ordered collection
- 是在数据库中通过order by进行排序的

对于比较大的数据集，为了避免在内存中对它们进行排序而出现 Java中的OutOfMemoryError，最好使用ordered collection。

### hibernate get 和 load 区别

- `get()`如果没有找到会返回null，`load()`如果没有找到会抛出异常。
- `get()`是立即查询，`load()`是懒加载。
- `get()`会先查一级缓存，再查二级缓存，然后查数据库；`load()`会先查一级缓存，如果没有找到，就创建代理对象，等需要的时候去查询二级缓存和数据库。

### hibernate persist 和 save 区别

- `persist()`不保证立即执行，可能要等到`flush()`；`save()`会立即执行 sql insert
- `persist()`不更新缓存；`save()`更新缓存
- `persist()`无返回值；`save()`有返回值（一般是对应记录的主键值）

参考 -> <http://blog.csdn.net/u010739551/article/details/47253881>

### hibernate getCurrentSession 和 openSession 区别

- `getCurrentSession()` 是使用当前Session Factory里面的Session，Session由Factory管理；`openSession()`是创建一个新的Session，且需要我们手动关闭。
- `getCurrentSession()`事务是有spring来控制的；而`openSession()`需要我们手动开启和手动提交事务。

## Links

- [viralpatel hibernate tutorial](http://viralpatel.net/blogs/introduction-to-hibernate-framework-architecture/)
- [mkyong hibernate tutorial](http://www.mkyong.com/tutorials/hibernate-tutorials/)
