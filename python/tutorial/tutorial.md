---
layout: default
title: Python - Tutorial
folder: tutorial
permalink: /archive/python/tutorial/
---

# 15日Python速成

为了帮助女票学习Python，特制本教程，一共分为三个部分，循序渐进。第一部分是语法，第二部分是简单小程序实战，第三部分是简单数据分析实战。

学习的目标是，15日后，可以在实际工作中用Python写一些便捷的脚本或者做些简单的数据分析。

## Chapter 1：Syntax

这一章节主要两个目的，一是安装好环境，二是熟悉语法。

Day 1：初识python
- install python: <https://realpython.com/installing-python>; <https://www.anaconda.com>
- get started: <https://www.runoob.com/python/python-basic-syntax.html>

Day 2：数据结构
- Python 变量类型：<https://www.runoob.com/python/python-variable-types.html>
  - Numbers（数字）
  - String（字符串）
  - List（列表）
  - Tuple（元组）
  - Dictionary（字典）

Day 3：运算符
- Python 运算符：<https://www.runoob.com/python/python-operators.html>

Day 4：跳转语句1
- Python 条件语句：<https://www.runoob.com/python/python-if-statement.html>
- Python While 循环语句：<https://www.runoob.com/python/python-while-loop.html>
- Python for 循环语句：<https://www.runoob.com/python/python-for-loop.html>

Day 5：跳转语句2
- Python 循环嵌套：<https://www.runoob.com/python/python-nested-loops.html>
- Python break 语句：<https://www.runoob.com/python/python-break-statement.html>
- Python continue 语句：<https://www.runoob.com/python/python-continue-statement.html>
- Python pass 语句：<https://www.runoob.com/python/python-pass-statement.html>

Day 6：函数
- Python 函数：<https://www.runoob.com/python/python-functions.html>

Day 7：模块
- Python 模块：<https://www.runoob.com/python/python-modules.html>

## Chapter 2: Programming

这一部分的主要目的是将之前学习的语法利用起来，实际解决一些问题，在实战中融会贯通。

Day 8: Dice Rolling Simulator

~~~ python
import random

while True:
    print("Do you want to roll the dice? Y/N", end=" ")
    
    choice = input()
    
    if choice == "Y":
        dice = random.randint(1,6)
        print("Your dice is: %i" % (dice))
    elif choice == "N":
        break
    else:
        print("Input not correct, please choose again.")
        continue

print('Exit.', end=" ")
~~~

Day 9: Guess the Number

~~~ python
import random

while True:
  print("Do you want to play a game? Y/N", end=" ")
  choice = input()
  if choice == "Y":
    a=random.randint(1,10)    
    while True:
      print ("Please guess a number between 1 to 10")
      choice = input ()
      if choice.isdigit():
          choice = int(choice)
          if choice > a:
            print ("The number is too high")      
          elif choice < a:
            print ("The number is too low")      
          elif choice == a:
            print ("Correct!")
            break
      else:
          print("Input not correct, please guess a number.")
  else:
    print('Exit.', end=" ")
    break
~~~

Day 10: Mad Libs Generator

Day 11: TextBased Adventure Game

Day 12: Hearthstone Pack Simulator

<https://knightlab.northwestern.edu/2014/06/05/five-mini-programming-projects-for-the-python-beginner>

## Chapter 3: Data Science

Day 13-15
- Exploring Data
- Visualize Data

<https://towardsdatascience.com/exploratory-data-analysis-tutorial-in-python-15602b417445>
