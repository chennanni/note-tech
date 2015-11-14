package org.learn.web;

public class Test {
    public static void main(String[] args) {  
        
        HelloWorldImplService helloWorldService = new HelloWorldImplService();  
        HelloWorld helloWorld = helloWorldService.getHelloWorldImplPort();  
        System.out.println(helloWorld.helloWorld("ME!"));  
    }  
}
