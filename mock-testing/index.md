---
layout: default
title: Mock Testing
folder: mock-testing
permalink: /archive/mock-testing/
---

# Mock Testing

## What is Mock Testing

> Mock testing means unit testing with mock objects as substitutes for real objects.

For example, if we write two class A and B. Now we are testing class A which uses B internally. 
If there's something wrong with B, A would probabaly fail as well. 
Here the testing success of A relies on B which is not a good practice of Unit testing. 
Instead, using a Mock of B can seperate the concern and only focus on A.

Another example is, we write some business logic classes, inside, we call some DAO objects to persist the data.
DAO is developed by someone else. Without the knowledge of the implementation, plus we don't want our testing rely on someone else's code.
Writing a Mock of DAO is a good idea.

## Mock and Stub

> A Stub is an object that implements an interface of a component, 
but instead of returning what the component would return when called, 
the stub can be configured to return a value that suits the test. 

> A Mock is like a stub, only it also has methods that make it possible determine what methods where called on the Mock.

To summary

- a stub has the same method signatures but return different values.
- a mock is a stub with ability to trace back the method invocations.

## Vendors for Mock Testing

- Mockito
- EazyMock
- PowerMock

## A Little Explor of Mockito

~~~ java
 import static org.mockito.Mockito.*;
 
 LinkedList mockedList = mock(LinkedList.class);

 //stubbing
 when(mockedList.get(0)).thenReturn("first");
 when(mockedList.get(1)).thenThrow(new RuntimeException());

 //following prints "first"
 System.out.println(mockedList.get(0));

 //following throws runtime exception
 System.out.println(mockedList.get(1));

 //verification
 verify(mockedList).get(0);
~~~
 
## Links

- [Example 1](https://dzone.com/articles/getting-started-mocking-java)
- [Example 2](https://gojko.net/2009/10/23/mockito-in-six-easy-examples)
- [Mockito API](http://static.javadoc.io/org.mockito/mockito-core/2.2.9/org/mockito/Mockito.html)
- [Stub, Mock and Proxy](http://tutorials.jenkov.com/java-unit-testing/stub-mock-and-proxy-testing.html)
- [Mocks V.S. Stub](http://martinfowler.com/articles/mocksArentStubs.html)
