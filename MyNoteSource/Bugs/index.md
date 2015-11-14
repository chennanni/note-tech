---
layout: default
title: Bugs
permalink: /bugs/
---

# Bugs

## Cannot change version of project facet Dynamic Web Module to 3.0
Solution 1: edit the web.xml file

~~~ xml
<web-app xmlns="http://java.sun.com/xml/ns/javaee"
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    			xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
          		http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
    			version="3.0">
	...
</web-app>
~~~

Solution 2: edit the project facet configuration file

`setting` ->

`org.eclipse.wst.common.project.facet.core.xml` ->

`<installed facet="jst.web" version="3.0"/>` ->

maven update project

<http://stackoverflow.com/questions/18122336/cannot-change-version-of-project-facet-dynamic-web-module-to-3-0>

## Hibernate can't read object
Problem:
In the `Person` Class, there's an attribute which is `address`, they are `many to many` relationship and the fetch type is `lazy loading`.
So when I get `person` from DB and try to access `address`, it faided.

Solution:
instead of calling `person.address`, i write some other queries to fetch `address`.

## Http Code 406, accpet return type don't match
Detect: Missing Jackson library

request -> controller -> return type is not json

have

~~~ xml
<dependency>
	<groupId>org.codehaus.jackson</groupId>
	<artifactId>jackson-core-asl</artifactId>
	<version>1.9.13</version>
</dependency>
~~~

miss

~~~ xml
<dependency>
	<groupId>com.fasterxml.jackson.core</groupId>
	<artifactId>jackson-core</artifactId>
	<version>2.1.2</version>
</dependency>
<dependency>
	<groupId>com.fasterxml.jackson.core</groupId>
	<artifactId>jackson-databind</artifactId>
	<version>2.1.2</version>
</dependency>
~~~
