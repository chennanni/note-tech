---
layout: default
title: Web Service - RESTful
folder: restful
permalink: /archive/web-service/restful/
---

# Web Service - RESTful

## What

Representational State Transfer （表现层状态转化）

an **architecture design** that define a stateless client where web services are treated like **resources** and can be accessed and identified by URL

RESTful架构，是目前流行的一种互联网软件架构
- 每一个URI代表一种资源
- 客户端和服务器之间，传递这种资源的某种表现层
- 客户端通过四个HTTP动词，对服务器端资源进行操作，实现"表现层状态转化"

<http://www.ruanyifeng.com/blog/2011/09/restful.html>

## REST v.s. SOAP

Example:
querying a phonebook application for the details of a given user using user's ID.

use REST

```
http://www.example.com/phonebook/UserDetails/12345
```

use Web services and SOAP

~~~ xml
<?xml version="1.0"?>
<soap:Envelope
xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 <soap:body pb="http://www.acme.com/phonebook">
  <pb:GetUserDetails>
   <pb:UserID>12345</pb:UserID>
  </pb:GetUserDetails>
 </soap:Body>
</soap:Envelope>
~~~

### Differences between SOAP WS and RESTful WS
- in SOAP, service provider registers their services to UDDI, then client looks into UDDI for certain services, and client use WSDL to access web services
	in RESTful, it simply use HTTP to make calls between client and server
- SOAP is stateful; RESTful is stateless
- SOAP use XML; RESTful use JSON, XML, CSV...
- SOAP support HTTP/s, TCP, UDP; RESTful support HTTP/s
- REST is much more lightweight and fast

### When to use REST?
- Limited bandwidth and resources
- Totally stateless operations
- Caching situations

### When to use SOAP?
- Asynchronous processing and invocation
- Formal contracts
- Stateful operations

## Server Response Format
- XML
- JSON
- CSV

~~~ xml
<parts-list>
 <part id="3322">
  <name>ACME Boomerang</name>
  <desc>
        Used by Coyote in <i>Zoom at the Top</i>, 1962
  </desc>
  <price currency="usd" quantity="1">17.32</price>
  <uri>http://www.acme.com/parts/3322</uri>
 </part>
 ...
</parts-list>
~~~

## Key components of a REST architecture

Resource-based
- Things vs. actions
- Nouns vs. verbs
- Identified by URIs

Representations
- how resources get manipulated
- part of the resource state (transfered between client and server)
- JSON or XML

Six Constrains
- Uniform Interface
  - HTTP verbs(GET, PUT, POST, DELETE)
  - URIs (resource name)
  - HTTP response (status, body)
- Stateless
  - server contains no client state
  - each request contains enough context to process the message
  - any session state is held on the client
- Client & Server
  - separation of concerns
- Cacheable
  - server response are cacheable (implicitly/explicitly/negotiated)
- Layered System
- Code on Demand

<http://www.restapitutorial.com/>

## POST v.s. PUT
- use POST to create, use PUT to update
- PUT is idempotent(same request repeating is OK), POST is not
- both unsafe

## Example

### JAX-RS with Jersey

e.g. [RESTfulDemo.zip](https://github.com/chennanni/note-tech/tree/master/web-service/restful/src), [RESTfulClient.zip](https://github.com/chennanni/note-tech/tree/master/web-service/restful/src)

Steps to Create RESTful Services:
- import jersey api using maven
- write business logic method
- add annotation `@Path("/XXX/{X})"`, `@Get`, `@Produces(MediaType.XXX)`

Steps to Consume RESTful Services:
- config -> client -> service ->
- service.path(...PATH...).accept(...MEDIA-TYPE...).get(...VALUE-TYPE...)

<http://www.java2blog.com/2013/04/create-restful-web-servicesjax-rs-using.html>

### REST with Spring

e.g. [ConsumeRestSpring-demo.zip](https://github.com/chennanni/note-tech/tree/master/web-service/restful/src), [BuildRestSpring-demo.zip](https://github.com/chennanni/note-tech/tree/master/web-service/restful/src)

Steps to Consume Spring RESTful Services
- create an POJO class and use jackson annotation to contain the data
- create a `RestTemplate` object -> use its `getForObject(url, class)` method
- <https://spring.io/guides/gs/consuming-rest/>

Steps to Build Spring RESTful Services
- Add dependencies using maven
- Create a resource representation class
- Create a resource controller using `@RestController` and `@RequestMapping`
- Start the service using `SpringBootApplication`
- <https://spring.io/guides/gs/rest-service/>

### Other Spring-REST Peojects

- TaskManagerAPP.zip [reference here](https://dzone.com/articles/crud-using-spring-mvc-40)
- [AccountManagementSystem.zip](https://github.com/chennanni/note-tech/tree/master/web-service/restful/src)

## Testing Tools
- POSTMAN(Chrome)
- SOAPUI

## Links
- [REST Tutorial](http://rest.elkstein.org/2008/02/what-is-rest.html)

