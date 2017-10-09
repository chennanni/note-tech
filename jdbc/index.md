---
layout: default
title: JDBC
folder: jdbc
permalink: /archive/jdbc/
---

# JDBC

Java Database Connectivity

It is an API for the connection between Java programming language and Databases.

## Main Tasks

- Making a connection to a database.
- Creating SQL or MySQL statements.
- Executing SQL or MySQL queries in the database.
- Viewing & Modifying the resulting records.

## Architecture

![jdbc_architecture](img/jdbc_architecture.png)

JDBC API: This provides the application-to-JDBC Manager connection.

JDBC Driver API: This supports the JDBC Manager-to-Driver Connection.

### JDBC Drivers

A JDBC driver is a software component enabling a Java application to interact with a database.

Type 1 Deiver: JDBC-ODBC Bridge (JDK)

![jdbc_odbc_bridge](img/jdbc_odbc_bridge.png)

.class(byte code)  ->  JDBC  ->  ODBC  -> DB

## API

Packages
- java.sql
- javax.sql

Common JDBC Components (Objects)

Driver
- This interface handles the communications with the database server. You will interact directly with Driver objects very rarely. Instead, you use DriverManager objects, which manages objects of this type.

DriverManager
- `Connection getConnection(String, String, String)`

Connection
- This interface with all methods for contacting a database. The connection object represents communication context, i.e., all communication with database is through connection object only.
- `Statement createStatement()`
- `PreparedStatement prepareStatement()`
- `CallableStatement prepareCall()`
- `commit()`
- `rollback()`

Statement
- You use objects created from this interface to submit the SQL statements to the database. Some derived interfaces accept parameters in addition to executing stored procedures.
- `Statement`
 - boolean execute (String SQL)
 - int executeUpdate (String SQL)
 - ResultSet executeQuery (String SQL)
 - addBatch()
 - executeBatch()
 - clearBatch()
- `PreparedStatement`
 - setXXX(int index, `<T>` value)
- `CallableStatement`
 - setXXX(...)
 - registerOutParameter(...)

ResultSet
- These objects hold data retrieved from a database after you execute an SQL query using Statement objects. It acts as an iterator to allow you to move through its data.
- `public boolean next() throws SQLException`
- `public int getInt(String columnName) throws SQLException`
- `public void updateString(int columnIndex, String s) throws SQLException`
- `public void updateRow()`

SQLException
- This class handles any errors that occur in a database application.

## Connect to Database Steps

Step 1
- Add ojdbc jar
- Import jdbc packages

Step 2
- Register jdbc driver
- Open a connection
- Execute a query
- Extract data from result set

Step 3
- Clean up the environment

<http://www.tutorialspoint.com/jdbc/jdbc-sample-code.htm>

## Links

- [JDBC Tutorial](http://www.tutorialspoint.com/jdbc/jdbc-introduction.htm)
- [Oracle Database 11g Express Edition Getting Started Guide](http://docs.oracle.com/cd/E17781_01/admin.112/e18585/toc.htm)
