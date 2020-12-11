---
layout: default
title: Java - NIO
folder: nio
permalink: /archive/java/nio/
---

# Java NIO

## IO v.s. NIO

功能
- IO 面向流 Stream ；NIO 面向缓冲区 Buffer
- IO 是阻塞式的；NIO 是非阻塞的

使用场景
- IO 适用，连接数目比较小，并且一次发送大量数据的场景
- NIO 适用，服务器需要支持**大量长连接**。比如10000个连接以上，并且每个客户端并不会频繁地发送太多数据

## NIO 原理

实现 NIO 的主要原理是**轮询**。即，一个线程，同时监听多个接口，如果这个接口有数据就读取，没有就检查下一个。

但是，轮询的缺点是浪费CPU资源，因为大部分时间可能都是无数据可读的。
所以，一种常用的改进方案是**I/O多路复用**（IOmultiplexing），即监听时，由事件驱动，当某个接口的数据好了，再过去读。

## NIO 的三种模型

- Reactor 单线程模型
- Reactor 多线程模型
- 主从 Reactor 多线程模型

参考 -> <https://blog.csdn.net/jiyiqinlovexx/article/details/51204726>

## NIO API

Core components

- Channels
  - Channels read data into Buffers
- Buffers
  - Buffers write data into Channels
- Selectors
  - Selector allows a single thread to handle multiple Channels

Multiple sources read/write from multiple channels into buffer(s), thus non-blocking.

### Channel

Channel is similar to Stream, it is the gate for read/write.

Channels implementation

- FileChannel (File NIO)
- DatagramChannel (UDP NIO)
- SocketChannel (TCP NIO)
- ServerSocketChannel (TCP NIO)

~~~ java
//create channel
RandomAccessFile aFile = new RandomAccessFile("data/nio-data.txt", "rw");
FileChannel inChannel = aFile.getChannel();

//create buffer with capacity of 48 bytes
ByteBuffer buf = ByteBuffer.allocate(48);

//read from channel into buffer
int bytesRead = inChannel.read(buf); 
while (bytesRead != -1) {
  buf.flip();  //filp the buffer mode from write to read
  while(buf.hasRemaining()){
    System.out.print((char) buf.get()); // read 1 byte at a time
  }
  buf.clear(); //filp the buffer mode from read to write
  bytesRead = inChannel.read(buf);
}
aFile.close();
~~~

### Buffer

A buffer is essentially a block of memory into which you can write data, which you can then later read again.

Usage

- Write data into the Buffer
- Call buffer.flip()
- Read data out of the Buffer
- Call buffer.clear() or buffer.compact()

Buffer implementation

- ByteBuffer
- CharBuffer
- DoubleBuffer
- FloatBuffer
- IntBuffer
- LongBuffer
- ShortBuffer

### Selector

- It can examine one or more NIO Channel's, and determine which channels are ready for reading/writing. 
- This way a single thread can manage multiple channels, and thus multiple network connections.

Usage

- open a Selector
- register Channels for this Selector
- select ready Channels from Selector by calling select()
  - select() will block until there is an event ready for one of the registered Channels
- process the return results
  - get a set of SelectionKey, this key contains
    - the interest set
    - the ready set
    - the Channel
    - the Selector
    - an attached object (optional)
  - iterate the set to do operations

~~~ java
Selector selector = Selector.open();
channel.configureBlocking(false);
SelectionKey key = channel.register(selector, SelectionKey.OP_READ);
while(true) {
  int readyChannels = selector.select();
  if(readyChannels == 0) continue;
  Set<SelectionKey> selectedKeys = selector.selectedKeys();
  Iterator<SelectionKey> keyIterator = selectedKeys.iterator();
  while(keyIterator.hasNext()) {
    SelectionKey key = keyIterator.next();
    if(key.isAcceptable()) {
        // a connection was accepted by a ServerSocketChannel.
    } else if (key.isConnectable()) {
        // a connection was established with a remote server.
    } else if (key.isReadable()) {
        // a channel is ready for reading
    } else if (key.isWritable()) {
        // a channel is ready for writing
    }
    keyIterator.remove();
  }
}
~~~

## Links
- <http://tutorials.jenkov.com/java-nio/overview.html>
- <https://zhuanlan.zhihu.com/p/23488863>
