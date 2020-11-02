---
title: Ubuntu的软件源配置和管理工具
categories:
  - Ubuntu
tags:
  - Ubuntu
comments: true
date: 2020-11-02 16:29:51
updated: 2020-11-02 16:29:51
---

## Node.js

- 全局修改

    ```bash
    npm config set registry https://registry.npm.taobao.org/
    ```

- 第三方软件切换 node.js 镜像源 [nrm](https://www.npmjs.com/package/nrm)

    ```bash
    # 安装
    npm install -g nrm
    # 列出可用的镜像源
    nrm ls
    # 选择 taobao 镜像源
    nrm use taobao
    # 测试镜像源访问速度
    nrm test taobao
    ```

## Yarn

- 全局修改

    ```bash
    yarn config set registry https://registry.npm.taobao.org/
    ```

- 第三方软件切换 yarn 镜像源 [yrm](https://github.com/Pana/nrm)

    ```bash
    # 安装
    npm install -g yrm
    # 列出可用的镜像源
    yrm ls
    # 选择 taobao 镜像源
    yrm use taobao
    # 测试镜像源访问速度
    yrm test taobao
    ```

## pip3

