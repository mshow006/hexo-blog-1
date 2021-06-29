---
title: 自建 Tiny Tiny RSS 记录
categories:
  - tech
tags:
  - rss
comments: true
date: 2021-06-29 09:05:43
updated: 2021-06-29 09:05:43
---

### 准备环境

- Ubuntu 20.04 LTS
- [Docker-Compose](https://yingming006.cn/install-software-in-ubuntu/#Docker-Composer)

### 部署 TTRSS

1. 下载 [docker-compose.yml](https://github.com/HenryQW/Awesome-TTRSS/blob/main/docker-compose.yml) 至任意目录。

```bash
mkdir ttrss && cd ttrss
wget https://github.com/HenryQW/Awesome-TTRSS/blob/main/docker-compose.yml
```

2. 更改 `docker-compose.yml` 的配置：

- SELF_URL_PATH：https://ttrss.yingming006.cn
  TTRSS 实例地址。🔴 请注意，该变量值必须与你在浏览器中用于访问 TTRSS 的 URL 保持完全一致，否则 TTRSS 将无法启动。

3. 部署启动

```bash
sudo docker-compose up -d
```

### 配置 HTTPS

可以参考：[启用 HTTPS](https://yingming006.cn/support-https-with-let-s-encrypt/)

### TTRSS 网站配置

登录 TTRSS，打开偏好设置，根据自己的需求进行配置

推荐打开的配置：

- 启用 API

![](https://cdn.jsdelivr.net/gh/yingming006/img-hosting/PicGo/ttrss-open-api.png)

- 插件
  - fever：开启后可以使用 `Fever API` 来获取RSS，需要在 `Fever Emulation` 中设置密码，此密码用于 `Fever API` 登录
  - mercury_fulltext：全文获取

### Mercury 全文获取

1. 偏好设置中启用 `mercury-fulltext` 插件
2. 偏好设置-信息源-Mercury Fulltext settins 中设置地址
  ![](https://cdn.jsdelivr.net/gh/yingming006/img-hosting/PicGomercury-fulltext.png)
3. 编辑信息源中，插件 tab 下启用 `Get fulltext via Mercury Parser`
  ![](https://cdn.jsdelivr.net/gh/yingming006/img-hosting/PicGoopen-mercury-fulltext.png)

### 部署 RSSHub

