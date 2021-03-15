---
title: 解决 win10 Postman 无法打开的问题"Could not open Postman"
categories:
  - tech
tags:
  - win10
comments: true
date: 2019-12-10 20:57:29
updated: 2021-03-15 12:32:21
---
环境参数：
win 10 1903
Postman 7.13.0

安装完 Postman 打开后会出现下列情况
<img src="https://i.loli.net/2019/12/10/c9Q2EyGLZAWIPaD.png" width=300 >

先打开任务管理器，结束 Postman 进程

然后删除 Postman 本地数据
`C:\Users\<user>\AppData\Roaming\Postman`

完成后再打开就可以了