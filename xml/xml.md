---
layout: default
title: XML
folder: xml
permalink: /archive/xml/
---

# XML

## What?
EXtensible Markup Language
describe data

## Features

- self-descriptive
- XML separates data from HTML
- XML simplifies data sharing
- XML simplifies data transport
- XML simplifies platform changes

## Tree Structure

~~~ xml
<root>
  <child>
    <subchild>.....</subchild>
  </child>
</root>
~~~

## Syntax
Must have root element
Elements must have a closing tag
Elements Must be properly nested
Attribute values must be quoted
Tags are case Sensitive
XML does not truncate multiple white-spaces in a document

## Comments

~~~
<!-- This is a comment -->
~~~

## Entity References

~~~
< ----- &lt;
> ----- &gt;
& ----- &amp;
' ------ &apos;
" ----- &quot;
~~~

## Element
an element can contains:

- text
- attributes
- other elements

## Attribute
metadata should be stored as attribute
data itself should be stored as element

## Namespace

~~~
xmlns="namespaceURI"
~~~

## Encoding

~~~ xml
<?xml version="1.0" encoding="UTF-8"?>
~~~

## XPath
XPath uses path expressions to **select nodes or node-sets in an XML document**.

~~~
selects all the title nodes with a price higher than 35:

/bookstore/book[price>35]/title
~~~

## XSLT
EXtensible Stylesheet Language Transformation

used to manipulate and transform XML documents to HTML with CSS

Example
- <http://www.w3schools.com/xsl/default.asp>
- <http://www.tizag.com/xmlTutorial/xslttutorial.php>

## XQuery

XQuery is designed to query XML data

Example

~~~
doc("books.xml")/bookstore/book[price<30]
~~~
