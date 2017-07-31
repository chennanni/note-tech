---
layout: default
title: SQL - Join
folder: join
permalink: /archive/plsql/join/
---


# SQL Joins

Oracle JOINS are used to retrieve data from multiple tables.

- Left Join: 以左表为基础，match右表的信息，match不到则为null
- Right Join：与Left Join正好相反
- Inner Join：只保留两个表相重合部分的信息

http://www.techonthenet.com/oracle/joins.php

## Left (Outer) Join

returns all rows from the left table (table1), with the matching rows in the right table (table2). 
The result is NULL in the right side when there is no match.

```
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name=table2.column_name;
```

## Right (Outer) Join

returns all rows from the right table (table2), with the matching rows in the left table (table1). 
The result is NULL in the left side when there is no match.

## Full (Outer) Join

combine the result of left join and right join

```
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name=table2.column_name;
```

## Inner Join

selects all rows from both tables as long as there is a match between the columns in both tables

```
SELECT column_name(s)
FROM table1
(INNER JOIN table2)
ON table1.column_name=table2.column_name;
```

[difference-between-a-full-join-and-an-inner-join](http://www.programmerinterview.com/index.php/database-sql/difference-between-a-full-join-and-an-inner-join/)

## Cross Join

produces the Cartesian product of two tables

## Union

The Oracle UNION operator is used to combine the result sets of 2 or more Oracle SELECT statements. 
It removes duplicate rows between the various SELECT statements.

Example

```
Table year_2001

item     |     profit
-----------------------
apple    |     100
banana   |     200

Table year_2002

item     |     profit
-----------------------
apple    |     200
orange   |     300

=>

SELECT * FROM year_2001
UNION
SELECT * FROM year_2002

=>

item     |     profit
-----------------------
apple    |     100
banana   |     200
apple    |     200
orange   |     300

```

## Left Join VS Inner Join Example

Employee (Table)

```
id     |     name     |     department_tag 
----------------------------------------------
01     |     Alice    |          a
02     |     Bobb     |          b
03     |     Cathy    |          c
04     |     David    |          
```

Department (Table)

```
tag      |     desc     
------------------------
a        |     SpaceX    
b        |     Tesla     
```

**Left Join**:

```
SELECT * FROM employee LEFT JOIN department
ON employee.department_tag = department.tag
```

Result:

```
id     |     name     |     department_tag     |     desc      
------------------------------------------------------------------
01     |     Alice    |          a             |      SpaceX 
02     |     Bobb     |          b             |      Tesla
03     |     Cathy    |          c             |
04     |     David    |                        |
```

**Inner Join**:

```
SELECT * FROM employee INNER JOIN department
ON employee.department_tag = department.tag
```

Result:

```
id     |     name     |     department_tag     |      desc      
------------------------------------------------------------------
01     |     Alice    |          a             |      SpaceX 
02     |     Bobb     |          b             |      Tesla
```
