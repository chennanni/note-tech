---
layout: default
title: AJAX
permalink: /ajax/
---

#AJAX
AJAX = Asynchronous JavaScript and XML

AJAX allows web pages to be updated **asynchronously** by exchanging small amounts of data with the server behind the scenes.
This means that it is possible to update parts of a web page, without reloading the whole page.

Steps:

1. Create XMLHttpRequest Object
2. Get a Response from a Server
3. Send a Request to a Server

## XMLHttpRequest Object
~~~ JavaScript
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
~~~

## Send a Request to a Server
~~~ Javascript
xmlhttp.open("GET","ajax_info.txt",true);
xmlhttp.send();
~~~

## Get a Response from a Server
responseText <br/>
responseXML

~~~
document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
~~~

## AJAX with Javascript (Example)
~~~ html
<!DOCTYPE html>
<html>
<head>
<script>
function loadXMLDoc() {
	// 1. Create XMLHttpRequest Object
	var xmlhttp;
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}

	// 2. Get a Response from a Server
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
			document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
		}
	}

	// 3. Send a Request to a Server
	xmlhttp.open("GET","ajax_info.txt",true);
	xmlhttp.send();
}
</script>
</head>
<body>

<div id="myDiv"><h2>Let AJAX change this text</h2></div>
<button type="button" onclick="loadXMLDoc()">Change Content</button>

</body>
</html>
~~~

## AJAX with JQuery
TODO

## AJAX with AngularJS
TODO
