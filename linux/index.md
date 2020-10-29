---
layout: default
title: Linux
folder: linux
permalink: /archive/linux/
---

# Linux

## 文件体系

Linux以文件的形式对计算机中的数据和硬件资源进行管理，也就是彻底的**一切皆文件**，
反映在Linux的文件类型上就是：普通文件、目录文件（也就是文件夹）、设备文件、链接文件、管道文件、套接字文件（数据通信的接口）等等。

## 文件类型

- 普通文件
- 目录文件 - `d, directory file`
- 符号链接 - `l, symbolic link`
- 设备文件
  - 块设备文件 - `b, block`
  - 字符设备文件 - `c, char`
- FIFO - `p, pipe`
- 套接字 - `s, socket`

参考 -> Linux文件系统详解 <https://www.cnblogs.com/bellkosmos/p/detail_of_linux_file_system.html>

## 目录结构

`/`: root，根目录

`~`: 一般指向当前用户的根目录，比如 `/home/user1`

`root`: 系统管理员的目录

`home`: 存放不同用户个人目录的地方

`bin`: binaries，包含一些可以运行的二进制文件

`sbin`: super binaries，包含一些需要 sudo 运行的二进制文件

`lib`: libary，包含应用程序可以使用的代码文件

`etc`: everything to configure，包含大部分的系统配置文件

`usr`: 许多现代的 Linux 发行版把所有的东西都放到 `/usr/bin` 中，并让 `/bin` 指向 `/usr/bin`

`dev`: device，设备文件的目录

`var`: variable，`/var/log` 下记录了系统的日志

TODO
![linux_tree_index](img/linux_tree_index.PNG)
https://pic1.zhimg.com/80/v2-778dec6bdfcd5c3d868f4a7f0f72ae60_720w.jpg

参考 -> Linux 文件系统详解 <https://zhuanlan.zhihu.com/p/38802277>

## 挂载 Mount

命令如下：

~~~
mount [-t vfstype] [-o options] device dir
~~~

Mount命令是什么意思呢？它是把外接设备（光盘 / U盘 / 其它Linux机器 / Windows机器）**挂载**到本机使用。

比如，Windows系统，我们插入一张光盘（CD/DVD），系统会“加载”这个盘，“我的电脑”会跳出一个`H:`盘，我们直接打开这个`H:`盘就可以用了。

Linux也是类似的，但是一般需要我们自己“加载”，也就是MOUNT。

有一点特别的是，Mount还可以指定路径，比如，我可以把一台`外接设备A`挂载到`B机器`的`~/test`这个目录下，相当于所有这个目录下的文件读写，实际都发生在`A`上。

参考 -> Linux挂载命令mount用法及参数详解 <https://www.linuxprobe.com/mount-detail-parameters.html>

## 理解一个实际例子

使用`df -h`查看本机的磁盘空间

~~~
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda2             9.8G  2.3G  7.0G  25% /
tmpfs                  95G     0   95G   0% /dev/shm
/dev/sda1             240M  105M  123M  47% /boot
/dev/sda6             207G   50G  147G  26% /local/0
/dev/sda3             9.8G  1.6G  7.7G  17% /var
aaa.aaa.aaa.com:/nfs-appdata-someword-1/user1
                      1.9T  1.4T  463G  75% /home/user1
bbb.bbb.bbb.com:/nfs-appdata-someword-2/user2
                       32G  2.4G   30G   8% /home/user2
ccc.ccc.ccc.com:/nfs-appdata-someword-3/
                      800G  715G   86G  90% /home/user3
~~~

首先，mount了多个磁盘/硬盘，`/dev/sda1`，`/dev/sda2`，`/dev/sda3`，`/dev/sda6`。
其中，主要是`sda6`这个磁盘，占了207G，它mount在了`/local/0`这个目录下。这也是开发常用的一个本机的目录。

其次，还有多个其它Linux Box也mount了过来，这些机器可以通过`aaa.aaa.aaa.com`，`bbb.bbb.bbb.com`，`ccc.ccc.ccc.com`访问。

（为了验证，我们可以使用`ipadd`获取本机的IP，使用`ping`获取其它机器的IP。）

我猜想，系统是使用 nfs (network file system) 网络文件系统工具 来实现多台Linux主机使用同一个磁盘或目录。

这样的好处是，本机只有200多个G，但是`aaa.aaa.aaa.com`对应的机器有更大的容量，它把`/nfs-appdata-someword-1/user1`这个目录mount到了本机的`/home/user1`目录下，
那我就可以在本机直接读写`/home/user1`这个路径，且可以有大约2T的空间。

参考 -> nfs服务器之间挂载配置 <https://blog.csdn.net/qq_41554005/article/details/103892460>

## 切换用户

```
// 创建用户
useradd [user_name]

// 设置密码
passwd [user_name]

// 删除用户
userdel [user_name]

// 删除用户所在目录
rm -rf [user_name]

// 修改用户这个命令的相关参数
usermod --help
```

参考 -> linux创建用户名密码等操作 <https://www.cnblogs.com/yadongliang/p/8657251.html>
