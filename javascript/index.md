# Javascript

## Intro
 * HTML to define the content of web pages
 * CSS to specify the layout of web pages
 * JavaScript to program the behavior of web pages

## What JS do?
- dynamically add content
- dynamically change styling (CSS)
- dynamically do some funciton
 - form validation
 - invoke AJAX call
 - set timeout
 - pop-out window

## Add JavaScript to the Webpage
insert Javascript code between `<script></script>`

```
<script>
function example(){
    //MORE
}
</script>
```

or

```
<script src = "example.js"></script>
```

## Display Something in the Webpage
* Writing into an alert box, using `window.alert()`
* Writing into the HTML output using `document.write()`
* Writing into an HTML element, using `innerHTML`
* Writing into the browser console, using `console.log()`

## Statement
```
var x = 5+6; // this is an example
```

JS statements are composed of
- Values
  - Literals: `10.5`, `"ABC"`
  - Variables: `x, y`
- Operators: `=, +, -, *, /`
- Expressions: `5+6`
- Keywords: `var`
- Comments: `//` or `/* */`

## Data Type
* Numbers
* Strings
* Booleans
* Arrays
* Objects

## Scope
* Local, declared inside a function
* Global, declared outside a function
* undeclared variable becomes Global

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

## Event
* onchange()
* onclick()
* onmouseover()
* onmouseout()
* onkeydown()
* onload()

## For/In Loop

```
for (var x in person) { }

```

## Funciton
* function name return the function itself, e.g. `myFunciton`
* function name + () return the execution of the function, e.g. `myFunction()`

## Array & Object
```
var anArray = [a,b,c];
var anObject = {name:"Jams", id:007, weight:70};
```

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

```
document.getElementById()
getElementsByTagName
document.getElementsByClassName()
```

**Changing HTML Elements**

```
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

```
document.getElementById(id).onclick=function(){code}
```

## Closure
A closure is a function having access to the parent scope, even after the parent function has closed.

## JS OOP

 In JavaScript, all values, except primitive values, are objects.

**Prototype**

Every JavaScript function has a **prototype property** (this property is empty by default). You add methods and properties on a function’s prototype property to make those methods and properties available to instances of that function.

An object’s **prototype attribute** points to the object’s “parent”—the object it inherited its properties from.

[JS Prototype](http://javascriptissexy.com/javascript-prototype-in-plain-detailed-language/)

**Create an Object**

- use prototype pattern
 - Define and create a single object, using an object literal.
 - Define and create a single object, with the keyword new.
- use constructor pattern
 - Define an object constructor, and then create objects of the constructed type.

use an object literal
```
var person = {
    firstName:"John",
    lastName:"Doe",
};

```

use new keyword
```
var person = new Object();
person.firstName = "John";
person.lastName = "Doe";
```

use an object constructor
```
function person(first, last) {
    this.firstName = first;
    this.lastName = last;
}

var myFather = new person("John", "Doe");
```

Notice: Objects are mutable. They are addressed by reference, not by value.

x is y, not a copy of y
```
var x = y;
```

**Create Objects Best Practice**

Whenever you want to create objects with similar functionalities (to use the same methods and properties), you encapsulate the main functionalities in a Function and you use that Function’s constructor to create the objects.

```
function User (theName, theEmail) {
    this.name = theName;
    this.email = theEmail;
    this.quizScores = [];
    this.currentScore = 0;
}

User.prototype = {
    constructor: User,
    saveScore:function (theScoreToAdd)  {
        this.quizScores.push(theScoreToAdd)
    },

    showNameAndScores:function ()  {
        var scores = this.quizScores.length > 0 ? this.quizScores.join(",") : "No Scores Yet";
        return this.name + " Scores: " + scores;
    },

    changeEmail:function (newEmail)  {
        this.email = newEmail;
        return "New Email Saved: " + this.email;
    }
}

firstUser = new User("Richard", "Richard@examnple.com"); 
```

**Inheritance**

use `Object.create()`

```
var cars = {
    type:"sedan",
    wheels:4
};

var toyota = Object.create (cars); // now toyota inherits the properties from cars
```

use `inheritPrototype()`

```
function Question(theQuestion, theChoices, theCorrectAnswer) {...}

function MultipleChoiceQuestion(theQuestion, theChoices, theCorrectAnswer){
    Question.call(this, theQuestion, theChoices, theCorrectAnswer);
	inheritPrototype(MultipleChoiceQuestion, Question);
};
```

[OOP in JS](http://javascriptissexy.com/oop-in-javascript-what-you-need-to-know/)

## Link
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- http://web.jobbole.com/85521/
