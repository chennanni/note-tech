---
layout: default
title: Scala - Advanced
folder: advanced
permalink: /archive/advanced/scala/
---

# Scala - Advanced

## Method

Scala 的方法和 Java 可以看成是一样的，只是多了点语法糖。

使用 `def` 语句定义方法 Method 。

例

~~~ scala
def addInt( a:Int, b:Int ) : Int = {
   var sum:Int = 0
   sum = a + b
   return sum
}
~~~

注：最后一行不用 `return` 也可以返回值

### Unit

如果方法没有返回值，可以返回为 `Unit` ，这个类似于 Java 的 `void` ，如下：

~~~ scala
def printMe( ) : Unit = {
   println("Hello, Scala!")
}
~~~

### 没有传参

如果没有传入参数，调用时的括号可以省略

~~~ scala
// 花括号（有时）可以省略
// 返回值类型声明（有时）可以省略
def three() : = 1+2

println(three)
~~~

### 默认传参

可以为函数参数指定默认值，如果使用时没有传参，就用默认值。

~~~ scala
def main(args: Array[String]) {
     println( "result : " + addInt() ); // 这里的括号不能省略
}

def addInt( a:Int=5, b:Int=7 ) : Int = {
   var sum:Int = 0
   sum = a + b
   return sum
}
~~~

### 命名传参

- 在 Java 中，是根据位置来判断某个参数是什么的（传入参数的顺序必须和定义时的顺序一致）。
- 在 Scala 中，一般也是这样。但除此之外，实际调用时，还可以指定参数的名称，并不需要依照原来的顺序。

~~~
object Test {
   def main(args: Array[String]) {
        printInt(b=5, a=7);
   }
   def printInt( a:Int, b:Int ) = {
      println("Value of a : " + a );
      println("Value of b : " + b );
   }
}
~~~

## 可变参数

和Java类似，传入参数的个数可以变化，一个或者多个

~~~ scala
def sum(numbers:Int*) = {
    var result = 0
    for(number <- numbers) {
      result += number
    }
    result
}

// 调用
println(sum(1,2))
println(sum(1,2,3))
println(sum(1,2,3,4))
~~~

## Function

Scala 中的函数，和 Java 中的函数式编程 Lambda Expression 非常类似。

主要用来：
1. 函数可以直接作为参数灵活地传递，到另一方法/函数中。进而实现 lazy 触发，这也是许多框架如Spark的核心思想之一。
2. 函数可以方便地实现闭包 closure 。

使用 `val` 语句定义函数 Function 。

常用定义形式如下：

~~~ scala
val fun1 = new Function2[Int,Int,Int]() {
  override def apply(v1: Int, v2: Int): Int = {
    v1+v2
  }
}

val fun2 = new ((Int, Int) => Int)() {
  override def apply(v1: Int, v2: Int): Int = {
    v1+v2
  }
}

// 最常用
val fun3 = (v1:Int,v2:Int) => v1+v2

// 空格 + 下划线 可以把 method 转换成 function
val fun4 = fun4Method _
def fun4Method(v1:Int,v2:Int): Int = {
  v1+v2
}
~~~

### 闭包

闭包是一个函数，返回值依赖于声明在函数外部的一个或多个变量。

定义示例1：

~~~ scala
var more = 1
val addMore = (x: Int) => x + more

scala> addMore(10)
res: Int = 11
~~~

（但是，上例从理解层面，不就相当于函数中引用了一个全局变量嘛，感受不出闭包的好处。）

实际示例2：

~~~ scala
def makeIncreaser(more: Int) = (x: Int) => x + more

scala> val inc1 = makeIncreaser(1)
scala> val inc5 = makeIncreaser(5)

scala> inc1(10)
res: Int = 11

scala> inc5(10)
res: Int = 15
~~~

（从上例中，我们可以看到，闭包可以让我们更加灵活地定义函数，如inc1，inc5）

参考 -> scala 方法&函数 <https://www.cnblogs.com/ulysses-you/p/7551188.html>

## 类 - 继承

