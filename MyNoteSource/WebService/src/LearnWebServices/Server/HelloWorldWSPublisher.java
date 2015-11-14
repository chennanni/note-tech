package org.learn.web;
import javax.xml.ws.Endpoint;  

public class HelloWorldWSPublisher {  
	public static void main(String[] args) {  
		Endpoint.publish("http://localhost:2345/WS/HelloWorld",new HelloWorldImpl());
		System.out.println("Published");
	}
}