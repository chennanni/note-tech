---
layout: default
title: Gemfire
folder: gemfire
permalink: /archive/gemfire/
---

# Gemfire

## 介绍

分布式缓存，在金融领域应用广泛。

特点
- 基于内存，高性能
- 多样的Cache部署策略：P2P;Client/Server;Clusters
- 数据可以在不重启服务的情况下重新切割和平衡
- 数据高可用性和容错性

## 竞争对手

- Redis
- Memcached
- Coherence
- Apache Ignite

## 历史

- 2002：GemStone公司正式发布，成为业界J2EE JCache JSR107标准的中间件。
- 2008：借着金融危机之际凭着其实力击败老牌厂商Oracle, 大举进入华尔街金融领域。
- 2010：收购并入SpringSource部门作为进军Cloud以及大数据的入口。
- 2015：核心模块开源为Apache Geode核心项目。

## 核心概念

Region：数据存储的节点，在Java中类似Map，在数据库中类似Table，支持查询和事务。

官方分类如下：
- Partitioned: Data is divided into buckets across the members that define the region.
- Replicated (distributed): Holds all data from the distributed region.
- Distributed non-replicated: Data is spread across the members that define the region. Each member holds only the data it has expressed interest in.
- Non-distributed (local): The region is visible only to the defining member.

总结如下：
- 分布式：数据被均匀分布在各个NODE上
- 复制式：每个NODE都包含完整的数据
- 本地式：REGION上的数据只对LOCAL可见

REGION是GEMFIRE的核心，一方面，我们把数据缓存在REGION中，另一方面，也从REGION中拿数据。

## CLIENT/SERVER 架构

~~~
client <-> locator <-> server
~~~

LOCATOR：提供了发现和负载均衡服务。 
客户端配置LOCATOR的服务列表，LOCATOR维护SERVER的动态列表。

CLIENT端有REGION，SERVER端也有REGION，这些REGION通过LOCATOR关联起来。 
- 有的CLIENT REGION可能是SERVER REGION的一个REPLICATION。 
- 有的CLIENT REGION可能是SERVER REGION的一个PROXY。 
- 这些在配置时可以指明。

## Region Type (Spring)

以下是SPRING DATA GEMFIRE对于REGION TYPE的分类:

- Partitioned
  - Data is partitioned into buckets (sharded) among cache members that define the Region.
  - This provides high read and write performance and is suitable for large data sets that are too big for a single node.
  - `<partitioned-region>`
- Replicated
  - Data is replicated across all cache members that define the Region.
  - This provides very high read performance but writes take longer to perform the replication.
  - `<replicated-region>`
- Local
  - Data only exists on the local node.
  - `<local-region>`
- Client
  - A client Region is a LOCAL Region that acts as a PROXY to a REPLICATE or PARTITION Region hosted on cache servers in a cluster.
  - It may hold data created or fetched locally.
  - `<client-region>`

示例：
  
~~~ xml
<!-- 1 -->
<gfe:partitioned-region id="examplePartitionRegion" copies="2" total-buckets="17">
  <gfe:partition-resolver>
    <bean class="example.PartitionResolver"/>
  </gfe:partition-resolver>
</gfe:partitioned-region>

<!-- 2 -->
<gfe:replicated-region id="exampleReplica"/>
~~~

