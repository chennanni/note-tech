package org.learn.web;
import javax.jws.WebService;  

@WebService(endpointInterface="org.learn.web.HelloWorld")  
public class HelloWorldImpl implements HelloWorld{  
  
	public String helloWorld(String name) {  
		return "Hello world from " + name;  
	}  
  
}