- 重写一个非抽象方法必须使用 override 关键字。
- 子类重写父类的抽象方法时，不需要使用 override 关键字。

~~~
class Person {
  var name = ""
  override def toString = getClass.getName + "[name=" + name + "]"
}

class Employee extends Person {
  var salary = 0.0
  override def toString = super.toString + "[salary=" + salary + "]"
}
~~~

## 类 - Object

`object`关键字，相当于 class 的单个实例，类似于 Java 中的 `static` ，通常在里面放一些静态的 field 和 method 。 

### 实现 main 方法

~~~ scala
object HelloWorld {
  def main(args: Array[String]) {
    println("Hello World!!!")
  }
}
~~~

### 实现工具类

object继承抽象类，并重写抽象类中的方法

~~~ scala
abstract class Hello(var message: String) {
  def sayHello(name: String): Unit
}

object HelloImpl extends Hello("hello") {
  override def sayHello(name: String) = {
    println(message + ", " + name)
  }
}

//调用
HelloImpl.sayHello("Tom")
~~~

### 实现特殊的 apply 方法

让对象创建更加简洁

~~~ scala
// 示例1

class Person(val name: String)

object Person {
  def apply(name: String) = new Person(name)
}

val person = Person("Tom")

// 示例2

class Person()

object Person {
  def apply() = new Person()
}

val person = Person
~~~

### 作为伴生对象

Companion Object，相当于把所有 static 的属性，方法，代码块儿等进行了汇总

~~~ scala
object Person {
  private val eyeNum = 2
  def getEyeNum = eyeNum
}

class Person(val name: String, val age: Int) {
  def sayHello = println("Hi, " + name 
      + ", I guess you are " + age + " years old!" 
      + ", and usually you must have " + Person.eyeNum + " eyes.")
}

val person = new Person("Tom",23)
person.sayHello
~~~

### 实现枚举值

~~~ scala
// 示例1

object Season extends Enumeration {
  val SPRING, SUMMER, AUTUMN, WINTER = Value
}

Season(0)

// 示例2

object Season extends Enumeration {
  val SPRING = Value(0, "spring")
  val SUMMER = Value(1, "summer")
  val AUTUMN = Value(2, "autumn")
  val WINTER = Value(3, "winter")
}

Season.withName("spring")
~~~

参考 -> scala之object类 <https://blog.csdn.net/weixin_39966065/article/details/90232640>

## Trait

Scala `Trait` 特征 相当于 Java 的 `Interface` 接口（加强版），它还可以定义属性和方法的实现。

~~~
trait Equal {
  def isEqual(x: Any): Boolean
  def isNotEqual(x: Any): Boolean = !isEqual(x)
}
~~~

## Case

模式匹配

~~~
def matchTest(x: Int): String = x match {
  case 1 => "one"
  case 2 => "two"
  case _ => "many"
}
~~~

## Exception

异常处理

~~~
import java.io.FileReader
import java.io.FileNotFoundException
import java.io.IOException

object Test {
   def main(args: Array[String]) {
      try {
         val f = new FileReader("input.txt")
      } catch {
         case ex: FileNotFoundException => {
            println("Missing file exception")
         }
         case ex: IOException => {
            println("IO Exception")
         }
      } finally {
         println("Exiting finally...")
      }
   }
}
~~~

## I/O

读：从屏幕上读取用户输入

~~~
import scala.io._
object Test {
   def main(args: Array[String]) {
      print("Please input: " )
      val line = StdIn.readLine()
      println("Your input is: " + line)
   }
}
~~~

读：从文件上读取内容

~~~
import scala.io.Source

object Test {
   def main(args: Array[String]) {
      println("file content is: " )
      Source.fromFile("test.txt" ).foreach{
         print
      }
   }
}
~~~

写：写入文件

~~~
import java.io._

object Test {
   def main(args: Array[String]) {
      val writer = new PrintWriter(new File("test.txt" ))
      writer.write("hello")
      writer.close()
   }
}
~~~

## 参考

- Scala 教程 <https://www.runoob.com/scala/scala-tutorial.html>
