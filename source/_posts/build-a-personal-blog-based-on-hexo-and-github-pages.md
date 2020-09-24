---
title: 基于 Hexo + GitHub Pages 搭建个人博客-资料整理
date: 2020-04-01 00:31:13
updated: 2020-04-01 00:31:13
categories:
 - Hexo
tags:
 - Hexo
 - Next
comments: true
---

## 必读文档

- [Hexo 官方文档](https://hexo.io/zh-cn/)
- [Next 官方文档](https://theme-next.org/docs/)

<!-- more -->

根据文档，基本可以快速搭建一个 GitHub Pages 博客。

这里有一篇比较详细的搭建博文：[通过 Hexo 搭建与使用个人博客](https://sspai.com/post/59337)

---------------

本文主要记录一些不能直接从文档中获取的操作和配置。

## Hexo 使用分类、标签

创建分类、标签
```bash
hexo new page categories
heox new page tags
```
编辑 `source/categories/index.md` 和 `source/tags/index.md`
```
---
title: categories
date: 2020-04-01 00:30:43
type: categories
---
```
```
---
title: tags
date: 2020-04-01 00:30:50
type: tags
---
```

使用分类和标签
```bash
# 新建一篇测试文章
hexo new test
```

编辑 `source/_post/test.md`
```
---
title: test
date: 2020-04-01 01:39:47
categories:
- Cate
tags:
- tag1
- tag2
---
```

保存后，`test` 文章的分类是 `Cate`，标签是 `tag1`、`tag2`。

Hexo 支持同级分类，也支持多级分类。[http://suo.im/5FC3qI](https://hexo.io/zh-cn/docs/front-matter.html#comment-4006970676)

[浅谈博客文章的两种分类方式](https://io-oi.me/tech/categories+tags/)

## 将博客收录到谷歌、百度

### Google Webmaster

#### 1. 添加资源

打开 [Google Webmaster](https://www.google.com/webmasters)，登录，添加资源，选择*网址前缀*输入博客地址；

之后是验证所有权，推荐 *HTML 标记* 验证：

- 复制 meta 标签中的 `content` 值，添加到`Next Config` 中的`google_site_verification` 即可。

#### 2.提交 sitemap.xml

首先安装插件 `hexo-generator-sitemap`

```bash
npm install hexo-generator-sitemap --save
```

然后运行命令 ` hexo clean && hexo g && hexo d` 生成站点地图，并上传到博客，之后就可以通过 `https://your-blog-url/sitemap.xml` 访问到站点地图。

在刚刚的网站左侧点击站点地图，输入站点地图网址 `https://your-blog-url/sitemap.xml`，提交即可。

### Baidu Webmaster

#### 1. 添加资源

打开[Baidu Webmaster](https://ziyuan.baidu.com/site)，登录，点击`添加网站`，按步骤选择，在验证网址时选择`HTML 标签验证`，复制 `meta` 标签中的 `content` 值，添加到`Next Config` 中的`baidu_site_verification` 即可。

#### 2.提交 sitemap.xml

在网站左侧点击`链接提交`，选择`sitmap`提交，输入站点地图网址 `https://your-blog-url/sitemap.xml`即可。

### Other Webmaster

其它网站模仿上述方法添加即可。