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