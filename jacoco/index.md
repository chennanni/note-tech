---
layout: default
title: Jacoco
folder: jacoco
permalink: /archive/jacoco/
---

# Jacoco

## What is Jacoco

JaCoCo is a code coverage library for Java.

## How Jacoco count code coverage

Instructions (C0 Coverage)
<br>
The smallest unit JaCoCo counts are single [Java byte code](https://en.wikipedia.org/wiki/Java_bytecode_instruction_listings) instructions.

Branches (C1 Coverage)
<br>
JaCoCo also calculates branch coverage for all if and switch statements. This metric counts the total number of such branches in a method and determines the number of executed or missed branches.

[Jacoco coverage counter](http://eclemma.org/jacoco/trunk/doc/counters.html)

## How  to use Jacoco

Basically, you can use Jacoco as an ant task.

See [official](http://eclemma.org/jacoco/) source example in `jacoco-<version-number>/doc/examples/build.xml`.

Step 1: Import JaCoCo Ant tasks

~~~ ant
  <project name="ProjectName" default="default-task" xmlns:jacoco="antlib:org.jacoco.ant"> ... </project>

	<taskdef uri="antlib:org.jacoco.ant" resource="org/jacoco/ant/antlib.xml">
		<classpath path="../../../lib/jacocoant.jar" />
	</taskdef>
~~~

Step 2: Wrap test execution with the JaCoCo coverage task

~~~ ant
<target name="test" depends="compile">
  <jacoco:coverage destfile="${result.exec.file}">
    <java classname="org.jacoco.examples.parser.Main" fork="true">
      <classpath path="${result.classes.dir}" />
      <arg value="2 * 3 + 4"/>
      <arg value="2 + 3 * 4"/>
    </java>
  </jacoco:coverage>
</target>
~~~

Step 3: Create coverage report

~~~ ant
<target name="report" depends="test">
  <jacoco:report>

    <!-- This task needs the collected execution data and ... -->
    <executiondata>
      <file file="${result.exec.file}" />
    </executiondata>

    <!-- the class files and optional source files ... -->
    <structure name="JaCoCo Ant Example">
      <classfiles>
        <fileset dir="${result.classes.dir}" />
      </classfiles>
      <sourcefiles encoding="UTF-8">
        <fileset dir="${src.dir}" />
      </sourcefiles>
    </structure>

    <!-- to produce reports in different formats. -->
    <html destdir="${result.report.dir}" />
    <csv destfile="${result.report.dir}/report.csv" />
    <xml destfile="${result.report.dir}/report.xml" />
  </jacoco:report>
</target>
~~~

<http://eclemma.org/jacoco/trunk/doc/ant.html>
