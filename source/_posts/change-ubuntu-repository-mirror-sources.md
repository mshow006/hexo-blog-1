---
title: 更换 Ubuntu 镜像源
date: 2020-09-6 21:12:08
updated: 2020-09-17 21:12:08
categories:
 - tech
comments: true
---

- 备份 `/etc/apt/sources.list` 文件

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak 
```

- 修改 `/etc/apt/sources.list` 文件

替换为阿里源，将`http://archive.ubuntu.com`和`http://security.ubuntu.com`替换成`http://mirrors.aliyun.com`
可以参考如下命令：

```
sudo sed -i "s@http://.*archive.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list
```
    
- 更新软件源索引

```bash
sudo apt-get update
```

<!-- more -->

### 阿里源

[官方文档](https://developer.aliyun.com/mirror/ubuntu)

```
sudo sed -i "s@http://.*archive.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list
```

### 华为源

[官方文档](https://mirrors.huaweicloud.com/home)

```
sudo sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
```

### 清华源

[官方文档](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/)

```
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
```

### 腾讯源

[官方文档](https://mirrors.cloud.tencent.com/help/ubuntu.html)

```
sudo sed -i "s@http://.*archive.ubuntu.com@http://mirrors.cloud.tencent.com@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@http://mirrors.cloud.tencent.com@g" /etc/apt/sources.list
```

### 网易源

[官方文档](https://mirrors.cloud.tencent.com/help/ubuntu.html)

```
sudo sed -i "s@http://.*archive.ubuntu.com@http://mirrors.163.com@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@http://mirrors.163.com@g" /etc/apt/sources.list
```