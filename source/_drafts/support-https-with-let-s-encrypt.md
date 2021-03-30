---
title: 启用 HTTPS
categories:
  - tech
tags:
  - https
comments: true
date: 2021-03-30 11:55:05
updated: 2021-03-30 11:55:05
---

> Let's Encrypt 是**免费**、**开放**和**自动化**的证书颁发机构。由非盈利组织互联网安全研究小组（ISRG）运营。

## 准备环境

- 一个解析正常域名
- 服务器安装 Nginx
- 开放 80 和 443 端口

## 安装 Cerbot

> Certbot 是一个免费的开源软件工具，可用于在手动管理的网站上自动使用 Let's Encrypt 证书来启用 HTTPS。

```bash
sudo apt update
sudo apt install certbot
```

## 创建强 DH（Diffie-Hellman） 组

Diffie-Hellman 密钥交换（DH）是一种在不安全的通信通道上安全地交换加密密钥的方法。

生成一组新的 2048 位 DH :

```bash
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

也可以生成 4096 位的密钥长度，不过生成时间可能会过长，这取决于系统熵（system entropy）

## 获取 Let's Encrypt 证书

获取证书可以使用 webroot 插件，
