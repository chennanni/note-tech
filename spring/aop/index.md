---
layout: default
title: Spring - AOP
folder: aop
permalink: /archive/spring/aop/
---

# Spring AOP

Aspect Oriented Programming (AOP) compliments OOPs in the sense that it also provides **modularity**. 
But the key unit of modularity is **aspect** than class.

AOP has several implementations, here we use **Spring AspectJ AOP implementation** by annotation

## Why use AOP

For eazy maintenance when needed to adding/updating a **concern** (function) to methods.

## Concepts

### Cross-Cutting Concern

A concern that can affect the whole application and should be centralized in one location in code as possible, 
such as authentication, logging, security etc.

### Aspect

It is a class that contains advices, joinpoints etc.

```
@Aspect
public class TrackOperation{...}
```

### Pointcut

**Pointcut** tells the program to select some join points and apply advices

> It is an expression language of AOP that matches join points.

```
@Pointcut("execution(* Operation.*(..))")
public void myPointcut(){}//pointcut name
```

**Join Point** is just a concept telling the program "at this point, I need some advices!" It does not have "Annotaion".

> Join point is any point in your program such as method execution, exception handling, field access etc. Spring supports only method execution join point.

### Advices

Advice represents an action taken by an aspect at a particular join point. There are different types of advices:
- Before Advice: it executes before a join point.
- After Returning Advice: it executes after a joint point completes normally.
- After Throwing Advice: it executes if method exits by throwing an exception.
- After (finally) Advice: it executes after a join point regardless of join point exit whether normally or exceptional return.
- Around Advice: It executes before and after a join point.

```
	@Before("myPointcut()") //applying 'before advice' on this pointcut
    public void myadvice(JoinPoint jp) //it is the advice
    {
        System.out.println("additional concern");
        System.out.println("Method Signature: "  + jp.getSignature());
    }
```

## How to Use AOP in action

step 1: choose a class that needs advice

```
public  class Operation{
    public int m(){System.out.println("m method invoked");return 1;}
    public int k(){System.out.println("k method invoked");return 2;}
}
```

step 2: write the Aspect class

```
// import ...

@Aspect
public class TrackOperation{
    @Pointcut("execution(* Operation.*(..))")
    public void myPointcut(){}

    @Before("myPointCut()")
    public void myadvice(JoinPoint jp)
    {
        System.out.println("additional concern");
    }
}
```

step 3: add beans in applicationContext.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="opBean" class="com.javatpoint.Operation"></bean>

    <bean id="trackMyBean" class="com.javatpoint.TrackOperation"></bean>
    <bean class="org.springframework.aop.aspectj.annotation.AnnotationAwareAspectJAutoProxyCreator"></bean>
</beans>
```

step 4: when use the "Operation" bean's method in the app, advices will be applied

## Links

- <http://www.javatpoint.com/spring-aop-aspectj-annotation-example>
- <http://www.mkyong.com/spring3/spring-aop-aspectj-annotation-example/>
