---
layout: default
title: Shell - Scripting
folder: script
permalink: /archive/shell/script/
---

# Shell - Scripting (Linux)

## About Linux

What is Linux?
- Free
- Unix Like
- Open Source
- Network oprating system

Where can I use Linux?
- Linux Server
- Standalone workstation/PC

What is Kernal?
- Kernel is heart of Linux Os.
- It acts as an intermediary between the computer hardware and various programs/appli
ion/shell.

## Shell and Shell Script

Shell 是一个用 C 语言编写的程序，它提供了一个界面，用户可以通过这个界面访问操作系统的内核服务。

Shell 脚本（shell script），是一种为 shell 编写的脚本程序。它可以通过解释器来执行。

## Shell 解释器

Linux 有很多 Shell 解释器，如下：
- Bourne Shell（/usr/bin/sh或/bin/sh）
- Bourne Again Shell（/bin/bash）
- C Shell（/usr/bin/csh）

一般在 Shell 脚本的第一行，会指明用哪个解释器。

~~~ shell
#!/bin/bash
echo "Hello World !"
~~~

## 执行 Shell 脚本

两种方法：

1. 作为可执行程序。

~~~ shell
chmod +x ./test.sh
./test.sh
~~~

2. 作为解释器参数。

~~~ shell
/bin/sh test.sh
~~~

## Shell 注释

以"#"开头的行就是注释，没有多行注释。

如果需要临时注释大段代码，可以将其用花括号括起来，当作未被调用的函数。

## Shell 变量

定义变量

注：变量名和等号之间不能有空格。

~~~ shell
your_name="alice"
~~~

使用变量

在变量名前面加美元符号即可，变量名外面的花括号是可选的，加花括号是为了帮助解释器识别变量的边界。

~~~ shell
your_name="alice"
echo $your_name
echo ${your_name}
~~~

## Shell 字符串

单引号 v.s. 双引号
- 单引号里的任何字符都会原样输出。
- 双引号里可以有变量和转义字符。

常见字符串操作

~~~ shell
your_name="alice"

# 拼接字符串，直接拼接，不需要用+
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"

# 获取字符串长度
echo ${#your_name} #输出 5

# 提取子字符串
echo ${alice:1:4} # 输出 lice
~~~

## Shell 数组

用括号来表示数组，数组元素用"空格"符号分割开

~~~ shell
# 定义数组
array_name=(value0 value1 value2 value3)

# 读取数组
valuen=${array_name[1]} # 输出 value1

# 获取数组中的所有元素
echo ${array_name[@]}
~~~

## Shell 命令行传参

- `$n`：引用某个传入的参数，n从1开始计数。
- `$#`：传递到脚本的参数个数。
- `$*`：以一个单字符串显示所有向脚本传递的参数。

~~~ shell
# 定义脚本
echo "执行的文件名：$0";
echo "第一个参数为：$1";
echo "第二个参数为：$2";
echo "参数个数为：$#";
echo "传递的参数作为一个字符串显示：$*";

# 调用
$ ./test.sh 1 2 3
~~~

## Shell 基本运算符

算术运算符

原生bash不支持数学运算，但是可以通过其他命令来实现，如 awk 和 expr，expr。

~~~ shell
# 注意1：使用的是反引号 ` 而不是单引号 '
# 注意2：表达式和运算符之间要有空格
# 加
val=`expr $a + $b`
# 减
val=`expr $a - $b`
# 乘
val=`expr $a \* $b`
# 除
val=`expr $b / $a`
# 取余
val=`expr $b % $a`
~~~

关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

~~~ shell
if [ $a -eq $b ] # 等于
if [ $a -ne $b ] # 不等于
if [ $a -gt $b ] # 大于
if [ $a -lt $b ] # 小于
if [ $a -ge $b ] # 大于等于
if [ $a -le $b ] # 小于等于
~~~

布尔/逻辑运算符

~~~ shell
# 非运算
if [ $a != $b ]
# 逻辑的 AND
if [[ $a -lt 100 && $b -gt 100 ]]
# 逻辑的 OR
if [[ $a -lt 100 || $b -gt 100 ]]
~~~

字符串运算符

~~~ shell
# 两个字符串相等
if [ $a = $b ]
# 两个字符串不相等
if [ $a != $b ]
# 字符串长度为0
if [ -z $a ]
# 字符串长度不为0
if [ -n $a ]
# 字符串不为空
if [ $a ]
~~~

文件测试运算符

~~~ shell
# 文件是个目录
if [ -d $file ]
# 文件不为空
if [ -s $file ]
# 文件存在
if [ -e $file ]
~~~

## Shell 流程控制

if-else

注：方括号和判断条件之间要加空格。不允许空的else分支。

~~~ shell
a=10
b=20
if [ $a == $b ]
then
   echo "a 等于 b"
elif [ $a -gt $b ]
then
   echo "a 大于 b"
elif [ $a -lt $b ]
then
   echo "a 小于 b"
else
   echo "没有符合的条件"
fi
~~~

for 循环

~~~ shell
for str in 'This is a string'
do
    echo $str
done
~~~

while 循环

~~~ shell
int=1
while(( $int<=5 ))
do
    echo $int
    let "int++"
done
~~~

case 语句

~~~ shell
echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case $aNum in
    echo '你选择了 1'
    ;;
    echo '你选择了 2'
    ;;
    echo '你选择了 3'
    ;;
    echo '你选择了 4'
    ;;
    echo '你没有输入 1 到 4 之间的数字'
    ;;
esac
~~~

## Shell 函数

- 定义：两种方式，`fun()`或者`function fun()`。
- 传参：定义函数时不用带任何参数，使用时用`$n`来获取传入参数。
- 返回值：可以用`return`返回一个值，如果没有`return`，将以最后一条命令运行结果作为返回值。使用时用`$?`来获取返回值。
- 使用：直接调用函数名+参数来使用函数，不需要括号。

~~~ shell
firstFun(){
    echo "Hello World!"
}

function secondFunAdd(){
   echo "p1: $1"
   echo "p2: $2"
   return $1+$2
}

secondFunAdd 11 22
echo "p1 + p2 = $?"
~~~

## Shell 输入/输出重定向

输出重新定向

~~~ shell
# 执行command然后将输出的内容存入file
command > file

# 将用户信息存入users
who > users

# 以追加形式将echo的内容写入file
echo "123" >> file

# 注：这里who/echo在cmd不会有显示，因为值已经被重新定向到文件了
~~~

输入重新定向

~~~ shell
# 从file获取值，作为command的输入
command < file
~~~

标准文件

- 标准输入文件(stdin)：文件描述符为0，读取数据。
- 标准输出文件(stdout)：文件描述符为1，输出数据。
- 标准错误文件(stderr)：文件描述符为2，写入错误信息。

~~~ shell
# 将stderr写入file
$ command 2 > file

# 将stdout和stderr合并后追加写入file
command >> file 2>&1
~~~

`/dev/null`文件

~~~ shell
# 如果想要执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到/dev/null
command > /dev/null
~~~

## Shell 文件包含

- `. filename`，注意点号(.)和文件名中间有一空格
- `source filename`

## Links

- [Unix Tutorial](http://www.ee.surrey.ac.uk/Teaching/Unix)
- [Shell 教程](http://www.runoob.com/linux/linux-shell.html)
- [Linus Shell 编程](http://www.cnblogs.com/xuqiang/archive/2011/04/27/2031034.html)
- <http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html>
