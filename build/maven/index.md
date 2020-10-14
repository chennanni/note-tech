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

## Features

- **Making the build process easy**
- **Providing a uniform build system**
- Providing quality project information
- Providing guidelines for best practices development
- Allowing transparent migration to new features

## Concept

### Repository

- Local Repository: a folder location on your machine.
- Central Repository: This repository is managed by Maven community.
- Remote Repository: user defined, see below example.

~~~ xml
<project>
   <repositories>
      <repository>
         <id>companyname.lib1</id>
         <url>http://download.companyname.org/maven2/lib1</url>
      </repository>
   </repositories>
</project>
~~~

Search sequence: local repository -> central repository -> remote repository

- [https://www.tutorialspoint.com/maven/maven_repositories.htm](https://www.tutorialspoint.com/maven/maven_repositories.htm)

### Phase

Build LifeCycle
- **validate**: validate the project is correct and all necessary information is available
- **compile**: compile the source code of the project
- **test**: test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed
- **package**: take the compiled code and package it in its distributable format, such as a JAR.
- **verify**: run any checks on results of integration tests to ensure quality criteria are met
- **install**: install the package into the local repository, for use as a dependency in other projects locally
- **deploy**: done in the build environment, copies the final package to the remote repository for sharing with other developers and projects.

一种实践是，在本地执行`package`，打好包，手动上传到服务器上，再启动程序。

- [https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html)

## Build

### Add Dependency

in `pom.xml`, add:

``` xml
<dependencies>
	...
	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-core</artifactId>
		<version>4.1.6.RELEASE</version>
	</dependency>
</dependencies>
```

### Plugin

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

- [http://maven.apache.org/plugins/maven-assembly-plugin](http://maven.apache.org/plugins/maven-assembly-plugin)

## Dependency Conflict

问题：项目中，A有两个dependency，但是C的version在两个地方配置得不一样，如下。那么，实际生效的C的version是哪个呢？

~~~
A -> B -> C (v1)
A -> C (v2)
~~~

依赖冲突解决：

- 短路优先；在上例中，C是v2。
- （相同路径的情况下）先声明优先。

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
