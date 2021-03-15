---
title: [译]如何在Ubuntu 18.04上安装Java
categories:
  - tech
tags:
  - linux
comments: true
date: 2019-08-30 15:32:55
updated: 2021-03-15 12:47:44
---
原文链接：[How to Install Java on Ubuntu 18.04](https://linuxize.com/post/install-java-on-ubuntu-18-04/)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190831101326777.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

Java是世界上最流行的编程语言之一，可以用于构建不同类型的跨平台应用程序。

本教程描述了如何在 Ubuntu 18.04 上安装各种版本的 OpenJDK 以及 Oracle Java。相同的说明适用于 Ubuntu 16.04 和任何基于 Ubuntu 的发行版，包括 Kubuntu，Linux Mint 和 Elementary OS。

## 前提

在继续本教程之前，请确保以[具有sudo权限](https://linuxize.com/post/how-to-create-a-sudo-user-on-ubuntu/)的[用户](https://linuxize.com/post/how-to-create-a-sudo-user-on-ubuntu/)身份登录。

## Java 的版本

Java分为三个不同版本：标准版（SE），企业版（EE）和微型版（ME）。本教程介绍 Java SE（标准版）版本的安装。

OpenJDK 和 Oracle Java 是 Java 的两个主要实现，除了 Oracle Java 还有一些额外的商业功能之外，它们几乎没有区别。

Ubuntu 存储库中有两个不同的Java包，Java Runtime Environment（JRE）和 Java Development Kit（JDK）。

如果您只想运行Java程序，那么您需要仅包含Java运行时环境的JRE。Java开发人员应该安装JDK，它还包括开发/调试工具和库。

我们将向您展示如何安装各种 Java 包。如果您不知道要使用哪个 Java 实现或版本，一般建议坚持使用 Ubuntu 18.04 上提供的默认 OpenJDK 版本。

## 安装默认OpenJDK（Java 11）

在撰写本文时，最新的LTS版本的Java是版本11（2018年5月1日撰写，译者注）。

按照以下步骤在 Ubuntu 系统上安装 Java OpenJDK 11：

1. 首先，使用以下命令更新`apt`包索引：

   ```console-bash
   sudo apt update
   ```

2. 更新包索引后，安装默认的Java OpenJDK包：

   ```console-bash
   sudo apt install default-jdk
   ```

3. 通过运行以下将打印Java版本的命令来验证安装：

   ```console-bash
   java -version
   ```

   输出以下结果：

   ```output
   openjdk version "11.0.2" 2019-01-15
   OpenJDK Runtime Environment (build 11.0.2+9-Ubuntu-3ubuntu118.04.3)
   OpenJDK 64-Bit Server VM (build 11.0.2+9-Ubuntu-3ubuntu118.04.3, mixed mode, sharing)
   ```

就是这样！此时，您已经在Ubuntu系统上成功安装了Java。

> JRE包含在JDK包中。如果只需要JRE，请安装`default-jre`包：

## 安装OpenJDK 8

Java 8仍然是Java中使用最广泛的版本。如果您的应用程序需要Java 8，则可以通过输入以下命令来安装它：

```console-bash
sudo apt update
sudo apt install openjdk-8-jdk
```

## 安装Oracle Java

在安装Oracle Java之前，请确保您已阅读[Oracle JDK许可证](https://www.oracle.com/technetwork/java/javase/terms/license/javase-license.html)。许可证仅允许软件的非商业用途，例如个人使用和开发用途。

可以从[Linux Uprising](https://launchpad.net/~linuxuprising/+archive/ubuntu/java) PPA 安装Oracle Java 11 。

以下步骤描述了如何在Ubuntu 18.04上安装Oracle Java 11：

1. 安装[添加新存储库](https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/)所需的依赖[项](https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/)：

   ```console-bash
   sudo apt install software-properties-common
   ```

2. 通过运行以下命令启用Linux Uprising PPA：

   ```console-bash
   sudo add-apt-repository ppa:linuxuprising/java
   ```

3. 添加存储库后，`oracle-java11-installer`通过键入以下命令更新包列表并安装包：

   ```console-bash
   sudo apt updatesudo apt install oracle-java11-installer
   ```

   系统将提示您接受Oracle许可证。

4. 通过运行以下命令验证安装，该命令将打印版本：

   ```console-bash
   java -version
   ```

   ```output
   java version "11.0.2" 2019-01-15 LTS
   Java(TM) SE Runtime Environment 18.9 (build 11.0.2+9-LTS)
   Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.2+9-LTS, mixed mode)
   ```

## 设置默认Java版本

要检查默认Java版本，您将使用以下命令：

```console-bash
java -version
```

```output
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment (build 11.0.2+9-Ubuntu-3ubuntu118.04.3)
OpenJDK 64-Bit Server VM (build 11.0.2+9-Ubuntu-3ubuntu118.04.3, mixed mode, sharing)
```

如果您有多个Java安装来更改默认版本，请使用`update-alternatives`如下所示的工具：

```console-bash
sudo update-alternatives --config java
```

```output
There are 3 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                            Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
  2            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode

Press <enter> to keep the current choice[*], or type selection number:
```

要更改默认Java版本，只需输入版本数字（“Selection”列中的数字），然后按`Enter`。

## 设置JAVA_HOME环境变量

一些用Java编写的应用程序正在使用`JAVA_HOME` [环境变量](https://linuxize.com/post/how-to-set-and-list-environment-variables-in-linux/)来确定Java安装位置。

要设置`JAVA_HOME`环境变量，首先需要使用该`update-alternatives`命令查找Java安装路径

```console-bash
sudo update-alternatives --config java
```

在我们的例子中，安装路径如下：

- OpenJDK 11位于 `/usr/lib/jvm/java-11-openjdk-amd64/bin/java`
- OpenJDK 8位于 `/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java`

复制首选安装的安装路径。接下来，打开`/etc/environment`文件：

```console-bash
sudo nano /etc/environment
```

在文件末尾添加以下行：

```sh
JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
```

确保使用首选Java版本的路径替换路径。

您可以注销并登录，也可以运行以下[源命令](https://linuxize.com/post/bash-source-command/)将更改应用于当前会话：

```console-bash
source /etc/environment
```

要验证是否`JAVA_HOME`正确设置了环境变量，请运行以下[echo命令](https://linuxize.com/post/echo-command-in-linux-with-examples/)：

```console-bash
echo $JAVA_HOME
```

```output
/usr/lib/jvm/java-11-openjdk-amd64
```

> `/etc/environment`是一个系统范围的配置文件，供所有用户使用。如果要`JAVA_HOME`基于每个用户设置变量，请将该行添加到`.bashrc`用户登录时加载的任何其他配置文件。

## 卸载Java

如果出于任何原因想要卸载Java软件包，可以像安装的任何其他软件包一样卸载它[`apt`](https://linuxize.com/post/how-to-use-apt-command/)。

例如，如果要卸载`openjdk-8-jdk`：

```console-bash
sudo apt remove openjdk-8-jdk
```

## 结论

在本教程中，您学习了如何在Ubuntu服务器上安装和管理多个Java版本。