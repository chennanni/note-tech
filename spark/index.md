# Spark

## Intro

Why Spark?
- Fast
- Eazy to code

Hadoop v.s. Spark
- Hadoop usually works with other framework like Stream, Hive, HBase, etc to perform different tasks.
- Spark includes everything in one, is a unified plaform for Big Data.

[hadoop_family]

[spark_platform]

Histroy of Spark

2016 -> Spark 2.0+ 

[spark_history]

## Get Started

Install

- unzip
- set up
  - set up Spark bin to PATH
  - set up SPARK_HOME
  - set up log level (optional)
- fix a bug of SPARK-2356
  - download winutils.exe and put under bin
  - set up HADOOP_HOME

Spark Language

- Scala
- Java
- Python
- R

Hello world

Read a text file and output the first line

~~~
val textFile = sc.textFile("file:///spark-3.0.0-bin-hadoop2.7/README.md")
textFile.first
~~~

=> `res6: String = # Apache Spark`

Count the word apperence in the file

~~~
val tokenizedFileData = textFile.flatMap(line=>line.split(" "))
val countPrep = tokenizedFileData.map(word=>(word, 1))
val counts = countPrep.reduceByKey((accumValue, newValue)=>accumValue + newValue)
val sortedCounts = counts.sortBy(kvPair=>kvPair._2, false)
sortedCounts.saveAsTextFile("file:///ReadMeWordCount")
~~~

=>

~~~
(,73)
(the,23)
(to,16)
(Spark,14)
(for,12)
(##,9)
(a,9)
(and,9)
(is,7)
(run,7)
(on,7)
(can,6)
(also,5)
(in,5)
(of,5)
(Please,4)
(*,4)
(if,4)
(including,4)
(an,4)
(you,4)
(documentation,3)
(example,3)
(build,3)
(how,3)
~~~

Or directly call the API

~~~
tokenizedFileData.countByValue
~~~
