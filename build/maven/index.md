---
layout: default
title: Build - Maven
folder: maven
permalink: /archive/build/maven/
---

# Build - Maven

## What is Maven

Maven is a **build** automation tool used primarily for Java projects.

![maven_path](img/maven_path.png)

## Feature
- **Making the build process easy**
- **Providing a uniform build system**
- Providing quality project information
- Providing guidelines for best practices development
- Allowing transparent migration to new features

## Add Dependencies
**located in pom.xml**

In GUI, there's a 'ADD' Button.

OR

Hardcode add

``` xml
<dependency>
	  <groupId>org.springframework</groupId>
	  <artifactId>spring-core</artifactId>
	  <version>4.1.6.RELEASE</version>
</dependency>
```

## Goal and Phase

Build LifeCycle
- validate: validate the project is correct and all necessary information is available
- compile: compile the source code of the project
- test: test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed
- package: take the compiled code and package it in its distributable format, such as a JAR.
- verify: run any checks on results of integration tests to ensure quality criteria are met
- install: install the package into the local repository, for use as a dependency in other projects locally
- deploy: done in the build environment, copies the final package to the remote repository for sharing with other developers and projects.

一种实践是，在本地执行`package`，打好包，手动上传到服务器上，再启动程序。

- (https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html)

## Plugin

作用：在整个build的lifeCycle之间，插入一些job，做一些其它的工作。

以下示例，在`package`的过程中，加入了一个`maven-assembly-plugin`，这个插件做的事情是，根据`package.xml`中的描述，额外地做一些打包工作。

~~~ xml
<build>
	...
	<plugins>
		<plugin>
			<artifactId>maven-assembly-plugin</artifactId>
			<version>2.2-beta-4</version>
			<executions>
			    <execution>
				<id>make-assembly</id>
				<phase>package</phase>
				<goals>
				    <goal>attached</goal>
				</goals>
			    </execution>
			</executions>
			<configuration>
			    <descriptors>
				<descriptor>src/main/assembly/package.xml</descriptor>
			    </descriptors>
			</configuration>
		</plugin>
	<plugins>
</build>
~~~

- (http://maven.apache.org/plugins/maven-assembly-plugin/)

## Dependency

依赖冲突
- 短路优先，先声明优先

- [Maven依赖传递、依赖传递排除、依赖冲突](https://www.cnblogs.com/ygj0930/p/6628429.html)
- [Maven依赖版本冲突的分析及解决小结](https://www.cnblogs.com/godtrue/p/6220512.html)

## Cheat Cheet

```
check version
	mvn --version
create a project
	mvn archetype:generate
build the project
	mvn package
run
	java -cp target/***.jar classpath.ClassName
	(if you use other packages, you need to set their cp in the cmd)
run Java main from Maven
	mvn exec:java -Dexec.mainClass="com.vineetmanohar.module.Main"  
	mvn exec:java -Dexec.mainClass="com.vineetmanohar.module.Main" -Dexec.args="arg0 arg1 arg2"
```

## Links
- [Maven in 5 Minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)
