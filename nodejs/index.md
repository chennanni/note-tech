---
layout: default
title: NodeJS
folder: nodejs
permalink: /archive/nodejs/
---

# NodeJS

## What is NodeJS

- Node.js is a **JavaScript runtime** built on Chrome's V8 JavaScript engine.
- Node.js uses an **event-driven**, **non-blocking I/O model** that makes it lightweight and efficient.
- Node.js' **package ecosystem, npm**, is the largest ecosystem of open source libraries in the world.

## Callback

-> non-blocking

``` javascript
var fs = require("fs");

fs.readFile('input.txt', function (err, data) {
    if (err) return console.error(err);
    console.log(data.toString());
});

console.log("Program Ended");
```

## Event

- A main loop that listens for events, and then triggers a callback function when one of those events is detected.
- Another multi-thread environment that execute these events.

All objects which emit events are instances of `events.EventEmitter`.

``` javascript
var events = require('events');
var eventEmitter = new events.EventEmitter();

// listener #1
var listner1 = function listner1() {
  console.log('listner1 executed.');
}

// Bind the connection event with the listner1 function
eventEmitter.addListener('connection', listner1);

var eventListeners = require('events').EventEmitter.listenerCount(eventEmitter,'connection');
console.log(eventListeners + " Listner(s) listening to connection event");

// Fire the connection event 
eventEmitter.emit('connection');

eventListeners = require('events').EventEmitter.listenerCount(eventEmitter,'connection');
console.log(eventListeners + " Listner(s) listening to connection event");
```

## Buffer

Buffer provides instances to store raw data similar to an array of integers but corresponds to a raw memory allocation outside the V8 heap.

Buffer class is a global class and can be accessed in application without importing buffer module.

``` javascript
var buf = new Buffer(10);
var buf = new Buffer([10, 20, 30, 40, 50]);
var buf = new Buffer("Simply Easy Learning", "utf-8");

buf.length
buf.write(string[, offset][, length][, encoding])
buf.toString([encoding][, start][, end])
buf[index]
buf.copy(targetBuffer[, targetStart][, sourceStart][, sourceEnd])
```

## Stream

Streams are objects that let you read data from a source or write data to a destination in continous fashion.

Four types of streams.

- Readable - Stream which is used for read operation.
- Writable - Stream which is used for write operation.
- Duplex - Stream which can be used for both read and write operation.
- Transform - A type of duplex stream where the output is computed based on input.

``` javascript
var fs = require("fs");
var data = '';

// Create a readable stream
var readerStream = fs.createReadStream('input.txt');

// Set the encoding to be utf8. 
readerStream.setEncoding('UTF8');

// Handle stream events --> data, end, and error
readerStream.on('data', function(chunk) {
  data += chunk;});

readerStream.on('end',function(){
  console.log(data);});

readerStream.on('error', function(err){
  console.log(err.stack);});

console.log("Program Ended");
```

## Npm command

```
Mac install location
usr/local/bin/npm
usr/local/bin/node

Login
npm whoami
npm adduser

Start a project
npm init --scope=<username>

Install a module
npm install <modulename>

Listing dependencies
npm ls
```

## Links
- <https://quickleft.com/blog/creating-and-publishing-a-node-js-module/>
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide>
