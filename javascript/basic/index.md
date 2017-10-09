---
layout: default
title: Javascript - Basic
folder: basic
permalink: /archive/javascript/basic
---

# Javascript - Basic

## Intro
 * HTML to define the content of web pages
 * CSS to specify the layout of web pages
 * **JavaScript to program the behavior of web pages**
 * (Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine.)

## What does (Client Side) JS do?
- dynamically add content
- dynamically change styling (CSS)
- dynamically do some funciton
 - form validation
 - invoke AJAX call
 - set timeout
 - pop-out window

## Add JavaScript to the Webpage
insert Javascript code between `<script></script>`

``` javascript
<script>
function example(){
    //MORE
}
</script>
```

or

``` javascript
<script src = "example.js"></script>
```

## Display Something in the Webpage
* Writing into an alert box, using `window.alert()`
* Writing into the HTML output using `document.write()`
* Writing into an HTML element, using `innerHTML`
* Writing into the browser console, using `console.log()`

## Statement

``` javascript
var x = 5+6; // this is an example
```

JS statements are composed of

- Values
  - Literals: 10.5, "ABC"
  - Variables: x, y
- Operators: =, +, -, *, /
- Expressions: 5+6
- Keywords: var
- Comments: // or /* */

## Data Type
* Numbers
* Strings
* Booleans
* Arrays
* Objects

## Array & Object

``` javascript
var anArray = [a,b,c];
var anObject = {name:"Jams", id:007, weight:70};
```

## Scope
* Local, declared inside a function
* Global, declared outside a function
* undeclared variable becomes Global

## Funciton
* function name return the function itself, e.g. `myFunciton`
* function name + () return the execution of the function, e.g. `myFunction()`

**Closure**

A closure is a function having access to the parent scope, even after the parent function has closed.

## Event
* onchange()
* onclick()
* onmouseover()
* onmouseout()
* onkeydown()
* onload()

## Loop Control

For-in & For-of

``` javascript
// iterates over the values of object's properties
for (var name in person) { }

// iterating over iterable objects
for (var oneperson of person) { }
```

Break & Continuie & Labels

``` html
<script type="text/javascript">
    document.write("Entering the loop!<br /> ");
    outerloop: // This is the label name
 
    for (var i = 0; i < 5; i++)
    {
       document.write("Outerloop: " + i + "<br />");
       innerloop:
       for (var j = 0; j < 5; j++)
       {
          if (j > 3 ) break ; // Quit the innermost loop
          if (i == 2) break innerloop; // Do the same thing
          if (i == 4) break outerloop; // Quit the outer loop
          document.write("Innerloop: " + j + " <br />");
       }
    }
    document.write("Exiting the loop!<br /> ");
</script>
```

## Global Reference
- Global Properties
  - Infinity
  - NaN
  - undefined

- Global Functions
  -  isFinite()
  -  isNaN()
  -  parstInt()
  -  parseFloat()

## DOM
In the HTML DOM (Document Object Model), everything is a node

The HTML DOM is a standard for how to get, change, add, or delete HTML elements.

Three keys: **Object**,**Method**,**Property**;

```
document.getElementById("demo").innerHTML = "Hello World!";
// Object: document
// Method: getElementById()
// Property: innerHTML
```

**Find HTML Elements**

``` html
document.getElementById()
getElementsByTagName
document.getElementsByClassName()
```

**Changing HTML Elements**

``` html
element.innerHTML=
element.attribute=
element.setAttribute(attribute,value)
element.style.property=
```

**Changing Context**

- value: only for form input types
- innerHTML: for all DOM elements, inclues markup
- innerText: only plain text

**Add Event Handler**

``` html
document.getElementById(id).onclick=function(){code}
```

## Link
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide>
- <http://web.jobbole.com/85521/>
