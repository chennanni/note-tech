---
layout: default
title: Javascript - Function
folder: function
permalink: /archive/javascript/function/
---

# Javascript - Function

## 函数的定义

函数声明

~~~ javascript
function myFunction(a, b) {
    return a * b;
}
~~~

函数表达式（匿名函数）

~~~ javascript
var x = function (a, b) {return a * b};
~~~

Function() 构造函数

~~~ javascript
var myFunction = new Function("a", "b", "return a * b");
var x = myFunction(4, 3);
~~~

## 函数的提升（Hoisting）

JavaScript 默认将当前 变量的声明与函数的声明 的作用域提升到 最前面 去。所以，函数可以在声明之前调用。

~~~ javascript
myFunction(5);

function myFunction(y) {
    return y * y;
}
~~~

## 函数的使用

普通地作为一个函数（值）使用

~~~ javascript
function myFunction(a, b) {
    return a * b;
}

var x = myFunction(4, 3);
~~~

自调用函数

~~~ javascript
// 在函数表达式后面紧跟 () ，则会自动调用。即该函数表达式的返回值不是一个函数，而是函数的执行结果。
// 但是不能自调用声明的函数。
(function () {
    var x = "Hello!!";
})();
~~~

## 闭包

可访问上一层函数作用域里变量的函数，即使上一层函数已经关闭。闭包使得函数拥有私有变量变成可能

~~~ javascript
// counter变量为add()私有，且可以在add()关闭后继续使用
var add = (function () {
    var counter = 0;
    return function () {return counter += 1;}
})();

add();
add();

// 计数器为 2
~~~

## Link

- <http://www.runoob.com/js/js-function-closures.html>
