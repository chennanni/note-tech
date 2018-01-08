---
layout: default
title: Python - Object
folder: object
permalink: /archive/python/object/
---

# Python - Object

主要记录和 Java 相比的不同之处。

## 创建类

~~~ python
class Employee:
   'employee class'
   empCount = 0
   def __init__(self, name, salary):
      self.name = name
      self.salary = salary
      Employee.empCount += 1
   def displayCount(self):
      print "Total Employee %d" % Employee.empCount
   def displayEmployee(self):
      print "Name : ", self.name,  ", Salary: ", self.salary
~~~

`__init__()` 方法是类的构造函数或初始化方法，当创建这个类的实例时会调用该方法。

类的方法与普通的函数只有一个特别的区别：它们必须有一个额外的第一个参数名称, 按照惯例它的名称是 self。

self 代表类的实例，self 在定义类的方法时是必须有的，虽然在调用时不必传入相应的参数。

## 创建实例对象

不需要使用 `new` 关键字。

~~~ python
emp1 = Employee("Zara", 2000)
~~~

## 访问属性

可以使用以下函数的方式来访问属性：
- `getattr(obj, name[, default])` : 访问对象的属性。
- `hasattr(obj,name)` : 检查是否存在一个属性。
- `setattr(obj,name,value)` : 设置一个属性。如果属性不存在，会创建一个新属性。
- `delattr(obj, name)` : 删除属性。

~~~ python
getattr(emp1, 'age')    # 返回 'age' 属性的值
setattr(emp1, 'age', 8) # 添加属性 'age' 值为 8
~~~

## 类的内置属性

- `__dict__` : 类的属性（包含一个字典，由类的数据属性组成）
- `__doc__` :类的文档字符串
- `__name__` : 类名
- `__module__` : 类定义所在的模块（类的全名是'__main__.className'，如果类位于一个导入模块mymod中，那么className.__module__ 等于 mymod）
- `__bases__` : 类的所有父类构成元素（包含了一个由所有父类组成的元组）

## GC

- 引用计数器，当引用计数变为0时，可以被回收
- 循环垃圾收集器，找到两个对象相互引用，但是没有其他变量引用他们，试图回收

回收不是立即的， 由解释器在适当的时机，将垃圾对象占用的内存空间回收。

## 继承

可以多重继承

~~~ python
class C(A, B):   # 继承类 A 和 B
~~~

##　类属性与方法

私有属性／方法：｀__private_something`，两个下划线开头，声明该属性为 private ，不能在类的外部被使用或直接访问。
只可以在类内部的方法中使用时 `self.__private＿something` 。

保护型变量：`_protected_something`，单下划线开头的表示的是 protected 类型的变量，即保护类型只能允许其本身与子类进行访问，
不能用于 `from module import *` 。

## Link

- <http://www.runoob.com/python/python-object.html>
