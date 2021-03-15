---
title: IDEA can't use HTTPClient solution process
categories:
  - tech
tags:
  - idea
comments: true
date: 2020-11-03 13:00:03
updated: 2021-03-15 12:00:03
---
## 问题描述

![image-20201103111841176](https://img-blog.csdnimg.cn/img_convert/cb3a4fc6f56a7257109a386f759c37b4.png)

点击 `Run All Requsets in File` => `Run with no environment` 时，控制台报错如图。

<!-- more -->

## 问题排查

首先在浏览器中测试 GET 请求，请求正常响应，如图

![image-20201103112218103](https://img-blog.csdnimg.cn/img_convert/a2809879cb44173da7951891ce90dc9f.png)

然后又在 Postman 中测试也没有问题

这时想到，应该是 IDEA 的问题了，首先想到的就是插件出了问题，但是 IDEA HTTP Client 没有用到插件，所以说应该不是插件的问题。

## 问题解决

最终经过一番查找，是 IDEA 的代理出了问题，准确说是 IDEA 的代理没有忽略本地地址，导致 IDEA 访问不到本地，所以在 IDEA 代理中设置一下就解决了，配置如图：

![image-20201103112903111](https://img-blog.csdnimg.cn/img_convert/e1e52a8264971abb5d04d2373c547117.png)

或者是直接关闭代理也可以解决。

## 总结

正确的使用搜索引擎可以提高问题排查效率。

尽可能准确的使用关键字查询。