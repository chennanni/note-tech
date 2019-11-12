---
layout: default
title: Spring - Cloud
folder: cloud
permalink: /archive/spring/cloud/
---

# Spring Cloud

把微服务相关的模块做了一个全家桶，统统放在Spring Cloud名下。它有很多组成模块，下面一一讲解。

# 服务注册与发现 Eureka

## 解读

Eureka，可以比喻成建筑工地现场。Server就是工地，Client就是工人。工人来上班，需要先到工地打卡。如果有什么活，到工地上去看一眼，就知道有哪些工人。
- Server：实现服务注册与发现
- Client：提供具体的服务

[第05课：服务注册与发现](https://gitchat.csdn.net/columnTopic/5af10bc30a989b69c3861029)

## Server

依赖 pom.xml

~~~ xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
</dependency>
~~~

配置 application.yml

~~~ yml
server:
  port: 8761
eureka:
  instance:
    preferIpAddress: true
    hostname: ${spring.cloud.client.ipAddress}
    instanceId: ${spring.cloud.client.ipAddress}:${server.port}
  server:
    enable-self-preservation: false
  client:
    registerWithEureka: false
    fetchRegistry: false
    serviceUrl:
      defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka/
 
# 1. server端口号
# 2. instance配置信息
# 3. server配置信息
# 4. eureka注册中心地址
~~~

注入 Application.java

~~~ java
@SpringBootApplication
@EnableEurekaServer
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
~~~


## Client

依赖 pom.xml

~~~ xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>

<!-- Spring Cloud use hystrix in the backend, so need this -->
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
</dependency>
~~~

配置 application.yml

~~~ yml
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
server:
  port: 8762
spring:
  application:
    name: eurekaclient

# 1. eureka注册中心地址
# 2. client端口号
# 3. client名称
~~~

注入 Application.java

~~~ java
@SpringBootApplication
@EnableEurekaClient
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
~~~

# 服务网关 Spring Cloud Gateway

## 解读

Spring Cloud Gateway，可以比喻成包工头，外界有什么活进来，都是通过包工头，然后再由其分配到下面每一个工人手里。
它的作用就是进行路由转发、异常处理和过滤拦截。

以前这个模块是用的Zuul，但是现在一般都改用Spring Cloud Gateway了。

- [Spring Cloud Gateway Tutorial](https://medium.com/@niral22/spring-cloud-gateway-tutorial-5311ddd59816)
- [Spring Cloud Gateway Doc](https://cloud.spring.io/spring-cloud-gateway/reference/html/#gateway-starter)
- [第06课：服务网关](https://gitchat.csdn.net/columnTopic/5af10bd60a989b69c386103c)

## 实现

依赖 pom.xml

~~~ xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-gateway</artifactId>
</dependency>

<!-- Gateway is also a kind of client, thus need this -->
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
</dependency>
~~~

配置 application.yml

~~~ yml
server:
  port: 8081
spring:
  application:
    name: gateway
  cloud:
    gateway:
      routes:
      - id: method_route
        uri: lb://eurekaclient
        predicates:
        - Method=GET
      discovery:
        locator:
          enabled: true
logging:
  level:
    org.springframework.cloud.gateway: trace
    org.springframework.http.server.reactive: debug
    org.springframework.web.reactive: debug
    reactor.ipc.netty: debug
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/

# 1. gateway端口号
# 2. gateway名称
# 3. gateway配置信息，包括路由规则等
# 4. logging
# 5. eureka注册中心地址
~~~

注入 Application.java

~~~ java
@SpringCloudApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
~~~

这里需要注意的是，annotation为什么不是类似`@SpringCloudGateway`的样子，而是`@SpringCloudApplication`？
笔者认为，这里就体现了SpringCloud的一个特性，即只需要模糊地标明这是一个SpringCloudApplication，而具体是什么，它会根据配置文件中定义的内容去创建。
再举一例，Eureka Server和Client，同样可以只用一个`@SpringCloudApplication`的annotation即可。

# 服务消费者 Feign

## 解读

对外提供接口可以通过 Spring Cloud Gateway 服务网关实现，
对内负责各个服务之间的通信可以采用内部调用的形式 Feign。笔者认为将其称为“内部网关”更加容易理解。

- [第07课：服务消费者](https://gitchat.csdn.net/columnTopic/5af10bec0a989b69c386104f)

## 实现

依赖

~~~ xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-eureka</artifactId>
</dependency>
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-feign</artifactId>
</dependency>
~~~

配置

~~~ yml
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
server:
  port: 8081
spring:
  application:
    name: feign

# 1. 应用名称
# 2. 端口号
# 3. 注册中心地址
~~~

实例化

~~~ java
@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
~~~

使用

~~~ java
@FeignClient(value = "eurekaclient")
public interface ApiService {
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    String index();
}

@SpringBootTest(classes = Application.class)
@RunWith(SpringJUnit4ClassRunner.class)
public class TestDB {
    @Autowired
    private ApiService apiService;
    @Test
    public void test(){
        try {
            System.out.println(apiService.index());
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
~~~

这里我们可以通过`apiService.index()`这个方法，来实现调用eurekaclient的/index访问。比较Feign和Gateway，粗略看来，两者非常像，只不过一个对内，一个对外。
