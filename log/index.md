---
layout: default
title: Log
folder: log
permalink: /archive/log/
---

# Log

It is the process of writing log messages during the execution of a program to a central place.

## Java Logging API Level
- SEVERE (highest)
- WARNING
- INFO
- CONFIG
- FINE
- FINER
- FINEST
- ALL

LOGGER.setLevel(Level.INFO);

## Handler

The handler receives the log message from the logger and exports it to a certain target.
 - ConsoleHandler: Write the log message to console
 - FileHandler: Writes the log message to file

## Log4j (third party package)

e.g. of Log4j 2

~~~ java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Helloworld {
     static final Logger logger = LogManager.getLogger(Helloworld.class.getName());
     public static void main(String[] args) {
          logger.trace("Entering!");
          System.out.println("Hello World");
          logger.trace("Exiting");
          // logger.entry();
          // logger.exit();
          // logger.err("ERR");
     }
}
~~~
