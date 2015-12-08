---
layout: default
title: Ant
folder: ant
permalink: /archive/ant/
---

# ANT

## What is Apache ANT

Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.

The main known usage of Ant is the build of Java applications.

## Usage example

<http://ant.apache.org/manual/tutorial-HelloWorldWithAnt.html>

~~~
<target name="compile">
    <mkdir dir="${classes.dir}"/>
    <javac srcdir="${src.dir}" destdir="${classes.dir}" classpathref="classpath"/>
    <copy todir="${classes.dir}">
      <fileset dir="${src.dir}" excludes="**/*.java"/>
    </copy>
</target>

<target name="jar" depends="compile">
    <mkdir dir="${jar.dir}"/>
    <jar destfile="${jar.dir}/${ant.project.name}.jar" basedir="${classes.dir}">
        <manifest>
            <attribute name="Main-Class" value="${main-class}"/>
        </manifest>
    </jar>
</target>

<target name="run" depends="jar">
  <java fork="true" classname="${main-class}">
    <classpath>
        <path refid="classpath"/>
        <path location="${jar.dir}/${ant.project.name}.jar"/>
    </classpath>
  </java>
</target>
~~~

## Links
- <https://ant.apache.org/manual/using.html>
- <http://ant.apache.org/manual/tutorial-HelloWorldWithAnt.html>
- <https://ant.apache.org/manual/tutorial-writing-tasks.html>
