---
layout: default
title: Build
folder: basic
permalink: /archive/build/basic
---

# Build

## What is "Build"

- Assemble the correct sources depending on (Operating System/Hardware/Application Requirements)
- **Compile** sources into binaries
- Perform quality assurance on sources/binaries
- **Package** sources/binaries

简单来说，build 就是把一系列代码变成可执行的（二进制）文件。

## Dependency Management

- File dependency management: if `foo.java` if newer than `foo.class`, compile `foo.java`
- Library dependency management

一开始，Dependency Management主要focus在文件版本管理上；慢慢地，随着项目越来越复杂，引入的包越来越多，重心放在了lib管理上。

## Build Tools

- GNU Make
- [[ant]]
- [[maven]]
- [[ivy]]
- Rake
- Buildr
- Gradle
- [[sbt]]

## Tools Development

### Make

上世纪7，80年代，主流是使用`make`，用来编译各种语言的代码，当然主要是C语言。

### Ant

慢慢地，Java语言越来越流行，但是，为C语言设计的`make`和Java兼容性不是很好。于是，一款专门为Java设计的Build工具出现了，就是`Ant`。
`Ant`参考了大量`make`的设计，所以程序员们切换过来很方便。它使用了XML格式，一般项目的编译脚本被命名为`build.xml`。
同时，它给开发人员留下了非常大的自由度 flexbility 。比如，程序员们需要手动写每一个操作的编译脚本，如下：

~~~ xml
<target name="jar" depends="compile">
    <mkdir dir="jar" />
    <jar destfile="jar/HelloWorld.jar" basedir="classes">
        <manifest>
            <attribute name="Main-Class" 
              value="antExample.HelloWorld" />
        </manifest>
    </jar>
</target>
~~~

### Ivy

项目越来越大，也越来越模块化，需要引用到大量地其它类库，Dependency Management变得越来越重要。

所以，Ivy诞生了，它是为了配合Ant，使得Java程序能够顺利地build。

### Maven

Ant + Ivy 是一个很流行组合，但是也有一个问题：Ant有点繁琐 / 难用。
新建一个项目，我需要写一大堆的 build 脚本，而且可能都是从其它项目 copy/paste 过来的。
有没有更“偷懒”的工具呢？

Maven出现了，它的核心思想是：

- 减少程序员的自由度 flexbility，使用convension，（在背后 maven 帮你把一大堆的 build 脚本写好了），你只要遵循这些 convension 直接用就好了。
- Maven = Ant + Ivy

所以，我们配置一个Maven项目，只要写`pom.xml`就行了，而pom文件的主要内容是要引入哪些dependency。
我们不需要再自己写一个名为`jar`的`target`，而是直接使用`maven package`命令就可以了。

程序员们做出的牺牲是，需要遵循 maven 项目的 convension。比如，项目的目录结构，如下：

~~~
+---src
|   +---main
|   |   +---java
|   |   |   \---com
|   |   |       \---learn
|   |   |           \---maven
|   |   |                   HelloWorld.java
|   |   |                   
|   |   \---resources
|   \---test
|       +---java
|       \---resources
~~~

（注：当然，现在随着框架越来越多，dependency越来越多，Maven的pom文件也非常长，所以Spring Boot出现了，技术就是这样不断演进的。）

### Gradle

Gradle是一个和Maven“差不多”的build工具。

从设计上，它希望将build变得更加简单，从而替代Maven，但是到目前为止，好像还没有成功。

有两个关键点：

- 它不用XML了，而是使用了一种新的语言 Groovy / Kotlin （个人感觉这是没有能够PK掉Maven的一个很重要的因素）
- 它本身不内置很多功能，而是采用plugin的形式，需要什么功能，直接include这个plugin就行，可插拔式编程

一个`build.gradle`的例子如下：

~~~
apply plugin: 'java'
 
repositories {
    mavenCentral()
}
 
jar {
    baseName = 'gradleExample'
    version = '0.0.1-SNAPSHOT'
}
 
dependencies {
    testImplementation 'junit:junit:4.12'
}
~~~

参考 -> <https://www.baeldung.com/ant-maven-gradle>
