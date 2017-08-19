---
layout: default
title: SQL - Syntax
folder: syntax
permalink: /archive/sql/syntax/
---

# SQL Syntax

## Intro

 * Structured Query Language
 * a computer language for storing, manipulating and retrieving data stored in relational database

## Products

 * Oracle Database
 * Microsoft SQL Server
 * MySQL (Oracle Corporation)
 * IBM DB2

## SQL Commands

DDL: Data Definition Language
 * CREATE
 * ALTER
 * DROP

DML: Data Manipulation Language
 * SELECT
 * INSERT
 * UPDATE
 * DELETE

DCL: Data Control Language
 * GRANT
 * REVOKE

## Compile

Load sql file

~~~ sql
@\path_of_SQL_file
~~~

## DDL

Create DB

~~~ sql
CREATE DATABASE dbname;
~~~

Create Table

~~~ sql
CREATE TABLE table_name
(
	 column_name1 data_type(size),
	 column_name2 data_type(size),
	 column_name3 data_type(size),
	 ....
);
~~~

ALTER

~~~ sql
ALTER TABLE table_name
ADD column_name datatype

ALTER TABLE table_name
DROP COLUMN column_name
~~~

DROP

~~~ sql
DROP INDEX index_name
DROP TABLE table_name
DROP DATABASE database_name
TRUNCATE TABLE table_name
~~~

## DML

SELECT & WHERE

~~~ sql
SELECT column_name,column_name
FROM table_name
WHERE column_name operator value;
~~~

ORDER BY

~~~ sql
SELECT column_name, column_name
FROM table_name
ORDER BY column_name ASC|DESC, column_name ASC|DESC;
~~~

INSERT INTO

~~~ sql
INSERT INTO table_name (column1,column2,column3,...)
VALUES (value1,value2,value3,...);
~~~

UPDATE

~~~ sql
UPDATE table_name
SET column1=value1,column2=value2,...
WHERE some_column=some_value;
~~~

DELETE

~~~ sql
DELETE FROM table_name
WHERE some_column=some_value;

DELETE FROM table_name;
DELETE * FROM table_name;
~~~

## Conditions

AND & OR

~~~ sql
SELECT * FROM Customers
WHERE Country='Germany'
AND (City='Berlin' OR City='München');
~~~

LIKE

~~~ sql
SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern;
(pattern e.g. 's%')
~~~

IN

~~~ sql
specify multiple values in a WHERE clause
SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1,value2,...);
~~~

BETWEEN

~~~ sql
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;
~~~

WildCard Characters

~~~ sql
%
_
[cahrlist]
[!charlist]
~~~

JOIN

~~~ sql
LEFT/RIGHT/INNER/CROSS JOIN
combine one table with another

SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name=table2.column_name;
~~~

Constraints

~~~ sql
NOT NULL
UNIQUE
PRIMARY KEY
FOREIGN KEY
CHECK
DEFAULT

--Create Table + Constraint
CREATE TABLE table_name
(column_name1 data_type(size) constraint_name,
 column_name2 data_type(size) constraint_name,
 column_name3 data_type(size) constraint_name,
 ....);

--Create a constraint on the given column
ALTER TABLE Persons
ADD UNIQUE (P_Id)

--Allow naming of a UNIQUE constraint
ALTER TABLE Persons
ADD CONSTRAINT uc_PersonID UNIQUE (P_Id,LastName)
~~~

## Others

BACKUP

~~~ sql
rollback;
commit;
truncate table table_name; (can't be roll back)
~~~

Operators

~~~ sql
=, <, >, <=, >=, <>
BETWEEN
LIKE
IN, NOT IN
IS NULL, IS NOT NULL
~~~

Aggregate Functions

~~~ sql
AVG()
COUNT()
FIRST()
LAST()
MAX()
MIN()
SUM()
~~~

Scalar functions

~~~ sql
UCASE()
LCASE()
MID()
LEN()
ROUND()
NOW()
FORMAT()
~~~

## Links

- [Getting Started with Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/getting-started-155046.html)
