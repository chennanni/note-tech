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

## Links

- [Note-J2EE-JMS](http://chennanni.github.io/note-tech/archive/j2ee/jms/)
- [Getting Started with Spring JMS](http://www.baeldung.com/spring-jms)
- [Spring JMS Doc](https://docs.spring.io/spring/docs/3.0.x/spring-framework-reference/html/jms.html)
