## Joins

Oracle JOINS are used to retrieve data from multiple tables.

http://www.techonthenet.com/oracle/joins.php

### Left (Outer) Join

returns all rows from the left table (table1), with the matching rows in the right table (table2). 
The result is NULL in the right side when there is no match.

```
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name=table2.column_name;
```

### Right (Outer) Join

returns all rows from the right table (table2), with the matching rows in the left table (table1). 
The result is NULL in the left side when there is no match.

### Full (Outer) Join

combine the result of left join and right join

```
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name=table2.column_name;
```

### Inner Join

selects all rows from both tables as long as there is a match between the columns in both tables

```
SELECT column_name(s)
FROM table1
(INNER JOIN table2)
ON table1.column_name=table2.column_name;
```

[difference-between-a-full-join-and-an-inner-join](http://www.programmerinterview.com/index.php/database-sql/difference-between-a-full-join-and-an-inner-join/)

### Cross Join

produces the Cartesian product of two tables

### Union

The Oracle UNION operator is used to combine the result sets of 2 or more Oracle SELECT statements. 
It removes duplicate rows between the various SELECT statements.
