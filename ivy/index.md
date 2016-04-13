---
layout: default
title: Ivy
folder: ivy
permalink: /archive/ivy/
---

# Ivy

Ivy is a tool for managing (recording, tracking, resolving and reporting) project dependencies.

## Setup

Download
<br>
unpack zip file -> copy the jar file into ANT_HOME/lib

Run
<br>
If you use ant 1.6.0 or superior, you can then simply:
go to the `src/example/hello-ivy` dir and run `ant`
(if the build is successful, you have successfully installed Ivy!)

## Ant-Ivy Tasks

- Resolve: Resolves the dependencies described in ivy.xml and places the resolved dependencies in ivy cache.
- Retrieve: Copies the resolved dependencies from cache to a specified directory.
- Install: Installs a module to a specified repository.
- Publish: Publish a module to a repository.

<http://www.codetab.org/apache-ivy-tutorial/apache-ivy-ant-tasks/>

## Repository Management

- Local
- Shared
- Public

<http://ant.apache.org/ivy/history/latest-milestone/tutorial/defaultconf.html>

## Dependency Management

Ivy uses the maven 2 repository by default.

## Using Ivy Module Configuration

Have different configurations for different situations.

In ivy.xml, specify what kind of build you want to use: only api jar, or only company jar or company jar + third party jars.

~~~ xml
<ivy-module version="1.0">
    <info organisation="org.apache" module="myapp"/>

    <configurations>
      <conf name="build" visibility="private" description="compilation only need api jar" />
    	<conf name="noexternaljar" description="use only company jar" />
    	<conf name="withexternaljar" description="use company jar and third party jars" />    
    </configurations>

    <dependencies>
        <dependency org="org.apache" name="filter-framework" rev="latest.integration" 
            conf="build->api; noexternaljar->homemade-impl; withexternaljar->cc-impl"/>
    </dependencies>
</ivy-module>
~~~

In ant resolve task, give what `conf` you want to use.

~~~
<target name="resolve" description="--> retreive dependencies with ivy">
    <ivy:retrieve pattern="${ivy.lib.dir}/[conf]/[artifact].[ext]"/>
</target>
~~~

<http://ant.apache.org/ivy/history/latest-milestone/tutorial/conf.html>

## Situations

- One Project, default local repository (download from m2)
- One Project, local repository (external jars)
- One Project, local (jars) + public repository (cloud repo)
- Multiple Project dependency

## Links

- <http://www.codetab.org/apache-ivy-tutorial/>
- <http://ant.apache.org/ivy/history/latest-milestone/tutorial.html>
