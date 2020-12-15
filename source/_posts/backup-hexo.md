---
title: 备份 Hexo 博客(精简版)
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

<!-- more -->

首先配置站点`_config.yml`文件，

```yml
# _config.yml 以 next 主题为例
theme: "next"
```

然后在站点根目录新建`_config.[theme].yml`文件，例如 `_config.next.yml`

然后把 next 主题文件夹下的 `_config.yml` 文件内容复制到 `_config.next.yml`就可以了。

配置完成后目录结构如下 

![Snipaste_2020-12-15_22-06-10.png](https://i.loli.net/2020/12/15/vJ2YFQg3kEVelw4.png)

下次想要恢复的话，直接从GitHub上拉下来，执行`npm install`即可，非常简单。

另附 `.gitignore`
```
.DS_Store
Thumbs.db
db.json
*.log
node_modules/
public/
.deploy*/
```