# Dubbo

## 背景

随着互联网的发展，业务量不断增加，网站规模不断扩大，相应地，技术框架也是不断演进的。

![bg](img/bg.jpg)

- 单一应用架构 ORM
  - 当网站流量很小时，只需一个应用，将所有功能都部署在一起，以减少部署节点和成本。此时，用于简化增删改查工作量的数据访问框架(ORM)是关键。
- 垂直应用架构 MVC
  - 当访问量逐渐增大，单一应用增加机器带来的加速度越来越小，提升效率的方法之一是将应用拆成互不相干的几个应用，以提升效率。此时，用于加速前端页面开发的Web框架(MVC)是关键。
  - 举例：一个金融管理网站有10个页面，每个页面对应1个业务，我们可以把每个页面单独成一个独立的应用。
- 分布式服务架构 RPC
  - 当垂直应用越来越多，应用之间交互不可避免，将核心业务抽取出来，作为独立的服务，逐渐形成稳定的服务中心，使前端应用能更快速的响应多变的市场需求。此时，用于提高业务复用及整合的分布式服务框架(RPC)是关键。
  - 举例：10个页面增加到20个页面，也就有20个独立的应用。同时，各个应用可能有很多重合/共用的服务，比如读取用户信息，更新账户信息等等。我们把共用的服务独立出来，使用RPC调用，可以简化各个应用且将其解耦。
- 流动计算架构 SOA
  - 当服务越来越多，容量的评估，小服务资源的浪费等问题逐渐显现，此时需增加一个调度中心基于访问压力实时管理集群容量，提高集群利用率。此时，用于提高机器利用率的资源调度和治理中心(SOA)是关键。
  - 解读：实际使用中发现，有的服务用的多，需要更多机器，有的服务用的少，可以减少机器。于是我们可以使用弹性伸缩，动态加减机器数量。

<http://dubbo.apache.org/zh-cn/docs/user/preface/background.html>

## 定义

> Dubbo是一个分布式服务框架，致力于提供高性能和透明化的RPC远程服务调用方案，以及SOA服务治理方案。

> 简单的说，dubbo就是个服务框架，如果没有分布式的需求，其实是不需要用的，只有在分布式的时候，才有dubbo这样的分布式服务框架的需求，并且本质上是个服务调用的东东，说白了就是个远程服务调用的分布式框架（告别Web Service模式中的WSdl，以服务者与消费者的方式在dubbo上注册）。

分析：RMI/RPC算是已经有点“过时”的东西，但是在分布式的环境中，又有用武之地了。上面说得很明白了，Dubbo = 分布式RPC。（且可以进一步向SOA方向发展）

对比Spark，它是多个机器并行计算，但是计算的东西可以说是“一样”的。

~~~
A: function_1
B: function_1
C: function_1
D: function_1
...
~~~

对于Dubbo，它是多个机器，每台机器运行的服务可能是不一样的。

~~~
A: function_A
B: function_B
C: function_C
D: function_D
...
~~~

A机器的function_A调用B机器的function_B怎么办？这就需要Dubbo。

## 核心组件

1. 远程通讯
    - 提供对多种基于长连接的NIO框架抽象封装，包括多种线程模型，序列化，以及“请求-响应”模式的信息交换方式。
2. 集群容错
    - 提供基于接口方法的透明远程过程调用，包括多协议支持，以及软负载均衡，失败容错，地址路由，动态配置等集群支持。
3. 自动发现
    - 基于注册中心目录服务，使服务消费方能动态的查找服务提供方，使地址透明，使服务提供方可以平滑增加或减少机器。

解读：想想如果要你写一个分布式应用，需要哪些关键模块，大概就是上面的内容。
  
## 优点

1. 透明化的远程方法调用
    - 就像调用本地方法一样调用远程方法，只需简单配置，没有任何API侵入。 
2. 软负载均衡及容错机制
    - 可在内网替代F5等硬件负载均衡器，降低成本，减少单点。
