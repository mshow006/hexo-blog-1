---
title: 启用 HTTPS
categories:
  - tech
tags:
  - https
comments: true
date: 2021-03-30 11:55:05
updated: 2021-04-06 11:55:05
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

<!-- more -->

## 创建强 DH（Diffie-Hellman） 组

Diffie-Hellman 密钥交换（DH）是一种在不安全的通信通道上安全地交换加密密钥的方法。

生成一组新的 2048 位 DH :

```bash
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

也可以生成 4096 位的密钥长度，不过生成时间可能会过长，这取决于系统熵（system entropy）

## 获取 Let's Encrypt 证书

[Let's Encrypt 的运作方式](https://letsencrypt.org/zh-cn/how-it-works/)

为了方便，可以将所有的 HTTP 请求映射到 `/var/lib/letsencrypt` 目录下(该目录主要存放验证文件)

```bash
sudo mkdir -p /var/lib/letsencrypt/.well-known
sudo chgrp www-data /var/lib/letsencrypt
sudo chmod g+s /var/lib/letsencrypt
```

为了避免代码重读，创建两个 Nginx 的配置文件 `ssl.conf` 和 `letsencrypt.conf`

```bash
sudo vim /etc/nginx/snippets/ssl.conf
```

```txt /etc/nginx/snippets/ssl.conf
ssl_dhparam /etc/ssl/certs/dhparam.pem;

ssl_session_timeout 1d;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;

ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
ssl_prefer_server_ciphers on;

ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 30s;

add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
add_header X-Frame-Options SAMEORIGIN;
add_header X-Content-Type-Options nosniff;

```

```bash
sudo vim /etc/nginx/snippets/letsencrypt.conf
```

```txt /etc/nginx/snippets/letsencrypt.conf
location ^~ /.well-known/acme-challenge/ {
  allow all;
  root /var/lib/letsencrypt/;
  default_type "text/plain";
  try_files $uri =404;
}
```

创建完成后，把 `letsencrypt.conf` 添加到 Nginx 配置文件上:

```txt /etc/nginx/sites-available/yingming006.cn.conf
server {
  listen 80;
  server_name yingming006.cn www.yingming006.cn;

  include snippets/letsencrypt.conf;
}
```

将 `/etc/nginx/sites-available/yingming006.cn` 链接到 `/etc/nginx/sites-enabled/`

```bash
sudo ln -s /etc/nginx/sites-available/yingming006.cn /etc/nginx/sites-enabled/
```

重启 Nginx， 使配置生效

```bash
sudo systemctl restart nginx
```

获取 SSL 证书

```bash
sudo certbot certonly --agree-tos --email yingming006@foxmail.com --webroot -w /var/lib/letsencrypt/ -d yingming006.cn
```

如果成功，则控制台将打印以下消息

```
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/yingming006.cn/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/yingming006.cn/privkey.pem
   Your cert will expire on 2020-11-22. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

证书获取后，编辑 `/etc/nginx/sites-available/yingming006.cn`

```bash
sudo vim /etc/nginx/sites-available/yingming006.cn
```

```txt /etc/nginx/sites-available/yingming006.cn
server {
    listen 80;
    server_name yingming006.cn;

    include snippets/letsencrypt.conf;
    return 301 https://$host$request_uri;
}

# 强制 www 重定向到主域名
server {
    listen 443 ssl http2;
    server_name www.yingming006.cn;

    ssl_certificate /etc/letsencrypt/live/yingming006.cn/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yingming006.cn/privkey.pem;
    ssl_trusted_certificate /etc/letsencrypt/live/yingming006.cn/chain.pem;
    include snippets/ssl.conf;
    include snippets/letsencrypt.conf;

    return 301 https://yingming006.cn$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yingming006.cn;

    ssl_certificate /etc/letsencrypt/live/yingming006.cn/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yingming006.cn/privkey.pem;
    ssl_trusted_certificate /etc/letsencrypt/live/yingming006.cn/chain.pem;
    include snippets/ssl.conf;
    include snippets/letsencrypt.conf;

    # . . . other code
}

```

重新加载 Nginx， 使配置生效

```bash
sudo systemctl reload  nginx
```

验证 SSL 证书是否生效，可以使用 [SSL Labs Server Test](https://www.ssllabs.com/ssltest/)，结果为 A+，即为配置成功

![](https://i.loli.net/2021/04/06/VcsTP6CAJ8ZMDkt.png)

## 自动更新 Let's Encrypt 证书

Let's Encrypt 证书的有效期默认为 90 天，`cerbot` 默认会在证书到期前 30 天自动更新证书

证书更新后，需要重新加载 Nginx

```bash
sudo vim /etc/letsencrypt/cli.ini
```

```txt /etc/cron.d/certbot
deploy-hook = systemctl reload nginx
```

测试续订结果，使用以下命令

```bash
sudo certbot renew --dry-run
```

如果没有错误，即为续订成功。
