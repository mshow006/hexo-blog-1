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

```bash
#!/bin/bash
PROXY_PORT=10808
WINDOWS_NAMESERVER=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
WINDOWS_PROXY=socks5://$WINDOWS_NAMESERVER:$PROXY_PORT

case $1 in
        start)
            export HTTP_PROXY=$WINDOWS_PROXY
            export http_proxy=$WINDOWS_PROXY
            export HTTPS_PROXY=$WINDOWS_PROXY
            export https_proxy=$WINDOWS_PROXY

            if [ "`git config --global --get proxy.https`" != "$WINDOWS_PROXY" ]; then
                git config --global proxy.https $WINDOWS_PROXY
                git config --global proxy.http $WINDOWS_PROXY
            fi
            ;;
        stop)
            unset HTTP_PROXY
            unset http_proxy
            unset HTTPS_PROXY
            unset https_proxy
            if [ "`git config --global --get proxy.https`" = "$WINDOWS_PROXY" ]; then
                git config --global --unset https.proxy
                git config --global --unset http.proxy
            fi
            ;;
        *)
            echo "usage: source $0 start|stop"
            ;;
esac
```

在 `~/.bashrc` 文件末尾新增一条命令 `alias proxy="source ~/.set-wsl2-proxy.sh"`

```bash
echo 'alias proxy="source ~/.set-wsl2-proxy.sh"' >> ~/.bashrc
```