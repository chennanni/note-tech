---
layout: default
title: Log
folder: log
permalink: /archive/log/
---

# Log

It is the process of writing log messages during the execution of a program to a central place.

## Log Level

Usually the log level are as below, low -> high:
- Debug
- Info
- Warn
- Error
- Fatal

## Example

在下例中，在property文件里面定义了一个名为testlog的appender，并指定其级别为INFO，最后的输出是，除了Debug的其他行。

~~~ java
// log4j
import org.apache.log4j.Logger;
public class Main {
    static Logger log = Logger.getLogger("FILE");
    public static void main(String[] args) {
        log.debug("Debug");
        log.info("Info");
        log.warn("Warn");
        log.error("Error");
        log.fatal("Fatal");
    }
}
~~~

log4j.properties

~~~
# Define the root logger with appender file
log = C:/Some/Path/my.test.log
log4j.rootLogger = INFO, testlog

# Define the file appender
log4j.appender.testlog=org.apache.log4j.FileAppender
log4j.appender.testlog.File=${log}/log.out

# Define the layout for file appender
log4j.appender.testlog.layout=org.apache.log4j.PatternLayout
log4j.appender.testlog.layout.conversionPattern=%m%n
~~~

## Link

- [日志级别的选择：Debug、Info、Warn、Error还是Fatal？](https://www.cnblogs.com/shwen99/archive/2007/12/29/1019853.html)
- [log4j的日志级别与使用](https://blog.csdn.net/rumidavid/article/details/80680932)
