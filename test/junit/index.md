---
layout: default
title: Testing - Junit Basic
folder: junit-basic
permalink: /archive/test/junit-basic/
---

# Testing - Junit Basic

## Definition

Testing, Unit Testing, Junit Testing

- Testing is the process of checking the functionality of the application whether it is working as per requirements.
- Unit testing is the testing of single entity (class or method).
- JUnit is a unit testing framework for the Java Programming Language.

## Junit Features

- open source framework
- use annoation to identify test methods
- provide assertion for testing expected results
- provide test runners for running tests

## Basic Usage

STEP 1: Create a Class to test

~~~ java
public class MessageUtil {...}
~~~

STEP 2: Create Test Case Class

~~~ java
import org.junit.Test;
import static org.junit.Assert.assertEquals;
public class TestJunit {
   String message = "Hello World";
   MessageUtil messageUtil = new MessageUtil(message);

   @Test
   public void testPrintMessage() {
      assertEquals(message,messageUtil.printMessage());
   }
}
~~~

STEP 3: Create Test Runner Class (Optional with Eclipse)

~~~ java
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

public class TestRunner {
   public static void main(String[] args) {
      Result result = JUnitCore.runClasses(TestJunit.class);
      for (Failure failure : result.getFailures()) {
         System.out.println(failure.toString());
      }
      System.out.println(result.wasSuccessful());
   }
}
~~~

Note: Most IDE integrates with Junit so that you don't need to write the Test Runner by yourself. 
It's already handled by the platform.
Just a click of button triggers the process in the backend.

## Types of Conditions

**Assertion Test**

This class provides a set of assertion methods useful for writing tests.

~~~
void assertEquals(boolean expected, boolean actual)
void assertFalse(boolean condition)
void assertTrue(boolean condition)
void assertNull(Object object)
void assertNotNull(Object object)
void fail()
~~~

~~~ java
import org.junit.Test;
import static org.junit.Assert.*;
public class TestJunit1 {
   @Test
   public void testAdd() {
      //test data
      int num= 5;
      String temp= null;
      String str= "Junit is working fine";

      //check for equality
      assertEquals("Junit is working fine", str);

      //check for false condition
      assertFalse(num > 6);

      //check for not null value
      assertNotNull(str);
   }
}
~~~

**Time Test**

~~~ java
@Test(timeout=1000)
~~~

**Exception Test**

~~~ java
@Test(expected = XXXException.class)
~~~

## Annotation

- `@Test` run the method as a test case
- `@Before` run the method before each test
- `@After` run the method after each test
- `@BeforeClass` run once before any methods in the class
- `@AfterClass` run once after all tests have finished
- `@Ignore` ignore the test

## JMock

Mock objects help you design and test the relations between the objects entangling the whole system.

~~~ java
import org.jmock.Mockery;
import org.jmock.Expectations;

public class PublisherTest extends TestCase {
    Mockery context = new Mockery();

    public void testOneSubscriberReceivesAMessage() {
        // set up
        final Subscriber subscriber = context.mock(Subscriber.class);

        Publisher publisher = new Publisher();
        publisher.add(subscriber);

        final String message = "message";

        // expectations
        context.checking(new Expectations() {
            oneOf (subscriber).receive(message);
        });

        // execute
        publisher.publish(message);

        // verify
        context.assertIsSatisfied();
    }
}
~~~

More info about Mock Test can be found here: 
[用JUnit写Unit Test和Integration Test](https://github.com/chennanni/chennanni.github.io/blob/master/_posts/tech-cn/2017-03-01-unit-test-and-integration-test.md)


## Links
- <http://tutorials.jenkov.com/java-unit-testing/index.html>
- <http://www.tutorialspoint.com/junit/index.htm>
