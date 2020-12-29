---
title: 在Ubuntu系统中安装常用软件
tags:
  - backup
comments: true
date: 2020-09-7 15:06:19
updated: 2020-12-29 12:06:19
---
> 在进行软件安装命令`apt`前，尽可能的进行一次更新操作：
>
> `sudo apt update`

### Java

> 2020年9月7日更新

- 安装（默认 JDK-11）

    ```bash
    sudo apt install default-jdk
    
    # 如果只需要Java运行环境，那么可以只安装JRE
    sudo apt install default-jre
    ```

<!-- more -->

- 确认版本

    ```bash
    java -version
    ```

    ```
    # 输出
    openjdk 11.0.8 2020-07-14
    OpenJDK Runtime Environment (build 11.0.8+10-post-Ubuntu-0ubuntu118.04.1)
    OpenJDK 64-Bit Server VM (build 11.0.8+10-post-Ubuntu-0ubuntu118.04.1, mixed mode, sharing)
    ```

- 安装 JDK-8

    ```bash
    sudo apt install openjdk-8-jdk
    ```

- 多版本切换

    ```bash
    sudo update-alternatives --config java
    ```

    ```bahs
    # 输出
    There are 2 choices for the alternative java (providing /usr/bin/java).
      Selection    Path                                            Priority   Status
    ------------------------------------------------------------
    * 0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
      1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
      2            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode
    Press <enter> to keep the current choice[*], or type selection number:
    ```

    根据需要输入对应版本前的序号即可。

- 配置 JAVA_HOME 变量

    ```bash
    sudo update-alternatives --config java
    ```

    - JDK-11 的路径为：`/usr/lib/jvm/java-11-openjdk-amd64/bin/java`
    - JDK-8 的路径为：`/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java`

    在 `/etc/environment` 文件末尾添加：

    ```
    JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
    ```

    更新一下：

    ```bash
    source /etc/environment
    ```

    验证一下：

    ```bash
    echo $JAVA_HOME
    ```

    ```
    # 输出
    /usr/lib/jvm/java-11-openjdk-amd64
    ```

### Node.js 和 npm

- 通过 `apt` 安装

    ```bash
    sudo apt install nodejs npm
    ```

- 更新

    ```bash
    npm install npm@latest -g
    ```

>  关于 npm 的换源请看下一篇文章：

### Yarn

- 跳过 node 安装

    ```bash
    sudo apt install --no-install-recommends yarn
    ```

### Nginx

- 安装

    ```bash
    sudo apt install nginx
    ```

- 查看 Nginx 状态：

    ```bash
    sudo systemctl status nginx
    ```

- 停止 Nginx：

    ```BASH
    sudo systemctl stop nginx
    ```

- 重启 Nginx：

    ```bash
    sudo systemctl restart nginx
    ```


### Docker

- 安装程序所需依赖，导入GPG密钥，将Docker APT存储库添加到系统中

    ```bash
    sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ```

- 安装

    ```bash
    sudo apt install docker-ce docker-ce-cli containerd.io
    ```


### tldr

命令帮助工具

```bash
npm install -g tldr
```

### neofetch

命令行系统信息工具

```bash
sudo apt install neofetch
```

### zsh & oh-my-zsh

```bash
sudo apt install zsh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

由于网络原因下载慢的，可以使用下面的备份地址

`https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh`

```bash
sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"
```

