---
title: 设置 WSL 代理
tags:
  - backup
comments: true
date: 2020-11-30 16:58:27
updated: 2020-11-30 16:58:27
---

## 获取 WSL2 IP 地址

在 WSL2 中，要访问 Windows 上运行的网络应用（例如在 Windows 上运行的代理软件、SQL 服务器等），需要使用 WSL2 的 IP 地址，而不是 `localhost`。

WSL2 的 IP 地址保存在 `/etc/resolv.conf` 文件中的 `nameserver`，可以通过一下命令获取：

```bash
cat /etc/resolv.conf|grep nameserver|awk '{print $2}'
```
## 设置环境变量

> 这里拿 v2ray 举例，默认 sock5 的监听端口为 10808

```bash
export PROXY_PORT=10808
export WINDOWS_NAMESERVER=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
export WIN_PROXY=socks5://$WINDOWS_NAMESERVER:$PROXY_PORT
export HTTP_PROXY=$WIN_PROXY
export HTTPS_PROXY=$WIN_PROXY
```

## Windows 防火墙以及 v2ray 设置

v2ray 默认情况下是不能通过防火墙的，需要允许 v2ray 通过 Windows 的防火墙，设置如图:

![windows 防火墙](https://i.loli.net/2020/12/31/DStfWsanH1E6wLJ.png)

> 图中允许 v2ray 全部通过防火墙，读者可根据需要自定义开启

v2ray 必须开启**允许来自局域网的连接（connection from private net work）**

![代理软件设置](https://i.loli.net/2020/11/30/vZ1EH96GKOnDQBI.png)

现在可以通过 `curl www.google.com` 来测试代理，如果控制台有输出即为设置成功。

最后附上一个脚本，可以通过 `proxy start | stop` 开启或者关闭代理。


```bash
#!/bin/bash
PROXY_PORT=10808
WINDOWS_NAMESERVER=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
WIN_PROXY=socks5://$WINDOWS_NAMESERVER:$PROXY_PORT

case $1 in
        start)
            export HTTP_PROXY=$WIN_PROXY
            export HTTPS_PROXY=$WIN_PROXY

            if [ "`git config --global --get proxy.https`" != "$WIN_PROXY" ]; then
                git config --global proxy.https $WIN_PROXY
                git config --global proxy.http $WIN_PROXY
            fi
            ;;
        stop)
            unset HTTP_PROXY
            unset http_proxy
            unset HTTPS_PROXY
            unset https_proxy
            if [ "`git config --global --get proxy.https`" = "$WIN_PROXY" ]; then
                git config --global --unset https.proxy
                git config --global --unset http.proxy
            fi
            ;;
        *)
            echo "usage: source $0 start|stop"
            ;;
esac
```

需要在 `~/.bashrc` 文件末尾新增一条命令

```bash
'alias proxy="source ~/.set-wsl2-proxy.sh"'
```