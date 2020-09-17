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

## 依赖

Maven配置

~~~ xml
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

~~~ java
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

~~~ java
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

~~~ java
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

~~~ java
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

~~~ java
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

~~~ java
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

~~~ java
    /**
     * 删除文件
     */
    @Test
    public void delete() throws Exception {
        boolean result = fileSystem.delete(new Path("/app/test/hello.txt"), true);
        System.out.println(result);
    }
~~~

## 实战小应用 - WordCount

使用HDFS API完成wordcount统计

需求：统计HDFS上的文件的wc，然后将统计结果输出到HDFS

功能拆解：
1. 读取HDFS上的文件 ==> HDFS API
2. 业务处理(词频统计)：对文件中的每一行数据都要进行业务处理（按照分隔符分割） ==> Mapper
3. 将处理结果缓存起来   ==> Context
4. 将结果输出到HDFS ==> HDFS API

说明
- 创建了一个Properties类读取配置文件。
- Mapper使用了一个接口，方便扩展。
- Context中直接使用了一个Map做缓存，也可以使用其它的实现方式。
- （方便起见，所有类都放到了一个文件中，实际应该拆开。）

下面是代码：

wc.properties

~~~
INPUT_PATH=/app/wc.txt
~~~

WordCountApp01.java

~~~ java
package max.learn;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

import java.net.URI;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.Properties;

/**
 *
 */
public class WordCount01 {

    public static void main(String[] args) throws Exception {

        ImoocMapper mapper = new WordCountMapper();
        ImoocContext context = new ImoocContext();

        // 1）读取HDFS上的文件 ==> HDFS API
        Properties properties = ParamsUtils.getProperties();
        Path input = new Path(properties.getProperty("INPUT_PATH"));
        //Path input = new Path("/app/wc.txt");

        // 获取要操作的HDFS文件系统
        FileSystem fs = FileSystem.get(new URI("hdfs://woklxd00361:8020"), new Configuration(),"eufiudwq");

        RemoteIterator<LocatedFileStatus> iterator = fs.listFiles(input, false);
        while(iterator.hasNext()) {
            LocatedFileStatus file = iterator.next();
            FSDataInputStream in = fs.open(file.getPath());
            BufferedReader reader = new BufferedReader(new InputStreamReader(in));

            String line = "";
            while ((line = reader.readLine()) != null) {

                // 2）业务处理(词频统计) (hello,3)
                // 3）将结果缓存起来，存到context的cacheMap中
                mapper.map(line, context);
            }

            reader.close();
            in.close();
        }

        // 4）将结果输出到HDFS ==> HDFS API
        Path output = new Path("/app");
        FSDataOutputStream out = fs.create(new Path(output, new Path("wc.out")));

        Map<Object, Object> contextMap = context.getCacheMap();
        Set<Map.Entry<Object, Object>> entries = contextMap.entrySet();
        for(Map.Entry<Object, Object> entry : entries) {
            out.write((entry.getKey().toString() + " \t " + entry.getValue() + "\n").getBytes());
        }

        out.close();
        fs.close();

        System.out.println("HDFS API统计词频运行成功....");

    }
}

/**
 * 自定义上下文，其实就是缓存
 */
class ImoocContext {

    private Map<Object, Object> cacheMap = new HashMap<Object, Object>();

    public Map<Object, Object> getCacheMap() {
        return cacheMap;
    }

    /**
     * 写数据到缓存中去
     * @param key 单词
     * @param value 次数
     */
    public void write(Object key, Object value) {
        cacheMap.put(key, value);
    }

    /**
     * 从缓存中获取值
     * @param key 单词
     * @return  单词对应的词频
     */
    public Object get(Object key) {
        return cacheMap.get(key);
    }

}

/**
 * 自定义Mapper
 */
interface ImoocMapper {

    /**
     *
     * @param line  读取到到每一行数据
     * @param context  上下文/缓存
     */
    public void map(String line, ImoocContext context);
}

/**
 * 自定义wc实现类
 */
class WordCountMapper implements ImoocMapper {

    public void map(String line, ImoocContext context) {
        String[] words = line.split(" ");

        for (String word : words) {
            Object value = context.get(word);
            if (value == null) { // 表示没有出现过该单词
                context.write(word, 1);
            } else {
                int v = Integer.parseInt(value.toString());
                context.write(word, v + 1);  // 取出单词对应的次数+1
            }
        }
    }

}

/**
 * 读取属性配置文件
 */
class ParamsUtils {

    private static Properties properties = new Properties();

    static {
        try {
            properties.load(ParamsUtils.class.getClassLoader().getResourceAsStream("wc.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Properties getProperties() throws Exception {
        return properties;
    }

}
~~~
