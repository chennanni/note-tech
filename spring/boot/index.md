---
layout: default
title: Spring - Boot
folder: boot
permalink: /archive/spring/boot/
---

# Spring Boot

## What

- It is easy to create a stand-alone and production ready spring applications using Spring Boot. 
- Spring Boot contains a comprehensive infrastructure support for developing a micro service and enables you to develop enterprise-ready applications that you can “just run”.

两点，一是适用于**快速**搭建项目，二是适用于搭建**微服务**。

## Spring Boot & Spring

Pivotal公司一向擅长做框架。之前的Spring版图中，除了核心的IOC之外，还包括了许多其他模块，举例：
- Web: Spring MVC
- Messaing: Spring JMS
- Persistence: Spring JPA

而这次的Spring Boot，侧重点是Boot，顾名思义，就是让系统更方便，快捷地跑起来。为了达到这个目的，Spring Boot在框架背后做了许多工作，预先把很多接口和实现写好了。下面就挑重点讲一下。

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

为了让Java代码跑起来，一般需要一个main函数，然后在里面定义启动的步骤。而在Spring Boot中一般不自己写main函数，而是实现一个接口，这个接口用了类似template pattern的方法，在main函数里预先实现了部分功能，且留了一些发挥空间给开发者。

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
