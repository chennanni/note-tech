---
layout: default
title: Java - Basic
folder: basic
permalink: /archive/java/basic/
---

# Java Basic

## Java Feature

- Simple
- Robust
 - Garbage Collection
 - Exception Handling
- Platform Independent
- Concurrency
 - Multi-threading
- Distributed
 - Networking (Socket Programming)
 - RMI (Remote Method Invocation)
 - Servlets

## Java Suites

JRE
- Java Runtime Environment

JDK (Java Development Kit)
- JRE
- developing, debugging, monitoring tools

SDK (Software Development Kit)
- JDK
- extra software, such as Application Servers, Debuggers, and Documentation

Java EE (Enterprise Edition)
- The Java Enterprise Edition contains a lot of extra tools and APIs for executing Java components inside a Java Enterprise Server

## Set Environment Variables
- **Environment Variables**: Environment variables are global system variables accessible by all the processes running under the Operating System (OS).
- **PATH**: maintains a list of directories. The OS searches the PATH entries for executable programs, such as Java Compiler (javac) and Java Runtime (java).
- **CLASSPATH**: maintain a list of directories (containing many Java class files) and JAR file (a single-file archive of Java classes). The Java Compiler and Java Runtime searches the CLASSPATH entries for Java classes referenced in your program.
- **JAVA_HOME**: maintain the locations of JDK and JRE installed directory, respectively.

e.g.

```
// Append a directory in front of the existing PATH
prompt> set PATH=d:\bin;%PATH%
```

Reference: http://www3.ntu.edu.sg/home/ehchua/programming/howto/environment_variables.html

## Java Compilation & Execution

```
	javac <file-name>.java
	java <class-name>
```

Compilation is done by JVM which uses JDK libraries to check the syntax and compile the source file.

Execution is taken care by JRE Java Runtime Environment which loads the class on to memory for execution only when there is a main method in the class.

## Datatypes

```
byte, 8 bit
short, 16 bit signed
int, 32 bit signed
long, 64 bit signed
float, 32 bit
double, 64 bit
boolean
char, 16 bit
Special case of String
```

## Operators

```
postfix: expr++, expr--
unary: ++expr, --expr, +expr, -expr, ~, !
multiplicative: *, /, %
additive: +, -
shift: <<, >>, >>>
relational: <, >, <=, >=
equality: ==, !=
bitwise: &, ^, |
logical: &&, ||
ternary: ? :
assignment: =, +=, -=, *=, /=, &=, ^=, |=, <<=, >>=, >>>=
signed shift: keep the sign, use the most left digit in binary representation of a number as a filler
unsigned shift: always use zero as a filler
```

## Control statements

```
if else then
switch
(do) while
for
```

## Access specifiers / modifiers

- `private`: within the same class
- `default`: within the same package
- `protected`: within the same package & other packages only by using inheritance
- `public`: anywhere

## Some Key Word

### this

- **a reference to the current object**
- explicit constructor invocation
- constructor overloading

### super

- **a reference to the direct parent class object**
- super.variable: parent variable
- super(): parent constructor
- super.method(): parent method

### final

- final variable can't be change
- final method can't be overridden
- final class can't be inherited
- (blank variable can be initialized in the constructor only)

### static

- **executed on the class rather than class instances**
- The static keyword in java is used for memory management mainly.

Static Variable

- The static variable gets memory only once in class area at the time of class loading.
- only global variables in the class can be declared as static, not local

Static Method

- A static method can be invoked without the need for creating an instance of a class.
- static method can only access static data member. In order to access non-static members, it must use an object of the class.
- Whereas, all the non-static methods can access both static and non-static members of that class directly.

### non-static block

the block will be called when the class is initiated

~~~ java
class Test{
{...}
}
~~~
### break

- labeled
- unlabeled

example of labeled break statement:

~~~ java
search:
	for (i = 0; i < arrayOfInts.length; i++) {
		for (j = 0; j < arrayOfInts[i].length;
			 j++) {
			if (arrayOfInts[i][j] == searchfor) {
				foundIt = true;
				break search;
			}
		}
	}
~~~

## Serialization

All the java objects are temporary for each JVM instance. 
if we need to store them in a file OR need to transfer over the network, they must be retained even after the JVM instance is dead. 
This reauires those java objects to have "persistence" property. 
This process of giving an object a persistence property is called as "Serialization".

## Inheritance Related

### Inheritance

