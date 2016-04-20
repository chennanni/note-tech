# Maven

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
**located in pox.xml**

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
