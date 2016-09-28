---
layout: default
title: Java - Networking
folder: networking
permalink: /archive/java/networking/
---

# Java Networking

- TCP/IP Socket 
- UDP Socket
- URL(HTTP) Connection

## Protocals

TCP - Transmission Control Protocol

- convert data into packets or vise versa
- each packet contains stream of data in bytes
- ensure the connection between parties

IP - Internet Protocal

- identify the destination where the packet need to be sent

UDP - User Datagram Packet

- using UDP there is no connection between the client and server
- there's no guarantee the message is arrived or received by the other party

- HTTP(Hypertext Transfer Protocol)
- FTP(File Transfer Protocol)
- SMTP(Simple Mail Transfer Protocol)

## TCP/IP Socket Example

`Socket` <=> `ServerSocket` <=> `Socket`

### Classes

```
ServerSocket
     - Socket accept()

Socket
     - InputStream getInputStream()
     - OutputStream getOutputStream()

InetAddress
     - InetAddress getLocalHost()
     - InetAddress getByName(String)

java.io.DataOutputStream
     - void writeUTF()
	 
java.io.DataInputStream
     - String readUTF()
```

### Steps

**Server**

- create and start ServerSocket, specifying which port to use
- (wait for client connection, connection complete)
- start communication

~~~ java
import java.net.*;
import java.io.*;

try {
	ServerSocket serverSocket = new ServerSocket(port);
	Socket socket = serverSocket.accept();
	
	// Server receive data from Client
	DataInputStream in = new DataInputStream(socket.getInputStream());
	System.out.println(in.readUTF());
	
	// Server send data to Client
	DataOutputStream out = new DataOutputStream(socket.getOutputStream());
	out.writeUTF("server -> client: some output data");
	
	server.close();
} catch (IOException e1 || SocketTimeoutException e2) {...}
~~~

**Client**

- create Socket, specifying server's name and port -> then it will keep trying to connect the Server
- (Server get client's Socket object, establish connection)
- start communication

~~~ java
import java.net.*;
import java.io.*;

try {
	Socket socket = new Socket(serverName, port);
	
	// Client send data to Server
	DataOutputStream out = new DataOutputStream(socket.getOutputStream());
	out.writeUTF("client -> server: some output data");
	
	// Client receive data from Server
	DataInputStream in = new DataInputStream(socket.getInputStream());
	System.out.println(in.readUTF());
	
	client.close();
} catch(IOException e) {...}
~~~

## Links
- <http://tutorials.jenkov.com/java-networking/index.html>
