---
layout: default
title: Spring - Boot
folder: boot
permalink: /archive/spring/boot/
---

# Spring Boot

## What is Spring Boot

- It is easy to create a stand-alone and production ready spring applications using Spring Boot. 
- Spring Boot contains a comprehensive infrastructure support for developing a micro service and enables you to develop enterprise-ready applications that you can “just run”.

两点，一是适用于**快速**搭建项目，二是适用于搭建**微服务**。

## Spring Family

Pivotal公司一向擅长做框架。之前的Spring版图中，除了核心的IOC之外，还包括了许多其他模块，举例：

- IoC：Spring框架中最常用的功能，依赖注入。
- Web：Spring MVC，适用于Web应用搭建。
- Messaing：Spring JMS，消息中间件。
- Persistence：Spring JPA，数据写入模块。

技术是不断发展的，框架也在不断改进，它的目标很简单：用了这个框架，你只需要写业务逻辑即可，其它的代码越少越好。
于是就有了Spring Boot。它整合了大量其它的第三方类库，且更加遵循"约定大于配置"。

- Spring Boot：侧重点是Boot，顾名思义，就是让系统更方便，快捷地跑起来。为了达到这个目的，Spring Boot在框架背后做了许多工作，预先把很多接口和实现写好了。
- Spring Cloud：是基于Spring Boot的微服务框架。其致力于将一整个"大的"应用切分为一个个"小的"服务，各个服务之间解耦且独立，可以分布式运行。

## Spring Boot Features

1. 为所有 Spring 开发提供一个更快更广泛的入门体验。
2. 零配置。无冗余代码生成和XML 强制配置，遵循“约定大于配置” 。
3. 集成了大量常用的第三方库的配置， Spring Boot 应用为这些第三方库提供了几乎可以零配置的开箱即用的能力。
4. 提供一系列大型项目常用的非功能性特征，如嵌入式服务器、安全性、度量、运行状况检查、外部化配置等。

<https://blog.csdn.net/qq_40147863/article/details/84194493>

## SpringBootApplication

几乎所有的Spring Boot应用都会用到这个Annotaion：`@SpringBootApplication`。简单地来说，它相当于下面三个Annotation的总和：

~~~
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan
~~~

如果用过Spring的一定感到很熟悉。

`@SpringBootConfiguration`：类似于JavaConfig，Configuration写在Java Code中而不是XML里。
`@EnableAutoConfiguration`：自动将JavaConfig中的Bean装载到IoC容器中。
`@ComponentScan`：自动扫描并加载符合条件的组件。

## Dependency Management

版本控制是一个琐碎但是同样重要的事情。如果处理不当，可能会发生不兼容的问题。
以前，我们一般会需要在pom文件中指明每一个lib的版本。但是在Spring Boot中，我们只需要指明Spring Boot parent的版本，然后其他所有相关的lib版本都已经在parent中预先定义好了（且保证兼容性）。

~~~ xml
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>1.5.8.RELEASE</version>
  <relativePath/> <!-- lookup parent from repository -->
</parent>

<dependencies>
  <dependency>
	 <groupId>org.springframework.boot</groupId>
	 <artifactId>spring-boot-starter-web</artifactId>
  </dependency>

  <dependency>
	 <groupId>org.springframework.boot</groupId>
	 <artifactId>spring-boot-starter-test</artifactId>
	 <scope>test</scope>
  </dependency>
</dependencies>
~~~

## How to Run

例1：hello world 1

~~~ java
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication implements ApplicationRunner {
   public static void main(String[] args) {
      SpringApplication.run(DemoApplication.class, args);
   }
   @Override
   public void run(ApplicationArguments arg0) throws Exception {
      System.out.println("Hello World from Application Runner");
   }
}
~~~

例2:hello world 2

~~~ java
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication implements CommandLineRunner {
   public static void main(String[] args) {
      SpringApplication.run(DemoApplication.class, args);
   }
   @Override
   public void run(String... arg0) throws Exception {
      System.out.println("Hello world from Command Line Runner");
   }
}
~~~

例3:Web app

~~~ java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class DemoApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class,args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(DemoApplication.class);
    }
}
~~~

# Link
- [Spring Boot Tutorial](https://www.tutorialspoint.com/spring_boot/spring_boot_introduction.htm)
- [Spring Boot 启动原理](https://gitchat.csdn.net/columnTopic/5af10a600a989b69c38602f1)
- [Spring Boot 使用详解](https://www.cnblogs.com/lenve/p/11400056.html)
