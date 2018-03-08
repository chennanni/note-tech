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

以"#"开头的行就是注释，没有多行注释

## Shell 变量

定义变量

注：变量名和等号之间不能有空格。

~~~ sql
your_name="alice"
~~~

使用变量

在变量名前面加美元符号即可，变量名外面的花括号是可选的，加花括号是为了帮助解释器识别变量的边界。

~~~ sql
your_name="alice"
echo $your_name
echo ${your_name}
~~~

## Shell 字符串

单引号 v.s. 双引号
- 单引号里的任何字符都会原样输出。
- 双引号里可以有变量和转义字符。

常见字符串操作

~~~ sql
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

~~~ sql
# 定义数组
array_name=(value0 value1 value2 value3)

# 读取数组
valuen=${array_name[1]} # 输出 value1

# 获取数组中的所有元素
echo ${array_name[@]}
~~~

## Links

- [Unix Tutorial](http://www.ee.surrey.ac.uk/Teaching/Unix)
- [Shell 教程](http://www.runoob.com/linux/linux-shell.html)
- [Linus Shell 编程](http://www.cnblogs.com/xuqiang/archive/2011/04/27/2031034.html)
- <http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html>
