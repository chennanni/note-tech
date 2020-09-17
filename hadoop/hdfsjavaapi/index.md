---
layout: default
title: Hadoop - HDFS Java API
folder: hdfsjavaapi
permalink: /archive/hadoop/hdfsjavaapi/
---

# Hadoop - HDFS Java API

本小节内容：使用Java对HDFS进行编程

## 前置要求

- 首先，要有一台Server(local跑一个也行)，运行HDFS模块。
- 然后，本地使用Java API，作为Client，连上Server，进行操作。

## Maven依赖

~~~
<properties>
  <hadoop.version>2.6.0-cdh5.15.1</hadoop.version>
</properties>

<!---引入cdh的仓库-->
<repositories>
    <repository>
        <id>cloudera</id>
        <url>https://repository.cloudera.com/artifactory/cloudera-repos/</url>
    </repository>
</repositories>

<!--添加Hadoop依赖包-->
<dependencies>
      <dependency>
          <groupId>org.apache.hadoop</groupId>
          <artifactId>hadoop-client</artifactId>
          <version>${hadoop.version}</version>
      </dependency>
</dependencies>
~~~

## 基本功能

### hadoop fs -ls

~~~
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.util.Progressable;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URI;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class AppTest {

    public static final String HDFS_PATH = "hdfs://hadoop000:8020";
    FileSystem fileSystem = null;
    Configuration configuration = null;

    @Before
    public void setUp() throws Exception {
        System.out.println("--------setUp---------");

        configuration = new Configuration();
        configuration.set("dfs.replication","1");

        /**
         * 构造一个访问指定HDFS系统的客户端对象
         * 第一个参数：HDFS的URI
         * 第二个参数：客户端指定的配置参数
         * 第三个参数：客户端的身份，说白了就是用户名
         */
        fileSystem = FileSystem.get(new URI(HDFS_PATH), configuration, "hadoop");
    }

    @After
    public void tearDown() {
        configuration = null;
        fileSystem = null;
        System.out.println("--------tearDown---------");
    }

    /**
     * 查看HDFS内容
     */
    @Test
    public void text()throws Exception {
        FSDataInputStream in = fileSystem.open(new Path("/app/hc.txt"));
        IOUtils.copyBytes(in, System.out, 1024);
    }
}
~~~

result

~~~
hello world
welcome to hadoop
hello hello
~~~

### hadoop fs -mkdir

~~~
    /**
     * 创建HDFS文件夹
     */
    @Test
    public void mkdir() throws Exception {
        fileSystem.mkdirs(new Path("/test"));
    }
~~~

result

~~~
Found 2 items
-rw-r--r--   1 hadoop supergroup         42 2020-09-15 08:52 /app/hc.txt
drwxr-xr-x   - hadoop supergroup          0 2020-09-15 10:21 /app/test
~~~

### hadoop fs -mv

~~~
    /**
     * 测试文件名更改
     * @throws Exception
     */
    @Test
    public void rename() throws Exception {
        Path oldPath = new Path("/app/hc.txt");
        Path newPath = new Path("/app/hd.txt");
        boolean result = fileSystem.rename(oldPath, newPath);
        System.out.println(result);
    }
~~~

result

~~~
Found 2 items
-rw-r--r--   1 hadoop supergroup         42 2020-09-15 08:52 /app/hd.txt
drwxr-xr-x   - hadoop supergroup          0 2020-09-15 10:21 /app/test
~~~

### hadoop fs -copyFromLocal

~~~
    /**
     * 拷贝本地文件到HDFS文件系统
     */
    @Test
    public void copyFromLocalFile() throws Exception {
        Path src = new Path("C:/Temp/hello.txt");
        Path dst = new Path("/app/test");
        fileSystem.copyFromLocalFile(src,dst);
    }
~~~

result

~~~
Found 1 items
-rw-r--r--   1 hadoop supergroup         20 2020-09-17 04:17 /app/test/hello.txt
~~~

### hadoop fs -get

~~~
    /**
     * 拷贝HDFS文件到本地：下载
     */
    @Test
    public void copyToLocalFile() throws Exception {
        Path src = new Path("/app/test/hello.txt");
        Path dst = new Path("C:/Temp");
        fileSystem.copyToLocalFile(src, dst);
    }
~~~

### hadoop fs -ls

~~~
    /**
     * 查看目标文件夹下的所有文件
     */
    @Test
    public void listFiles() throws Exception {
        FileStatus[] statuses = fileSystem.listStatus(new Path("/app"));

        for(FileStatus file : statuses) {
            String isDir = file.isDirectory() ? "文件夹" : "文件";
            String permission = file.getPermission().toString();
            short replication = file.getReplication();
            long length = file.getLen();
            String path = file.getPath().toString();

            System.out.println(isDir + "\t" + permission
                    + "\t" + replication + "\t" + length
                    + "\t" + path
            );
        }

    }
~~~

### hadoop fs -rm

~~~
    /**
     * 删除文件
     */
    @Test
    public void delete() throws Exception {
        boolean result = fileSystem.delete(new Path("/app/test/hello.txt"), true);
        System.out.println(result);
    }
~~~