3. 服务自动注册与发现
    - 不再需要写死服务提供方地址，注册中心基于接口名查询服务提供者的IP地址，并且能够平滑添加或删除服务提供者。

解读：对于开发而言，最关键的是第一点，用起来简单。第二三点，是基础服务支撑。

## 架构

![arc](img/arc.jpg)

0. 服务容器负责启动，加载，运行服务提供者。
1. 服务提供者在启动时，向注册中心注册自己提供的服务。
2. 服务消费者在启动时，向注册中心订阅自己所需的服务。
3. 注册中心返回服务提供者地址列表给消费者，如果有变更，注册中心将基于长连接推送变更数据给消费者。
4. 服务消费者，从提供者地址列表中，基于软负载均衡算法，选一台提供者进行调用，如果调用失败，再选另一台调用。
5. 服务消费者和提供者，在内存中累计调用次数和调用时间，定时每分钟发送一次统计数据到监控中心。

<http://dubbo.apache.org/zh-cn/docs/user/preface/architecture.html>

## 实战

### 启动Zookeeper

首先，下载Zookeeper <https://zookeeper.apache.org/releases.html#download>

然后，解压缩。

修改配置文件：一般位于根目录下的`conf\`目录下。

把`zoo_sample.conf`改名为`zoo.cfg`或者`zoo.conf`，Windows和Linux可能不一样。

简单使用的话，里面的内容可以不用修改。

然后，Windows系统的话，打开cmd，运行：

~~~
D:\codebase\apache-zookeeper-3.6.2-bin\bin>zkServer.cmd
~~~

运行成功的话，可以在stdout里看到zk的logo。

~~~
2020-10-21 20:13:35,251 [myid:] - INFO  [main:ZookeeperBanner@42] -
2020-10-21 20:13:35,251 [myid:] - INFO  [main:ZookeeperBanner@42] -   ______                  _
2020-10-21 20:13:35,252 [myid:] - INFO  [main:ZookeeperBanner@42] -  |___  /                 | |
2020-10-21 20:13:35,253 [myid:] - INFO  [main:ZookeeperBanner@42] -     / /    ___     ___   | | __   ___    ___   _ __     ___   _ __
2020-10-21 20:13:35,255 [myid:] - INFO  [main:ZookeeperBanner@42] -    / /    / _ \   / _ \  | |/ /  / _ \  / _ \ | '_ \   / _ \ | '__|
2020-10-21 20:13:35,255 [myid:] - INFO  [main:ZookeeperBanner@42] -   / /__  | (_) | | (_) | |   <  |  __/ |  __/ | |_) | |  __/ | |
2020-10-21 20:13:35,256 [myid:] - INFO  [main:ZookeeperBanner@42] -  /_____|  \___/   \___/  |_|\_\  \___|  \___| | .__/   \___| |_|
2020-10-21 20:13:35,256 [myid:] - INFO  [main:ZookeeperBanner@42] -                                               | |
2020-10-21 20:13:35,257 [myid:] - INFO  [main:ZookeeperBanner@42] -                                               |_|
2020-10-21 20:13:35,257 [myid:] - INFO  [main:ZookeeperBanner@42] -
~~~

继续往下，可以看到在某个的address开始service的log。

~~~
2020-10-21 20:13:35,789 [myid:] - INFO  [main:AbstractConnector@330] - Started ServerConnector@73ad2d6{HTTP/1.1,[http/1.1]}{0.0.0.0:8080}
2020-10-21 20:13:35,790 [myid:] - INFO  [main:Server@399] - Started @932ms
2020-10-21 20:13:35,791 [myid:] - INFO  [main:JettyAdminServer@182] - Started AdminServer on address 0.0.0.0, port 8080 and command URL /commands
2020-10-21 20:13:35,799 [myid:] - INFO  [main:ServerCnxnFactory@169] - Using org.apache.zookeeper.server.NIOServerCnxnFactory as server connection factory
2020-10-21 20:13:35,800 [myid:] - WARN  [main:ServerCnxnFactory@309] - maxCnxns is not configured, using default value 0.
2020-10-21 20:13:35,803 [myid:] - INFO  [main:NIOServerCnxnFactory@666] - Configuring NIO connection handler with 10s sessionless connection timeout, 1 selector thread(s), 8 worker threads, and 64 kB direct buffers.
2020-10-21 20:13:35,806 [myid:] - INFO  [main:NIOServerCnxnFactory@674] - binding to port 0.0.0.0/0.0.0.0:2181
~~~

### Dubbo代码

Maven dependency

~~~ xml
<properties>
    <dubbo.version>2.7.8</dubbo.version>
</properties>
    
<dependencies>
    <dependency>
        <groupId>org.apache.dubbo</groupId>
        <artifactId>dubbo</artifactId>
        <version>${dubbo.version}</version>
    </dependency>
    <dependency>
        <groupId>org.apache.dubbo</groupId>
        <artifactId>dubbo-dependencies-zookeeper</artifactId>
        <version>${dubbo.version}</version>
        <type>pom</type>
    </dependency>
</dependencies>
~~~

Service interfaces

~~~ java
package org.apache.dubbo.samples.api;

public interface GreetingsService {
    String sayHi(String name);
}
~~~

Provider - implement service interface

~~~ java
package org.apache.dubbo.samples.provider;

import org.apache.dubbo.samples.api.GreetingsService;

public class GreetingsServiceImpl implements GreetingsService {
    @Override
    public String sayHi(String name) {
        return "hi, " + name;
    }
}
~~~

Provider - Application: register service in Zookeeper and start serving `sayHi()` method

~~~ java
package org.apache.dubbo.samples.provider;

import org.apache.dubbo.config.ApplicationConfig;
import org.apache.dubbo.config.RegistryConfig;
import org.apache.dubbo.config.ServiceConfig;
import org.apache.dubbo.samples.api.GreetingsService;

import java.util.concurrent.CountDownLatch;

public class Application {
    private static String zookeeperHost = System.getProperty("zookeeper.address", "127.0.0.1");

    public static void main(String[] args) throws Exception {
        ServiceConfig<GreetingsService> service = new ServiceConfig<>();
        service.setApplication(new ApplicationConfig("first-dubbo-provider"));
        service.setRegistry(new RegistryConfig("zookeeper://" + zookeeperHost + ":2181"));
        service.setInterface(GreetingsService.class);
        service.setRef(new GreetingsServiceImpl());
        service.export();

        System.out.println("dubbo service started");
        new CountDownLatch(1).await();
    }
}
~~~

Consumer - Application: find service in Zookeeper and call `sayHi()` method

~~~ java
package org.apache.dubbo.samples.client;


import org.apache.dubbo.config.ApplicationConfig;
import org.apache.dubbo.config.ReferenceConfig;
import org.apache.dubbo.config.RegistryConfig;
import org.apache.dubbo.samples.api.GreetingsService;

public class Application {
    private static String zookeeperHost = System.getProperty("zookeeper.address", "127.0.0.1");

    public static void main(String[] args) {
        ReferenceConfig<GreetingsService> reference = new ReferenceConfig<>();
        reference.setApplication(new ApplicationConfig("first-dubbo-consumer"));
        reference.setRegistry(new RegistryConfig("zookeeper://" + zookeeperHost + ":2181"));
        reference.setInterface(GreetingsService.class);
        GreetingsService service = reference.get();
        String message = service.sayHi("dubbo");
        System.out.println(message);
    }
}
~~~

运行Server Applicaton，会看到:

~~~
dubbo service started
~~~

运行Consumer Application，会看到:

~~~
hi, dubbo
~~~

服务调用成功。

参考
- Dubbo github page <https://github.com/apache/dubbo>
- 一步步完成Maven+Spring+Dubbo+Zookeeper的整合示例 <https://my.oschina.net/wangmengjun/blog/903967>
