---
layout: default
title: Scala - Basic
folder: basic
permalink: /archive/basic/scala/
---

# Scala

## 安装

前置条件：Java8

下载地址：<https://www.scala-lang.org/download>

Linux：
- unzip
- set SCALA_HOME and PATH

Windows：
- install from .msi

IDE: 
- Intellij Scala Plugin

## Hello World

代码

~~~ scala
object HelloWorld {
	def main(args : Array[String]) {
		println("Hello World...")
	}
}
~~~

编译运行

~~~ shell
scalac HelloWorld.scala
scala -classpath . HelloWorld
~~~

参考 -> <https://bk.tw.lvfukeji.com/wiki/Scala>

## 分号

Scala 与 Java 的一个区别是：Scala 语句末尾的分号 `;` 是**可选**的。

## 变量与常量

使用关键词 "var" 声明**变量**，使用关键词 "val" 声明**常量**

~~~ scala
var myVar : String = "FooVar"
val myVal : String = "FooVal"
~~~

特例1：不（需要）显式声明数据类型，在编译阶段，编译器会根据赋值自动给变量确定类型。

~~~ scala
scala> var name = 2
name: Int = 2

scala> var name = "Alex"
name: String = Alex
~~~

特例2：当然，也可以只声明类型，不赋予初始值

~~~ scala
var myVar : String
val myVal : String
~~~

## 数据类型

常用

- 字符 Byte/Char
- 数字 Short/Int/Long/Float/Double
- 布尔 Boolean

类型转换

- `asInstanceOf[Double]`
- `isInstanceOf[Int]`

## 数组

一维数组

~~~ scala
var z:Array[String] = new Array[String](3)

或

var z = new Array[String](3)

或定义并赋值

var z = Array("1", "2", "3")

或定义并赋值

var z = range(1,4)
~~~

二维数组

~~~ scala
val myMatrix = Array.ofDim[Int](3, 4)
~~~

## 集合 

Collection

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

## 访问修饰符

有三个：

- `private`：最严格，只能类/对象内部访问
- `protected`：如果需要某个 field 被子类访问，用这个
- `public`：最宽松，所有人都可以访问

如果没有，默认为 public 。 Scala 中的 private 和 protected 比 Java 规定得更严格。

具体的区别不列举了，笔者认为这样的3层分法比Java的4层分法更清晰明了，也更实用。

**作用域保护**

~~~ scala
private[Navigator] val distance = 100
~~~

表示： distance 这个常量，只对 Navigator 这个 包/类/对象，（以及它的伴生对象可见），对其它的所有类都是 private 。

## 引用

~~~ scala
// 引入所有类
import java.awt._

// 引入多个类
import java.awt.{Color, Font}

// 引入并重命名
import java.util.{HashMap => JavaHashMap} 
~~~

## 延迟加载

Lazy Loading：当声明常量/变量时，不进行赋值，而是当第一次用到的时候，才进行赋值，达到延迟加载的效果。

使用关键字 `lazy` 实现。

~~~ scala
scala > import scala.io.Source._
scala > lazy val info = fromFile("some/path/HelloWorld.scala").mkString
    info: String = <lazy>
scala > info
    res1 : String = "..."
~~~

## 循环表达式

- to，前后都包
- Range，前包后不包
- until，前包后不包

~~~ scala
1 to 10
1.to(10)
~~~

-> 1...10

~~~ scala
Range(1,10)
Range(1,10,1) // step = 1
~~~

-> 1...9

~~~ scala
1 until 10
1.until(10)
~~~

-> 1...9

## For

语法

~~~ scala
for( var x <- Range ){
   ...
}
~~~

常见示例

~~~ scala
for( a <- 1 to 10 ) // 遍历1-10
for( a <- 1 to 3; b <- 1 to 3 ) // 遍历a，b两个数，1-3的所有组合
for( a <- numList ) // 遍历一个List
~~~

for + if 过滤

~~~ scala
def main(args: Array[String]) {
	var a = 0;
	val numList = List(1,2,3,4,5,6,7,8,9,10);

	// for 循环
	for( a <- numList if a != 3; if a < 8 ){
		println( "Value of a: " + a );
	}
}
~~~

for + yeild 记录

~~~ scala
def main(args: Array[String]) {
	var a = 0;
	val numList = List(1,2,3,4,5,6,7,8,9,10);

	// for 循环
	var retVal = for{ a <- numList if a != 3; if a < 8
	}yield a

	// 输出返回值
	for( a <- retVal){
		println( "Value of a: " + a );
	}
}
~~~

## Break

~~~ scala
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

## 其他
- [[scala/advanced/advanced]]