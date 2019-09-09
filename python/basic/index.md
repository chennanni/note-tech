---
layout: default
title: Python - Basic
folder: basic
permalink: /archive/python/basic/
---

# Python - Basic

主要列出了Python和Java不同的一些地方。

## 标识符

- 以双下划线开头的 `__foo` 代表类的私有成员（private）；
- 以双下划线开头和结尾的 `__foo__` 代表 Python 里特殊方法专用的标识，如 `__init__()` 代表类的构造函数。

注：python并没有强制限定对private成员变量的应用，更多的是一种编码规范。

## 行和缩进

代码块不使用大括号 `{}` 来控制类，函数以及其他逻辑判断。而是用缩进来写模块。

~~~ python
if True:
    print "True"
else:
  print "False"
~~~

## 变量赋值

变量赋值不需要类型声明，变量赋值以后该变量才会被创建。

## 标准数据类型

- Numbers（数字）
  - int（有符号整型）
  - long（长整型[也可以代表八进制和十六进制]）
  - float（浮点型）
  - complex（复数）
- String（字符串）
- List（列表）
  - can have all kinds of data types in the list
  - `list = [ 'runoob', 786 , 2.23, 'john', 70.2 ]`
  - `print list[0]`
  - `print list[1:3]`
- Tuple（元组）
  - similar to read only list
  - `tuple = ( 'runoob', 786 , 2.23, 'john', 70.2 )`
  - `print tuple[0]`
  - `print tuple[1:3]`
- Dictionary（字典）
  - key value pair
  - `dict = { 'name':'john', 'code':6734, 'dept':'sales' }`
  - `print dict[`name`]`
  - `print dict.keys()`
  - `print dict.values()`

类型属于对象，变量是没有类型的。

~~~ python
# 变量a没有类型，它仅仅是一个对象的引用，[1,2,3]是List类型
a = [1,2,3]
~~~

strings, tuples, 和 numbers 是不可更改的对象，而 list,dict 等则是可以修改的对象。

~~~ python
# 变量赋值 a=5 后再赋值 a=10，实际是新生成一个 int 值对象 10，再让 a 指向它，而 5 被丢弃，不是改变a的值
a = 5
a = 10
# 将 list b 的第三个元素值更改，本身 b 没有动，只是其内部的一部分值被修改了
b = [1,2,3,4]
b[2] = 5
~~~

在函数参数传递的时候，分为传不可变对象和可变对象。（跟Java类似）

~~~ python
# 传递一个Number，为不可变对象，不会改变变量的值
def ChangeInt( a ):
    a = 10

b = 2
ChangeInt(b)
print b # 结果是 2

# 传递一个List，为可变对象，会改变变量的值
def changeme( mylist ):
   mylist.append([1,2,3,4]);
   return

mylist = [10,20,30];
changeme( mylist );
print mylist
~~~

## for循环

通用语法
~~~ python
for iterating_var in sequence:
   statements(s)
~~~

通过object遍历
~~~ python
for letter in 'Python':
   print letter

fruits = ['banana', 'apple',  'mango']
for fruit in fruits:
   print fruit
~~~

通过index遍历
~~~ python 
fruits = ['banana', 'apple',  'mango']
for index in range(len(fruits)):
   print fruits[index]
~~~

通过内置enumerate函数遍历
~~~ python
sequence = [12, 34, 34, 23, 45, 76, 89]
for index, item in enumerate(sequence):
	print index, item

=>
0 12
1 34
2 34
...
~~~

## 函数参数

- 必备参数
- 关键字参数
- 默认参数（缺省参数）
- 不定长参数

必备参数

必备参数须以正确的顺序传入函数。调用时的数量必须和声明时的一样。

~~~ python
def printme( str ):
   print str;
   return;

printme("hello world");
~~~

关键字参数

调用函数时指明某个关键字的值如：`f(x=1, y=2)`。

~~~ python
def printinfo( name, age ):
   print "Name: ", name;
   print "Age ", age;
   return;
 
printinfo( age=50, name="miki" );
~~~

默认参数（缺省参数）

调用函数时省略了某些参数，则在执行时使用该参数的默认值

~~~ python
def printinfo( name, age = 35 ):
   print "Name: ", name;
   print "Age ", age;
   return;

printinfo( name="miki" );
~~~

不定长参数

在定义函数时加入不定长参数，在调用时可传入不定长的参数

~~~ python
def printinfo( arg1, *vartuple ):
   print arg1
   for var in vartuple:
      print var
   return;

printinfo( 70, 60, 50 );
~~~

## 匿名函数

可以使用 lambda 来创建匿名函数。

~~~ python
sum = lambda arg1, arg2: arg1 + arg2;
 
print "相加后的值为 : ", sum( 10, 20 )
~~~

## 命名空间和作用域

在函数内部定义的变量是局部变量，
在函数外部定义的变量是全局变量。
如果重名，局部变量会覆盖全局变量。

如果要给函数内的全局变量赋值，必须使用 `global` 语句。

~~~ python
Money = 2000
def AddMoney():
   global Money
   Money = Money + 1

AddMoney()
print Money
~~~

## 引号

Python 可以使用引号( ' )、双引号( " )、三引号( ''' 或 """ ) 来表示字符串，引号的开始与结束必须的相同类型的。

## 注释

单行注释采用 # 开头。
多行注释使用三个单引号(''')或三个双引号(""")。

## 多行语句

一般以新行作为为语句的结束符，但是也可以使用斜杠（ \）将一行的语句分为多行显示。

~~~ python
total = item_one + \
        item_two + \
        item_three
~~~

## Link

- http://www.runoob.com/python/python-tutorial.html
- http://www.pythondoc.com/pythontutorial3/appetite.html
