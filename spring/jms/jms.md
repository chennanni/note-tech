---
layout: default
title: Spring - JMS
folder: jms
permalink: /archive/spring/jms/
---

# Spring - JMS

## How JMS works

JMS works like this: `Producer` produce messages, send to `Destination`. `Consumer` receives messages, from `Destination`. 
The information exchange happens through `Connection` and `Session`.

Key components
- Connection
- Session
- Destination
- Message Producer (send)
- Message Consumer (receive)

## Spring Implementation

To implement the JMS function, Spring has several components: 
- `ConnectionFactory`: to manage `Connection` and `Session`.
  - SingleConnectionFactory
  - CachingConnectionFactory
- `Destination Management`: to manage `Destination`.
  - DynamicDestinationResolver
  - JndiDestinationResolver
- `JmsTemplate`: to perform send and receive.
  - It handles the creation and release of resources when sending or synchronously receiving messages.

We can think of the first two components as supporting modules. The actual work is done with `JmsTemplate`.
  
## Example of JmsTempalte
~~~ java
// send
public class JmsQueueSender {
    private JmsTemplate jmsTemplate;
    private Queue queue;

    public void setConnectionFactory(ConnectionFactory cf) {
        this.jmsTemplate = new JmsTemplate(cf);
    }
    public void setQueue(Queue queue) {
        this.queue = queue;
    }
    public void simpleSend() {
        this.jmsTemplate.send(this.queue, new MessageCreator() {
            public Message createMessage(Session session) throws JMSException {
              return session.createTextMessage("hello queue world");
            }
        });
    }
}

// receive
// use JmsTemplate.doReceive(Session session, Destination destination, java.lang.String messageSelector)

// browse
// use JmsTemplate.browse(...)
~~~

## Example of Receive Convention

In practice, we usually use Message-Driven POJOs to handle/receive messages.

~~~ java
public class ExampleListener implements MessageListener {
    public void onMessage(Message message) {
        if (message instanceof TextMessage) {
            try {
                System.out.println(((TextMessage) message).getText());
            }
            catch (JMSException ex) {
                throw new RuntimeException(ex);
            }
        }
        else {
            throw new IllegalArgumentException("Message must be of type TextMessage");
        }
    }
}
~~~

Spring offers a solution to create message-driven POJOs in a way that does not tie a user to an EJB container using Message Listener Containers. 

A Message Listener Container is the intermediary between an MDP and a messaging provider, and takes care of registering to receive messages, participating in transactions, resource acquisition and release, exception conversion and suchlike.
- SimpleMessageListenerContainer
- DefaultMessageListenerContainer

So in real usage, we create a MessageListenerContainer, create a MessageListener (which is the MDP) and tie these two together.

~~~ xml
<!-- this is the Message Driven POJO (MDP) -->
<bean id="messageListener" class="jmsexample.ExampleListener" />

<!-- and this is the message listener container -->
<bean id="jmsContainer" class="org.springframework.jms.listener.DefaultMessageListenerContainer">
    <property name="connectionFactory" ref="connectionFactory"/>
    <property name="destination" ref="destination"/>
    <property name="messageListener" ref="messageListener" />
</bean>
~~~

## Persistence and Durability

首先需要声明一点，Destination（Queue/Topic）收到消息后，（笔者猜测）应该是有实现`Serilization`的功能保证消息的持久性，但是这个和下面要讨论的Persistence又是不同的。

在JMS的整个流程中，我们可以分为两个阶段来考虑，如果在某个阶段挂了会发生什么：
- 发送：消息发送过程中挂了，消息就丢了，但是可以配置Message Persistence这个属性来保证重启时重发。
  - 一般是用`setDeliveryMode(DeliveryMode.PERSISTENT)`来实现。
- 接收（Queue）：因为Queue不需要监听，只要发送成功，任何时候起Queue都能收到消息。
- 接受（Topic）：这里分Subscriber起没起两种情况。
  - 如果Subscriber起了，那就能收到。
  - 如果Subscriber没起，那就收不到。但是可以配置Durable Subscriber来保证会为其保留消息，一般需要配置`subscriptionDurable`类似的属性。

example of Durable Subscriber

~~~ xml
  <bean id="jmsContainer" class="org.springframework.jms.listener.DefaultMessageListenerContainer">
      <property name="connectionFactory" ref="jmsConnectionFactory"/>
      <property name="messageListener" ref="messageListener" />
      <property name="destination" ref="datasetTopicUMMY"/>
      <property name="sessionTransacted" value="true" /><!-- whether JMS Sessions are transacted-->
      <property name="pubSubDomain" value="true"/><!--use Publish/Subscribe domain (Topics)-->
      <property name="subscriptionDurable" value="true" /><!--make the subscription durable-->
      <property name="durableSubscriptionName" value="${static.durableSubscriptionName}" /><!--subscriber's name-->
      <property name="autoStartup" value="false" />
  </bean>
~~~

- [JMS开发步骤和持久化/非持久化Topic消息](https://www.cnblogs.com/xinhuaxuan/p/6105985.html)
- [消息的持久化和非持久化 以及 持久订阅者 和 非持久订阅者 之间的区别与联系](https://www.cnblogs.com/hapjin/p/5644402.html)

## Links

- [Note-J2EE-JMS](http://chennanni.github.io/note-tech/archive/j2ee/jms/)
- [Getting Started with Spring JMS](http://www.baeldung.com/spring-jms)
- [Spring JMS Doc](https://docs.spring.io/spring/docs/3.0.x/spring-framework-reference/html/jms.html)