- [Spring Data Gemfire - Region](https://docs.spring.io/spring-data-gemfire/docs/current/reference/html/#bootstrap:region)
- [Apache Geode - Region Types](https://geode.apache.org/docs/guide/11/developing/region_options/region_types.html)

## Client Region Shortcut (Spring)

当REGION是CLIENT REGION时，还可以为它指定额外属性SHORTCUT。进一步定义它是如何与SERVER REGION进行交互。

- LOCAL: A LOCAL region only has local state and never sends operations to a server.
- PROXYL: A PROXY region has no local state and forwards all operations to a server.
- CACHING_PROXY: A CACHING_PROXY region has local state but can also send operations to a server.

示例：

~~~ xml
<gfe:client-cache/>

<gfe:client-region id="Example" shortcut="LOCAL"/>
~~~

- [ClientRegionShortcut API](https://geode.apache.org/releases/latest/javadoc/org/apache/geode/cache/client/ClientRegionShortcut.html)

## Other Region Config (Spring)

- disk-store: used to persist the data in disk
- cache-listener: registered with a Region to handle Region events such as when entries are created, updated, destroyed and so on
- cache-loader: invoked on a cache miss to allow an entry to be loaded from an external data source, such as a database

## Example with Pivotal Gemfire Cmd

In this example, we start a server, locator. 
Open a client, connect to the locator, then do some operation.

Step 1: install Pivotal Gemfire

Step 2: start a locator

~~~
gfsh>start locator --name=locator1
~~~

Step 3： start a server

~~~
gfsh>start server --name=server1 --server-port=40411
~~~

Step 4: create a region

~~~
gfsh>create region --name=regionA --type=REPLICATE_PERSISTENT
gfsh>list regions
gfsh>list members
gfsh>describe region --name=regionA
~~~

Step 5: manipulate data

~~~
gfsh>put --region=regionA --key="1" --value="one"
gfsh>put --region=regionA --key="2" --value="two"
gfsh>query --query="select * from /regionA"
~~~

Step 6: start a new window, connect to the same locator and query

~~~
gfsh>connect --locator=localhost[10334]
gfsh>query --query="select * from /regionA"
~~~

Step 7: shout down

~~~
gfsh>shutdown --include-locators=true
~~~

- [Pivotal GemFire in 15 Minutes or Less](https://gemfire.docs.pivotal.io/gemfire/getting_started/15_minute_quickstart_gfsh.html)

## Example with Spring

In this example, we have 
- A SERVER, which holds Cache Server & Region.
- A CLIENT, which holds Locator & Client Region.

1. On startup, SERVER starts all components and standby. Its Cache Server is bind to the port of Locator. 
2. CLIENT creates a Client Region with CACHING_PROXY, which means updates will send to SERVER but it also has a local copy of the data. Then it does some modification. 
3. We can see changes in both SERVER and CLIENT.

Note: Compared to Pivotal Gemfire, Spring Data Gemfire has a Cache Object, to hold Region.

server/cache-config.xml

~~~ xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:util="http://www.springframework.org/schema/util"
       xmlns:gfe="http://www.springframework.org/schema/gemfire"
       xsi:schemaLocation="http://www.springframework.org/schema/gemfire http://www.springframework.org/schema/gemfire/spring-gemfire.xsd
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util.xsd">

    <!-- Cache Server-->
    <gfe:cache-server />

    <!-- Cache -->
    <gfe:cache properties-ref="gemfire-props"/>

    <!-- Region -->
    <gfe:replicated-region id="Customer">
        <gfe:cache-listener>
            <bean class="util.LoggingCacheListener"/>
        </gfe:cache-listener>
    </gfe:replicated-region>

    <!-- Others -->
    <util:properties id="gemfire-props">
        <prop key="log-level">config</prop>
    </util:properties>

</beans>
~~~

client/cache-config.xml

~~~ xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:gfe-data="http://www.springframework.org/schema/data/gemfire"
       xmlns:gfe="http://www.springframework.org/schema/gemfire"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/data/gemfire http://www.springframework.org/schema/data/gemfire/spring-data-gemfire.xsd
		http://www.springframework.org/schema/gemfire http://www.springframework.org/schema/gemfire/spring-gemfire.xsd">

    <!--The data source creates a ClientCache and connection Pool.
    In addition, it will query the cluster servers for all existing root Regions and
    create an (empty) client Region proxy for each one.-->

    <!-- Client Cache -->
    <gfe-data:datasource>
        <gfe-data:server host="localhost" port="40404" />
    </gfe-data:datasource>

    <!-- Client Region -->
    <gfe:client-region id="Customer" shortcut="CACHING_PROXY">
        <gfe:cache-listener>
            <bean class="util.LoggingCacheListener"/>
        </gfe:cache-listener>
    </gfe:client-region>

</beans>
~~~

Server

~~~ java
public class Server {
    @SuppressWarnings("unchecked")
    public static void main(String args[]) throws IOException {
        ApplicationContext context = new ClassPathXmlApplicationContext("server/cache-config.xml");
        Region<Long, Customer> region = context.getBean(Region.class);

        // bind to locator
        try {
            new ServerPortGenerator().bind(new ServerSocket(), 40404,1);
        } catch (IOException e) {
            System.out.println("Sorry port 40404 is in use. Do you have another cache server process already running?");
            System.exit(1);

        }

        // standby
        System.out.println("Press <Enter> to terminate the server");
        System.in.read();

        // output the region values
        Set<Map.Entry<Long, Customer>> set = region.entrySet();
        Iterator<Map.Entry<Long, Customer>> ite = set.iterator();
        while (ite.hasNext()) {
            Map.Entry<Long, Customer> entry = ite.next();
            System.out.println("Server - region value: " + entry.getValue().toString());
        }
    }
}
~~~

Client

~~~ java
public class Client {
    @SuppressWarnings("unchecked")
    public static void main(String args[]) throws IOException {
        ApplicationContext context = new ClassPathXmlApplicationContext("client/cache-config.xml");
        Region<Long, Customer> region = context.getBean(Region.class);

        // put some data into region
        Customer dave = new Customer(1,"Dave","Matthews");
        Customer alicia = new Customer(2,"Alicia","Keys");
        Customer bob = new Customer(3,"Bob","West");
        region.put(dave.getId(),dave);
        region.put(alicia.getId(),alicia);
        region.put(bob.getId(),bob);
        System.out.println("Client - data creation in Region complete.");

        // output the region values
        Set<Map.Entry<Long, Customer>> set = region.entrySet();
        Iterator<Map.Entry<Long, Customer>> ite = set.iterator();
        while (ite.hasNext()) {
            Map.Entry<Long, Customer> entry = ite.next();
            System.out.println("Client - region value: " + entry.getValue().toString());
        }
    }
}

~~~

- [Spring Gemfire Quick Start](https://github.com/spring-projects/spring-data-gemfire)

## 链接
- [Gemfire:分布式缓存利器](https://blog.csdn.net/erixhao/article/details/53248600)
- [Spring Data GemFire Reference Guide](https://docs.spring.io/spring-data-gemfire/docs/current/reference/html)
- [GemFire--12306背后的分布式解决方案](http://tech.it168.com/a2016/0728/2819/000002819523.shtml)
- [Gemfire简单配置并测试](https://blog.csdn.net/you8626/article/details/46563575)
- [GemFire读写示例](https://blog.csdn.net/shihuijiang/article/details/49760949)
