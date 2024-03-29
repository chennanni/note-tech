---
layout: default
title: Spring - Cloud
folder: cloud
permalink: /archive/spring/cloud/
---

# Spring - Cloud

把微服务相关的模块做了一个全家桶，统统放在Spring Cloud名下。它有很多组成模块，下面一一讲解。

# 服务注册与发现 Eureka

## 解读

Eureka，可以比喻成建筑工地现场。Server就是工地，Client就是工人。工人来上班，需要先到工地打卡。如果有什么活，到工地上去看一眼，就知道有哪些工人。
- Server：实现服务注册与发现
- Client：提供具体的服务

[第05课：服务注册与发现](https://gitchat.csdn.net/columnTopic/5af10bc30a989b69c3861029)

## Server实现

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

Server跑起来后，访问`localhost:8761`就可以看到Eureka服务器页面。

## Client实现

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

OR

~~~ xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-eureka</artifactId>
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

Client跑起来后，同样地，访问Eukera服务器页面即可以看到Client在上面有注册信息了。
至于Client功能的实现，即访问`localhost:8762`能做什么事，还需要更多的Coding。

# 服务网关 Spring Cloud Gateway

## 解读

Spring Cloud Gateway，可以比喻成包工头，外界有什么活进来，都是通过包工头，然后再由其分配到下面每一个工人手里。
它的作用就是进行路由转发、异常处理和过滤拦截。

举例，`localhost:8761`是Server，然后我们开了三个一模一样的Client，端口号分别为`8762`，`8763`，`8764`。
那么，我们怎么访问呢？一种方式是直接使用`localhost:8762`，`localhost:8763`，`localhost:8764`，但是对于外界用户来说，搞三个地址比较confusing。这个问题可以由路由解决。我们部署一个路由在`localhost:8080`上，外界总是访问这个地址。请求先到路由，然后再由路由转发给后端的三个Client之一。

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
	<artifactId>spring-cloud-starter-feign</artifactId>
</dependency>
<!-- some other components-->
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-eureka</artifactId>
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

@FeignClient(value = "eurekaclient")
public interface ApiService {
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    String index();
}
~~~

使用

~~~ java
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

这里我们可以通过`apiService.index()`这个方法，来实现调用eurekaclient的/index访问，达到一样的效果。比较Feign和Gateway，粗略看来，两者非常像，只不过一个对内，一个对外。

# 服务异常处理 Hystrix

## 解读

当满足一定条件，比如某服务不可用达到一个阈值（Hystrix 默认5秒20次），将打开熔断器，停止服务，并导流向熔断处理页面。

- [第08课：服务异常处理](https://gitchat.csdn.net/columnTopic/5af10bfc0a989b69c3861064)

## 实现

依赖

~~~ xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-hystrix</artifactId>
</dependency>
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-starter-hystrix-dashboard</artifactId>
</dependency>
<!-- some other components-->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
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
feign:
  hystrix:
    enabled: true

# 1. 应用名称
# 2. 端口号
# 3. feign hystrix 配置，开启熔断器
# 4. 注册中心地址
~~~

实现

~~~ java
// 处理熔断的类
@Component
public class ApiServiceError implements ApiService {
    @Override
    public String index() {
        return "服务发生故障！";
    }
}

// 指定fallback逻辑，导向处理熔断的类
@FeignClient(value = "eurekaclient",fallback = ApiServiceError.class)
public interface ApiService {
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    String index();
}

// 指定正常的处理逻辑，即当接到/index的请求时，调用apiService.index()
@RestController
public class ApiController {
    @Autowired
    private ApiService apiService;
    @RequestMapping("index")
    public String index(){
        return apiService.index();
    }
}

// 注入HystrixDashboard 以及 CircuitBreaker
@SpringBootApplication
@EnableEurekaClient
@EnableFeignClients
@EnableHystrixDashboard
@EnableCircuitBreaker
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
~~~

访问`localhost:8081/hystrix`可以看到Hystrix监控页面。

# 配置中心 Spring Cloud Config

## 解读

Spring Cloud Config can manage configurations for other services. It runs independently on a server.

具体应用的时候，分为两个部分。
- Spring Cloud Config Server
- Spring Cloud Config Client

Config统一放在Server上，然后常见的一种场景是，Server再连到Git上，即最终Config文件是放在Git上的。
Client去Server上拿Config。

- [Understanding Spring Cloud Config Server with Example](https://o7planning.org/en/11723/understanding-spring-cloud-config-server-with-example)
- [Understanding Spring Cloud Config Client with Example](https://o7planning.org/en/11727/understanding-spring-cloud-config-client-with-example)

## Server实现

依赖 pom.xml

~~~ xml
<dependency>
	<groupId>org.springframework.cloud</groupId>
	<artifactId>spring-cloud-config-server</artifactId>
</dependency>
~~~

配置 application.properties

~~~ properties
server.port=8888

spring.cloud.config.server.git.uri=https://github.com/someuser/spring-cloud-config-git-repo-example.git

# 1. Server端口号
# 2. Git的地址
# 注： 配置文件用properties或者yml格式，都可以
~~~

注入 SpringCloudConfigServerApplication.java

~~~ java
@EnableConfigServer
@SpringBootApplication
public class SpringCloudConfigServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(SpringCloudConfigServerApplication.class, args);
    }
}
~~~

## Client实现

配置

application.properties

~~~ properties
server.port=7777

# Client的端口地址
~~~

bootstrap.properties

~~~ properties
spring.application.name=app-about-company
spring.cloud.config.uri=http://localhost:8888
management.security.enabled=false

# 1. Client的名称
# 2. Server Config的地址
# 3. 其它信息
# 注：两个文件合成一个也可以
~~~

使用

~~~ java
@RefreshScope
@RestController
public class MainController {
    // https://github.com/someuser/spring-cloud-config-git-repo-example
    // See: app-about-company.properties
    @Value("${text.copyright: Default Copyright}")
    private String copyright;
    @Value("${spring.datasource.username}")
    private String userName;
    @Value("${spring.datasource.password}")
    private String password;
    @RequestMapping("/showConfig")
    @ResponseBody
    public String showConfig() {
        String configInfo = "Copy Right: " + copyright //
                + "<br/>spring.datasource.username=" + userName //
                + "<br/>spring.datasource.password=" + password;
        return configInfo;
    }
}
~~~

# 消息总线 Spring Coud Bus

## 解读

Spring cloud bus通过轻量消息代理连接各个分布的节点。本质是利用了MQ的广播机制在分布式的系统中传播消息，目前常用的有Kafka和RabbitMQ。

一个常见的使用场景是：Config Server上的某个property变了，需要notify所有相关的Client，获取最新配置。

- [springcloud(九)：配置中心和消息总线（配置中心终结版）](http://www.ityouknow.com/springcloud/2017/05/26/springcloud-config-eureka-bus.html)

## 应用

依赖

~~~ xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-bus-amqp</artifactId>
</dependency>
~~~

配置

~~~ yml
server:
  port: 8001
spring:
  application:
    name: spring-cloud-config-server
  cloud:
    config:
      server:
        git:
          uri: https://github.com/someuser/gitrepo/
          search-paths: config-repo
          username: username
          password: password
  rabbitmq:
    host: 192.168.0.6
    port: 5672
    username: admin
    password: 123456

eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8001/eureka/

management:
  security:
     enabled: false

# 需要额外配置的是
# 1. spring.cloud.config
# 2. spring.rabbitmq
# 3. management.security 刷新时，关闭安全验证
~~~

起一个Server在8001上，再起三个Client在8002，8003，8004上。
访问`localhost:8001/bus/refresh`来trigger Server刷新配置。
Spring Cloud Bus会把这个消息传给所有Client完成刷新。

# 服务链路追踪 Sleuth

Spring Cloud Sleuth为服务之间调用提供链路追踪。通过Sleuth可以很清楚的了解到一个服务请求经过了哪些服务，每个服务处理花费了多长。从而让我们可以很方便的理清各微服务间的调用关系。

## 解读

应用实战分为两块：
1. Server端，添加Zipkin组件，并启动Zipkin Server，这时可以到Zipkin Dashboard去查看trace信息。
2. Client端，配置Zipkin信息，启动Client之后，访问信息会自动被Zipkin追踪到。

- [springcloud(十二)：使用Spring Cloud Sleuth和Zipkin进行分布式链路跟踪](http://www.ityouknow.com/springcloud/2018/02/02/spring-cloud-sleuth-zipkin.html)
- [第11课：服务链路追踪](https://gitchat.csdn.net/columnTopic/5af10c430a989b69c38610a7)

## 应用 - Server

依赖

~~~ xml
<dependencies>
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-eureka</artifactId>
    </dependency>
    <dependency>
        <groupId>io.zipkin.java</groupId>
        <artifactId>zipkin-server</artifactId>
    </dependency>
    <dependency>
        <groupId>io.zipkin.java</groupId>
        <artifactId>zipkin-autoconfigure-ui</artifactId>
    </dependency>
</dependencies>
~~~

配置文件

~~~ yml
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
server:
  port: 9000
spring:
  application:
    name: zipkin-server
~~~

启动类

~~~ java
@SpringBootApplication
@EnableEurekaClient
@EnableZipkinServer
public class ZipkinApplication {
    public static void main(String[] args) {
        SpringApplication.run(ZipkinApplication.class, args);
    }
}
~~~

## 应用 - Client

依赖

~~~ xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-zipkin</artifactId>
</dependency>
~~~

配置

~~~ yml
spring:
  zipkin:
    base-url: http://localhost:9000
  sleuth:
    sampler:
      percentage: 1.0

# 指定了Zipkin服务器的地址
# 采样比例设置为1.0
~~~