An object or class is based on another object or class, using the same implementation to maintain the same behavior.
When a subclass is initiated, it needs to (invoke the superclass's constructor to) create an instance of the superclass object
When using inheritance, invoking a subclass will automatically load super class's "no argument constructor" if no other super class's "with argument constructor" is called

### Encapsulation

packing of data and functions into a single component
The features of encapsulation are supported using classes in most object-oriented programming languages.

### Polymorphism

many: A reference variable can refer to any object of its declared type or any subtype of its declared type.
It is the provision of a single interface to entities of different types.

One thing to notice when using polymorphism

e.g.

```
class A
class B extends A
A instance = new B();
instance.field -> A
instance.method() -> B
```

## Exception

### Checked Exception

- Exceptions that are checked at compile time.
 - IOException (FileNotFoundException)
- Checked exceptions must be explicitly caught or propagated.

### Unchecked Exception

Exceptions that are not checked at compiled time such as err & runtime exception.
- ArithmeticException
- ArrayIndexOutOfBoundsException
- StringIndexOutOfBoundsException
- NullPointerException
- NumberFormatException
- ClassNotFoundException
- IllegalArgumentException

### Exception Handing

- try catch
- throw
- throws
- printStackTrace()

After try catch, the program will continue to execute.

Throwed exception must be caught somewhere. A mehtod that throws exception must be surrounded by try-catch block.

~~~ java
public void sample() throws ArithmeticException{
  
  ...

  throw new ArithmeticException();
  
  ...
}
~~~

## Generic

### Generic Collection

- set the type of the collection to **limit what kind of objects can be inserted into the collection**. 
- don't have to cast the values you obtain from the collection.

~~~ java
List < String > strings = new ArrayList < String >();
strings.add("a String");
String aString = strings.get(0);
~~~

Generics also provide compile-time type safety that allows programmers to catch invalid types at compile time.

### Generic Method

specify, with a single method declaration, a set of related methods

~~~ java
public static < E > void printArray( E[] inputArray ){...}
...
printArray( intArray  ); // pass an Integer array
printArray( doubleArray ); // pass a Double array
~~~

### Generic Class

specify, with a single class declaration, a set of related types.

~~~ java
// The < T > is a type token that signals that this class can have a type set when instantiated.
public class Box < T > {...}
...
Box < Integer > integerBox = new Box < Integer >();
Box < String > stringBox = new Box < String >();
~~~

### Generic WildCard

a collection whose element type matches anything

~~~ java
// here you can pass a Collection< String > or Collection< Integer >
void printCollection(Collection<?> c) {
    for (Object e : c) {
        System.out.println(e);
    }
}
~~~

### Bounded WildCard

restrict the kinds of unknown type

~~~ java
public void addRectangle(List<? extends Shape> shapes) {
    // Compile-time error!
    shapes.add(0, new Rectangle());
}
~~~

### Bounded Type Parameters

restrict the kinds of types that are allowed to be passed to a type parameter

For example, a method that operates on numbers might only want to accept instances of Number or its subclasses.

~~~ java
// the maximun() can only accept types that extends Comparable
public static < T extends Comparable < T > > T maximum(T x, T y, T z){...}
~~~

## Interfaces

can have only method signatures and fields & static final constants

- a class can implement more than one interfaces but must overrides all methods of these interfaces, otherwise, this subclass must be declared as abstract
- methods declared in interfaces are "public" by default

~~~ java
interface Bicycle {
     static final int startSpped = 0;
     void speedUp(int increment);
     void changeGear(int newValue);
}
~~~

### interface v.s. abstract class

- Interfaces are used to decouple the interface of some component from the implementation.
- Abstract classes are typically used as base classes for extension by subclasses.

~~~ java
// example of interface
interface DaoService {
	void add(...);
	void delete(...);
	void update(...);
	void findById(int id);
}

// example of abstract class
public abstract class RequestService() {
	void preService();
	void doService();
	void postService();
}
public class UserAlfaRequestService() {
	...
}
public class UserBetaRequestService() {
	...
}
~~~

### mark interface

marker interface in Java is used to indicate something to compiler, JVM or any other tool but Annotation is better way of doing same thing. One example is Serialization.

Read more: http://javarevisited.blogspot.com/2012/01/what-is-marker-interfaces-in-java-and.html#ixzz3bxihc6nj

## Classes

### Anonymous class

create a class without naming the class

~~~ java
// example of anonymous class
class Test{
     void show(){
          System.out.println("hello");
     }
     public static void main(String a[]){
          new Test().show();
     }
}
~~~

### Inner classes

class inside class

- inner class can have access to members of outer class, whereas outer class can't have access to inner class without an inner object initiation
- Local class : declare an inner class within the body of a method
- If inner class has a static member, the inner class must be declared as static
- If a non-static inner class is being accessed from within the static context of outer class, then the object of inner class would be created in this fashion (using anonymous class)

```
// example
< outer-class-object >.new < inner-class-name >().< inner-class-member-function >();
```

### Abstract class

implemented in subclasses

- An abstract method is a method that is declared without an implementation (without braces, and followed by a semicolon). abstract method must be declared in abstract class
- Abstract classes cannot be instantiated, but they can be subclassed.
- When an abstract class is subclassed, the subclass usually provides implementations for all of the abstract methods in its parent class.

~~~ java
public abstract class GraphicObject {
     ...
     // declare fields
     // declare nonabstract methods

     abstract void draw();

     void changeBrush(){
          ...
     }
}
~~~

### Concrete class

has ALL its methods implemented

## Coding Standards

- Class: first letter upper case, every word's first letter upper case, TestClass
- Method: first letter lower case, second word upper case, toString()

## Links

- http://www.tutorialspoint.com/java/index.htm
- http://www.javatpoint.com/java-tutorial
- http://www.mkyong.com/
