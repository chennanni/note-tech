---
layout: default
title: Javascript - OOP
folder: oop
permalink: /archive/javascript/oop/
---


# JS OOP

 In JavaScript, all values, except primitive values, are objects.

## Prototype ##

Every JavaScript function has a **prototype property** (this property is empty by default). You add methods and properties on a function’s prototype property to make those methods and properties available to instances of that function.

An object’s **prototype attribute** points to the object’s “parent”—the object it inherited its properties from.

[JS Prototype](http://javascriptissexy.com/javascript-prototype-in-plain-detailed-language/)

## Create an Object ##

- use prototype pattern
  - Define and create a single object, using an object literal.
  - Define and create a single object, with the keyword new.
- use constructor pattern
  - Define an object constructor, and then create objects of the constructed type.

use an object literal

``` javascript
var person = {
    firstName:"John",
    lastName:"Doe",
};

```

use new keyword

``` javascript
var person = new Object();
person.firstName = "John";
person.lastName = "Doe";
```

use an object constructor

``` javascript
function person(first, last) {
    this.firstName = first;
    this.lastName = last;
}
var myFather = new person("John", "Doe");
```

Notice: Objects are mutable. They are addressed by reference, not by value.

x is y, not a copy of y

``` javascript
var x = y;
```

## Create Objects Best Practice ##

Whenever you want to create objects with similar functionalities (to use the same methods and properties), you encapsulate the main functionalities in a Function and you use that Function’s constructor to create the objects.

``` javascript
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

## Inheritance ##

use `Object.create()`

``` javascript
var cars = {
    type:"sedan",
    wheels:4
};
var toyota = Object.create (cars); // now toyota inherits the properties from cars
```

use `inheritPrototype()`

``` javascript
function Question(theQuestion, theChoices, theCorrectAnswer) {...}

function MultipleChoiceQuestion(theQuestion, theChoices, theCorrectAnswer){
    Question.call(this, theQuestion, theChoices, theCorrectAnswer);
	inheritPrototype(MultipleChoiceQuestion, Question);
};
```

## Links

- [OOP in JS](http://javascriptissexy.com/oop-in-javascript-what-you-need-to-know/)
