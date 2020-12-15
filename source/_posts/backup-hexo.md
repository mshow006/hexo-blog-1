---
title: 备份 Hexo 博客
categories:
 - Hexo
tags:
 - Hexo
 - Next
comments: true
date: 2020-12-15 19:40:55
updated: 2020-12-15 19:40:55
---

> 备份是一个好习惯。

目前网上绝大多数的 Hexo 博客备份都是在GitHub新建一个备份仓库，修改 `.gitignore`，每次更新博客的时候`git push`一下，这样确实方便很多，但是我在浏览 [next 官方文档](https://theme-next.js.org/docs/getting-started/#Configuration)的时候，发现了可以对备份精简的方法，使用代替主题配置文件([Alternate Theme Config](https://theme-next.js.org/docs/getting-started/configuration.html))去掉 themes 文件夹。

>  使用此功能需要 Hexo 版本 >= 5.0.0。

首先配置站点`_config.yml`文件，

```yml
# _config.yml 以 next 主题为例
theme: "next"
```

然后在站点根目录新建`_config.[theme].yml`文件，例如 `_config.[theme].yml`