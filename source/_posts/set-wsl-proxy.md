---
title: 设置 WSL 代理
tags:
  - backup
comments: true
date: 2020-11-30 16:58:27
updated: 2020-11-30 16:58:27
---

> windows 代理软件必须开启允许来自局域网(LAN)的连接
![v2ray设置](https://i.loli.net/2020/11/30/vZ1EH96GKOnDQBI.png)

## 1. 设置临时代理

假设代理监听端口为 10808

```bash
# 在 wsl 中输入以下命令
export http_proxy="socks5://127.0.0.1:10808"
export https_proxy="socks5://127.0.0.1:10808"
```

使用`curl www.google.com`测试一下，有输出结果即为配置成功。

> 此方法仅为临时使用，退出 bash 后临时环境变量就会失效

## 2.使用脚本在登录 WSL 时自动执行

新建脚本文件 `~/.set-wsl-proxy.sh`

```bash
#!/bin/bash  
export http_proxy="socks5://127.0.0.1:10808"
export https_proxy="socks5://127.0.0.1:10808"
```

在 `~/.bashrc` 文件末尾新增一条命令

```bash
echo 'source ~/.set-wsl-proxy.sh' >> ~/.bashrc
```