---
title: Linux 部署 SpringBoot jar包
categories:
  - tech
tags:
  - linux
comments: true
date: 2019-08-03 09:39:03
updated: 2021-03-15 12:49:49
---
最近使用springboot搭建了一个接口，想在自己的服务器上部署一下jar包，在此记录一下。

在服务器部署jar包的方式有两种，一种是通过jar包（官方推荐）的方式，另一种是使用 tomcat 部署war包。

因为springboot内置了tomcat，所以部署war包的方式就显得有些繁琐了，这里就介绍一下部署jar包。

<!-- more -->

### 1. 打包

打包就是将springboot打包成可执行应用，使用maven打包。

在项目根路径下执行命令：`mvn clean package`，会在项目的 target 目录下生成jar包，名称格式为：`name+version.jar`，其中的name和version对应的就是pom.xml文件里的属性值。

### 2. 执行jar包

我们熟悉的运行jar包的命令是通过`java -jar `命令，但是这种方法程序不能在后台运行。

为了保持程序后台运行，这里会用到&命令和nohup命令。

&命令是让命令可以后台执行。

使用&命令后，作业被提交到后台运行，当前控制台没有被占用，但是一但把当前控制台关掉(退出帐户时)，作业就会停止运行。nohup命令可以在你退出帐户之后继续运行相应的进程。nohup就是不挂起的意思( no hang up)。

例如：`nohup java -jar test.jar &`

### 3. 终止程序

当成功地提交进程以后，就会显示出一个进程号，可以用它来监控该进程，或杀死它。

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pLmxvbGkubmV0LzIwMTkvMDcvMjAvNWQzMmZjYWU2OWNiYjk3MTYwLnBuZw)

`ps -ef | grep 进程号`    

 `kill -9 进程号`



