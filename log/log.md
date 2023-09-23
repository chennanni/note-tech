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

## 问题解决 - Log4j没有配置

Error: `log4j:WARN No appenders could be found for logger`

Fix：将`log4j.perperties`文件放到

~~~
src/
~~~

OR

~~~
src/main/resources/
src/test/resources/
~~~

文件内容如下：直接输出log到控制台

~~~
log4j.rootLogger=info, stdout

log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d %p [%c] - %m%n

log4j.appender.logfile=org.apache.log4j.FileAppender
log4j.appender.logfile.File=target/spring.log
log4j.appender.logfile.layout=org.apache.log4j.PatternLayout
log4j.appender.logfile.layout.ConversionPattern=%d %p [%c] - %m%n
~~~

参考 -> log4j问题解决 <https://blog.csdn.net/m0_37874657/article/details/80536086>

## Link

- [日志级别的选择：Debug、Info、Warn、Error还是Fatal？](https://www.cnblogs.com/shwen99/archive/2007/12/29/1019853.html)
- [log4j的日志级别与使用](https://blog.csdn.net/rumidavid/article/details/80680932)
