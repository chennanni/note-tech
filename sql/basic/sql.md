---
layout: default
title: SQL - Basic
folder: basic
permalink: /archive/sql/basic/
---


# SQL

## Section Structure

EXAMPLE 1

~~~ sql
DECLARE
      /* Declarative section: variables, types, and local subprograms. */
BEGIN
      /* Executable section: procedural and SQL statements go here. */
      /* This is the only section of the block that is required. */
EXCEPTION
      /* Exception handling section: error handling statements go here. */
END;
~~~

EXAMPLE 2

~~~ sql
DECLARE
   message  varchar2(20):= 'Hello, World!';
BEGIN
   dbms_output.put_line(message);
END;
/
~~~

## Variable Declaration

Syntax

`variable_name [CONSTANT]` `datatype [NOT NULL]` `[:= | DEFAULT initial_value]`

Example 1

~~~ sql
price NUMBER;
sales NUMBER(10, 2);
name VARCHAR2(25);
beerTuple Beers%ROWTYPE;
address varchar2(100);
~~~

Example 2

~~~ sql
DECLARE
    a NUMBER := 3;
BEGIN
    a := a + 1;
END;
.
run;
~~~

##  Control Flow

IF

~~~ sql
IF <condition_1> THEN ...
ELSIF <condition_2> THEN ...
... ...
ELSIF <condition_n> THEN ...
ELSE ...
END IF;
~~~

LOOP

~~~ sql
LOOP
    <loop_body> /* A list of statements. */
END LOOP;
~~~

WHILE

~~~ sql
WHILE <condition> LOOP
    <loop_body>
END LOOP;
~~~

FOR

~~~ sql
FOR <var> IN <start>..<finish> LOOP
    <loop_body>
END LOOP;
~~~

## Procedures

A stored procedure is a named PL/SQL block which performs one or more specific task.

Example of creating a procedure

~~~ sql
CREATE [OR REPLACE] PROCEDURE procedure_name
[(parameter_name [IN | OUT | IN OUT] type [, ...])]
{IS | AS}
BEGIN
  < procedure_body >
END procedure_name;
/
~~~

## Functions

These subprograms return a single value, mainly used to compute and return a value.

Example

~~~ sql
CREATE OR REPLACE FUNCTION employer_details_func
   RETURN VARCHAR(20);
IS
   emp_name VARCHAR(20);
BEGIN
	 SELECT first_name INTO emp_name
	 FROM emp_tbl WHERE empID = '100';
	 RETURN emp_name;
END;
/
~~~

## Cursors

What: A cursor is a temporary work area created in the system memory when a SQL statement is executed. 
A cursor contains information on a select statement and the rows of data accessed by it. (to be simple, it is **SELECT RESULT**)

General form of using an explicit cursor

~~~ sql
DECLARE
	 variables;
	 records;
	 create a cursor;
BEGIN
	OPEN cursor;
	FETCH cursor;
		process the records;
	CLOSE cursor;
END;
~~~

**Type**

- implicit cursor: An implicit cursor is one created "automatically" for you by Oracle when you execute a query.
- explicit cursor: An explicit cursor is one you create yourself.

**Attribute**

~~~ sql
%FOUND
%NOTFOUND
%ISOPEN
%ROWCOUNT
~~~

Any SQL cursor attribute will be accessed as sql%attribute_name

## Triggers

A trigger is a pl/sql block structure which is fired when a DML statements like Insert, Delete, Update is executed on a database table.

Example of creating a trigger: when there's a price change, put the old record into the history table

~~~ sql
CREATE or REPLACE TRIGGER price_history_trigger
BEFORE UPDATE OF unit_price
ON product
FOR EACH ROW
BEGIN
INSERT INTO product_price_history
VALUES
(:old.product_id,
 :old.product_name,
 :old.supplier_name,
 :old.unit_price);
END;
/
~~~

## Database Relationship

- One to One
- One to Many
- Many to Many

http://code.tutsplus.com/articles/sql-for-beginners-part-3-database-relationships--net-8561

## Others
- [[join]]
- [[query]]
- [[syntax]]

## Links

- [plsql simple tutorial](http://plsql-tutorial.com/)
- [Sams Teach Yourself SQL in 24 Hours](http://www.informit.com/library/library.aspx?b=STY_Sql_24hours)
- [plsql good reference](http://www.techonthenet.com/oracle/index.php)
