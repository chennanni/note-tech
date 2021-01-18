---
layout: default
title: Scala
folder: scala
permalink: /archive/scala/
---

# Scala

Scala和Java语法非常像。下面着重介绍Scala与Java的不同之处。

## 分号

Scala 与 Java 的一个区别是：Scala 语句末尾的分号 `;` 是**可选**的。

## 引用

~~~
import java.awt._ // 引入所有类
import java.awt.{Color, Font} // 引入多个类
import java.util.{HashMap => JavaHashMap} // 引入并重命名
~~~

## 类型声明

Scala在写代码的时候，不需要显式声明数据类型。在编译阶段，编译器会根据赋值自动给变量确定类型。

~~~
scala> var name = 2
name: Int = 2

scala> var name = "Alex"
name: String = Alex
~~~

## 变量与常量

使用关键词 "var" 声明**变量**

~~~
var myVar : String = "FooVar"
~~~

使用关键词 "val" 声明**常量**

~~~
val myVal : String = "FooVal"
~~~

可以只声明类型，不赋予初始值

~~~
var myVar : String
val myVal : String
~~~

不指定类型的话，一定要有初始值 （否则编译器无法推断出它的类型）

~~~
var myVar = 10;
val myVal = "Hello, Scala";
~~~

## 访问修饰符

有三个：

- `private`：最严格，只能类/对象内部访问
- `protected`：如果需要某个 field 被子类访问，用这个
- `public`：最宽松，所有人都可以访问

如果没有，默认为 public 。 Scala 中的 private 和 protected 比 Java 规定得更严格。

具体的区别不列举了，笔者认为这样的3层分法比Java的4层分法更清晰明了，也更实用。

**作用域保护**

~~~
private[Navigator] val distance = 100
~~~

表示： distance 这个常量，只对 Navigator 这个 包/类/对象，（以及它的伴生对象可见），对其它的所有类都是 private 。

## For

语法 和 常见示例

~~~
for( var x <- Range ){
   statement(s);
}

for( a <- 1 to 10) // 遍历1-10
for( a <- 1 to 3; b <- 1 to 3) // 遍历a，b两个数，1-3的所有组合
for( a <- numList ) // 遍历一个List
~~~

for + if 过滤

~~~
object Test {
   def main(args: Array[String]) {
      var a = 0;
      val numList = List(1,2,3,4,5,6,7,8,9,10);

      // for 循环
      for( a <- numList
           if a != 3; if a < 8 ){
         println( "Value of a: " + a );
      }
   }
}
~~~

for + yeild 记录

~~~
object Test {
   def main(args: Array[String]) {
      var a = 0;
      val numList = List(1,2,3,4,5,6,7,8,9,10);

      // for 循环
      var retVal = for{ a <- numList
                        if a != 3; if a < 8
                      }yield a

      // 输出返回值
      for( a <- retVal){
         println( "Value of a: " + a );
      }
   }
}
~~~

## Break

~~~
// 导入以下包
import scala.util.control._

// 创建 Breaks 对象
val loop = new Breaks;

// 在 breakable 中循环
loop.breakable{
    // 循环
    for(...){
       ....
       // 循环中断
       loop.break;
   }
}
~~~


## Method

Scala 的方法和 Java 可以看成是一样的，只是多了点语法糖。

使用 `def` 语句定义方法 Method 。

代码举例如下：

~~~ scala
object add{
   def addInt( a:Int, b:Int ) : Int = {
      var sum:Int = 0
      sum = a + b
      return sum
   }
}
~~~

### Unit

如果方法没有返回值，可以返回为 `Unit` ，这个类似于 Java 的 `void` ，如下：

~~~ scala
object Hello{
   def printMe( ) : Unit = {
      println("Hello, Scala!")
   }
}
~~~

### 默认值

可以为函数参数指定默认值，如果使用时没有传参，就用默认值。

~~~ scala
object Test {
   def main(args: Array[String]) {
        println( "result : " + addInt() );
   }
   def addInt( a:Int=5, b:Int=7 ) : Int = {
      var sum:Int = 0
      sum = a + b
      return sum
   }
}
~~~

### 指定传参的名称

在 Java 中，是根据位置来判断某个参数是什么的（传入参数的顺序必须和定义时的顺序一致）。
在 Scala 中，一般也是这样。但除此之外，实际调用时，还可以指定参数的名称，并不需要依照原来的顺序。

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

## 数组

一维数组

~~~
var z:Array[String] = new Array[String](3)

或

var z = new Array[String](3)

或定义并赋值

var z = Array("1", "2", "3")

或定义并赋值

var z = range(1,4)
~~~

二维数组

~~~
val myMatrix = Array.ofDim[Int](3, 4)
~~~

## Collection

### List

连接 List

~~~ scala
object Test {
   def main(args: Array[String]) {
   
      val site1 = List("111", "222", "333")
      val site2 = "444" :: ("555" :: ("666" :: Nil))

      // 使用 ::: 运算符
      var site3 = site1 ::: site2
      println( "site1 ::: site2 : " + site3 )
     
      // 使用 List.:::() 方法
      site3 = site1.:::(site2)
      println( "site1.:::(site2) : " + site3 )

      // 使用 concat 方法
      site3 = List.concat(site1, site2)
      println( "List.concat(site1, site2) : " + site3  )
     
   }
}
~~~

### Map

输出 Map 的 keys 和 values

~~~ scala
object Test {
   def main(args: Array[String]) {
      val sites = Map("1" -> "111",
                       "2" -> "222",
                       "3" -> "333")

      sites.keys.foreach{ i =>  
                           print( "Key = " + i )
                           println(" Value = " + sites(i) )}
   }
}
~~~

### Option

Scala Option(选项)类型用来表示一个值是可选的（有值或无值)。

例1

~~~ scala
val myMap: Map[String, String] = Map("key1" -> "value")
val value1: Option[String] = myMap.get("key1")
val value2: Option[String] = myMap.get("key2")
 
println(value1) // 输出为Some("value1")
println(value2) // 输出为None
~~~

例2： getOrElse

~~~ scala
object Test {
   def main(args: Array[String]) {
      val a:Option[Int] = Some(5)
      val b:Option[Int] = None
     
      println("a.getOrElse(0): " + a.getOrElse(0) )   // 输出为5
      println("b.getOrElse(10): " + b.getOrElse(10) ) // 输出为10
   }
}
~~~

例3： isEmpty

~~~ scala
object Test {
   def main(args: Array[String]) {
      val a:Option[Int] = Some(5)
      val b:Option[Int] = None
     
      println("a.isEmpty: " + a.isEmpty ) // 输出为false
      println("b.isEmpty: " + b.isEmpty ) // 输出为true
   }
}
~~~

### Tuple

元组

- 元素不可变
- 可以包含不同类型的元素

定义

~~~ scala
val t = (1, 3.14, "Fred")  
val t = new Tuple3(1, 3.14, "Fred")
~~~

访问：使用`t._1`, `t._2`

~~~ scala
object Test {
   def main(args: Array[String]) {
      val t = (4,3,2,1)

      val sum = t._1 + t._2 + t._3 + t._4

      println( "元素之和为: "  + sum )
   }
}
~~~

迭代：使用`Tuple.productIterator()`

~~~ scala
object Test {
   def main(args: Array[String]) {
      val t = (4,3,2,1)
     
      t.productIterator.foreach{ i =>println("Value = " + i )}
   }
}
~~~

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
