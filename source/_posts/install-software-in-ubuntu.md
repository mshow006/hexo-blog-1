---
title: 在Ubuntu系统中安装常用软件
comments: true
date: 2020-09-7 15:06:19
updated: 2020-12-29 12:06:19
categories:
 - tech
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
    sudo npm install npm@latest -g
    ```
- 通过 NodeSource 安装

```
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install nodejs
```

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

[DaoCloud](http://get.daocloud.io/#install-docker)

```bash
curl -sSL https://get.daocloud.io/docker | sh
```

```bash
docker --version
```

卸载
```bash
sudo apt-get remove docker docker-engine
```

> 卸载Docker后,/var/lib/docker/目录下会保留原Docker的镜像,网络,存储卷等文件. 如果需要全新安装Docker,需要删除/var/lib/docker/目录

```bash
rm -fr /var/lib/docker/
```

### Docker Compose

```bash
curl -L https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

```bash
chmod +x /usr/local/bin/docker-compose
```

```bash
docker-compose --version
```

### tldr

命令帮助工具

```bash
sudo npm install -g tldr
```

### neofetch

命令行系统信息工具

```bash
sudo apt install neofetch
```

### zsh & oh-my-zsh

```bash
# 安装 zsh
sudo apt install zsh

# 更换默认 SHELL
chsh -s $(which zsh)

# 安装 oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

由于网络原因下载慢的，可以使用下面的备份地址

`https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh`

```bash
sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"
```

#### zsh 插件推荐

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

`.zshrc` 文件修改如下

```
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
```
