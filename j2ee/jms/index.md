---
layout: default
title: J2EE - JMS
folder: jms
permalink: /archive/j2ee/jms/
---

# J2EE - JMS

## Intro

JMS (Java Message Service) is an API that provides the facility to create, 
send and read messages from one application to another.

## Usage

Example 1:

To process long-running operations asynchronously. 
A web user won't want to wait for more than 5 seconds for a request to process. 
If you have one that runs longer than that, one design is to submit the request to a queue and 
immediately send back a URL that the user can check to see when the job is finished.

Example 2:

To place an order for a particular customer. 
As part of placing that order (and storing it in a database) you may wish to carry a number of additional tasks:

- Store the order in some sort of third party back-end system (such as SAP).
- Send an email to the customer to inform them their order has been placed.

To do this your application code would publish a message onto a JMS queue which includes an order id. One part of your application listening to the queue may respond to the event by taking the orderId, looking the order up in the database and then place that order with another third party system. Another part of your application may be responsible for taking the orderId and sending a confirmation email to the customer.

<http://stackoverflow.com/questions/1035949/real-world-use-of-jms-message-queues>

## Messaging Domains

1. Point-to-Point (PTP) Messaging Domain

In PTP model, one message is delivered to one receiver only. 
Here, Queue is used as a message oriented middleware (MOM).

![jms_ptp](img/jms_ptp.png)

2. Publisher/Subscriber (Pub/Sub) Messaging Domain

In Pub/Sub model, one message is delivered to all the subscribers. 
It is like broadcasting. Here, Topic is used as a message oriented middleware that is responsible to hold and deliver messages.

![jms_pubsub](img/jms_pubsub.png)

## JMS Programming Model

![jms_model](img/jms_model.png)

Note: The destination can be either Queue or Topic.

## JMS Receiving Model

消费者有两种接受消息的模式：
- Synchronous
  - `consumer.receive()`/`consumer.receive(int timeout)`
  - 消费者会一直等待直到消息到达或超时
- Asynchronous
  - using `MessageListener`
  - 消费者注册一个监听器，当接到消息时进行callback操作

## Implementation Steps

- register elements: ConnectionFactory, destination(Queue or Topic)
- register Connection and Session
- start the connection
- create MessageProducer and send message
- create MessageConsumer and receive message

## In Practice

Elements
- producer: create producer and send message
- synch-consumer1: create synch-consumer1 and receive message
- asynch-consumer2: create asynch-consumer2 and receive message
- application context: manage connection and session
- main(): start the app

App：主程序
~~~ java
public class App {
    public static void main(String[] args) throws Exception {

        AppContext appContext = new AppContext();
        appContext.startSession();

        new Thread(new Producer(appContext)).start();
        new Thread(new Consumer(appContext)).start();
        Thread.sleep(2000);
        new Thread(new Producer(appContext)).start();
        new Thread(new Consumer2(appContext)).start();
        Thread.sleep(2000);

        appContext.endConnection();
    }
}
~~~

AppContext：用来初始化及保存连接对象
~~~ java
import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.Connection;
import javax.jms.Destination;
import javax.jms.Session;

public class AppContext {
    private static final String USERNAME = ActiveMQConnection.DEFAULT_USER;
    private static final String PASSWORD = ActiveMQConnection.DEFAULT_PASSWORD;
    private static final String BROKEURL = ActiveMQConnection.DEFAULT_BROKER_URL;

    private ActiveMQConnectionFactory connectionFactory;
    private Connection connection;
    private Session session;
    private Destination destination;

    public void startSession() {
        try {
            // Create a ConnectionFactory
            connectionFactory = new ActiveMQConnectionFactory(this.USERNAME, this.PASSWORD, this.BROKEURL);
            // Create a Connection
            connection = connectionFactory.createConnection();
            // Create a Session
            session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            // Create the destination (Topic or Queue)
            destination = session.createQueue("TEST.FOO");
            // start the connection
            connection.start();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void endConnection() {
        try {
            session.close();
            connection.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public ActiveMQConnectionFactory getConnectionFactory() {
        return connectionFactory;
    }

    public void setConnectionFactory(ActiveMQConnectionFactory connectionFactory) {
        this.connectionFactory = connectionFactory;
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    public Session getSession() {
        return session;
    }

    public void setSession(Session session) {
        this.session = session;
    }

    public Destination getDestination() {
        return destination;
    }

    public void setDestination(Destination destination) {
        this.destination = destination;
    }
}
~~~

Producer
~~~ java
import javax.jms.*;

public class Producer implements Runnable {

    private Session session;
    private Destination destination;

    public Producer(AppContext appContext) {
        this.session = appContext.getSession();
        this.destination = appContext.getDestination();
    }

    public void run() {
        try {
            // Create a MessageProducer from the Session to the Topic or Queue
            MessageProducer producer = session.createProducer(destination);
            producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

            // Create a messages
            String text = "Hello world! From: " + Thread.currentThread().getName() + " : " + this.hashCode();
            TextMessage message = session.createTextMessage(text);

            // Tell the producer to send the message
            System.out.println("Sent message: "+ message.hashCode() + " : " + Thread.currentThread().getName());
            producer.send(message);
        }
        catch (Exception e) {
            System.out.println("Caught: " + e);
            e.printStackTrace();
        }
    }
}
~~~

Consumer1: using Synchronous Receive
~~~ java
import javax.jms.*;

public class Consumer implements Runnable {

    private Session session;
    private Destination destination;

    public Consumer(AppContext appContext) {
        this.session = appContext.getSession();
        this.destination = appContext.getDestination();
    }

    public void run() {
        try {
            // Create a MessageConsumer from the Session to the Topic or Queue
            MessageConsumer consumer = session.createConsumer(destination);
            // Wait for a message
            Message message = consumer.receive(1000);
            // Deal with message
            if (message instanceof TextMessage) {
                TextMessage textMessage = (TextMessage) message;
                String text = textMessage.getText();
                System.out.println("C1, received: " + text);
            } else {
                System.out.println("C1, received: " + message);
            }
            consumer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
~~~

Consumer2: using Asynchronous Receive
~~~ java
import javax.jms.*;

public class Consumer2 implements Runnable {

    private Session session;
    private Destination destination;

    public Consumer2(AppContext appContext) {
        this.session = appContext.getSession();
        this.destination = appContext.getDestination();
    }

    public void run() {
        try {
            // Create a MessageConsumer from the Session to the Topic or Queue
            MessageConsumer consumer2 = session.createConsumer(destination);
            consumer2.setMessageListener(new MessageListener() {
                public void onMessage(Message msg) {
                    TextMessage textMsg = (TextMessage) msg;
                    try {
                        System.out.println("C2, received: " + textMsg.getText());
                    } catch (JMSException e) {
                        e.printStackTrace();
                    }
                }
            });
            Thread.sleep(1000);
            consumer2.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
~~~

Note: the example uses ActiveMQ, you need to start it first.

```
cd [activemq_install_dir]
bin\activemq start
check the result in web console: http://127.0.0.1:8161/admin/
```

## Links

- [Javapoint - JMS Tutorial](http://www.javatpoint.com/jms-tutorial)
- [ActiveMQ - Hello World Example](http://activemq.apache.org/hello-world.html)
- [Oracle - Writing Simple JMS Applications](https://docs.oracle.com/javaee/6/tutorial/doc/bncfa.html)
- [CSDN - JMS简单例子](http://blog.csdn.net/wl_ldy/article/details/7884534)
- [CSDN - ActiveMQ简单的HelloWorld实例](http://blog.csdn.net/jiuqiyuliang/article/details/48608237)
