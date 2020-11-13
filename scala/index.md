# Scala

Scala和Java语法非常像。下面着重介绍Scala与Java的不同之处。

## 分号

Scala 与 Java 的最大区别是：Scala 语句末尾的分号 `;` 是**可选**的。

## 引用

~~~
import java.awt._ // 引入所有类
import java.awt.{Color, Font} // 引入多个类
import java.util.{HashMap => JavaHashMap} // 引入并重命名
~~~

## 变量

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
