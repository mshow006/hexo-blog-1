---
title: 启动 WSL 2时警告“参考的对象类型不支持尝试的操作”
categories:
  - tech
tags:
  - wsl
comments: true
date: 2019-12-30 22:33:32
updated: 2021-03-15 12:26:10
---

<a href="https://sm.ms/image/8tUdMrmAfWqKHTw" target="_blank"><img src="https://i.loli.net/2019/12/30/8tUdMrmAfWqKHTw.png" ></a>

出现图中所示错误的原因是 **代理软件与 wsl2 的端口冲突**。

<!-- more -->

~~在管理员身份模式下执行 `netsh winsock reset` ,可以重新启动 `WSL`。~~

> 此操作会导致代理软件（proxifier）无法使用，请谨慎操作。
[Github Issue1](https://github.com/microsoft/WSL/issues/4194#issuecomment-636468984) 
[Github Issue2](https://github.com/microsoft/WSL/issues/4177#issuecomment-508826708)

使用 `NoLsp.exe`  [下载链接](http://www.proxifier.com/tmp/Test20200228/NoLsp.exe) 

[备用下载链接](https://wwa.lanzous.com/iKGsNjt8tid)

使用管理员身份运行以下命令:

```cmd
NoLsp.exe C:\Windows\system32\wsl.exe
```

> 参数为 wsl 的绝对路径（默认为 `C:\Windows\system32\wsl.exe`）

问题原因及解决方案的讨论见 [Gihub Issue](https://github.com/microsoft/WSL/issues/4177#issuecomment-597736482)