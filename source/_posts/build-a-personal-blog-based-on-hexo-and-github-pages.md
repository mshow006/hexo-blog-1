---
title: 基于 Hexo + GitHub Pages 搭建个人博客 - 使用 NexT 主题
date: 2020-04-01 00:31:13
updated: 2020-04-01 00:31:13
categories:
 - Hexo
tags:
 - Hexo
 - NexT
comments: true
---

## 必读文档

- [Hexo 官方文档](https://hexo.io/zh-cn/)
- [NexT 官方文档](https://theme-next.js.org/)

<!-- more -->

## 本地环境准备

### 安装 Node.js

```bash
# 12.x 代表版本号
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo apt install nodejs
```

### 安装 Hexo

```bash
sudo npm install -g hexo
```

### 建站

```bash
hexo init <folder>
cd <folder>
```

搭建完成后，目录结构如下:

```
.
├── _config.landscape.yml   # landscape 主题配置文件， Hexo 的默认主题。
├── _config.yml             # Hexo 站点配置文件。
├── db.json
├── node_modules
├── package-lock.json
├── package.json            # 第三方依赖
├── scaffolds               # 模版 文件夹，新建文章时，Hexo 会根据 scaffold 来建立文件。
├── source                  # 存放用户资源的地方
└── themes                  # 主题文件夹，存放第三方主题的地方。
```

> 在 Hexo 5.0.0 版本后，可以使用独立的 _config.[theme].yml 来代替 themes 下的主题，官方称为[代替配置文件](https://hexo.io/zh-cn/docs/configuration.html#%E4%BD%BF%E7%94%A8%E4%BB%A3%E6%9B%BF%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)。

现在可以使用 `hexo s` 命令启动本地 Hexo 服务器，默认地址 http://localhost:4000 。

## 使用 NexT 主题

### 安装 NexT 主题

- 使用 `npm` (推荐)

{% tabs use npm %}
<!-- tab 使用 Latest 版本 -->
```bash
sudo npm install hexo-theme-next@latest
```
<!-- endtab -->

<!-- tab 指定版本 -->
```bash
sudo npm install hexo-theme-next@8.0.0
```
<!-- endtab -->
{% endtabs %}

- 使用 `git`

{% tabs use git %}
<!-- tab 使用 Latest 分支 -->
```bash
git clone https://github.com/next-theme/hexo-theme-next themes/next
```
或者从 GitLab 下载
```bash
git clone https://gitlab.com/hexo-theme-next/hexo-theme-next themes/next
```
<!-- endtab -->

<!-- tab 指定版本 -->
```bash
git clone --branch v8.0.0 https://github.com/next-theme/hexo-theme-next themes/next
```
或者从 GitLab 下载
```bash
git clone --branch v8.0.0 https://gitlab.com/hexo-theme-next/hexo-theme-next themes/next
```
<!-- endtab -->
{% endtabs %}

### 使用 NexT 主题

在站点配置文件 `_config.yml` 中，设置如下：

```yml
## Themes: https://hexo.io/themes/
theme: next
```

现在使用 `hexo clean && hexo g && hexo s` 命令重新启动本地 Hexo 服务器，打开默认地址 http://localhost:4000，就会看到 NexT 主题了。

### 代替配置文件(Alternate Config) 配置 Hexo 主题

使用[代替配置文件(Alternate Config)](https://hexo.io/zh-cn/docs/configuration.html#%E4%BD%BF%E7%94%A8%E4%BB%A3%E6%9B%BF%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6) 配置 Hexo 主题。这也是 [Next 文档](https://theme-next.js.org/docs/getting-started/configuration.html)推荐的配置方式。

> 注意 Hexo 版本应该 >= 5.0.0 。
  需要在使用 [npm 安装 NexT](/build-a-personal-blog-based-on-hexo-and-github-pages/#安装-NexT-主题) 。

#### 新建 _config.[theme].yml 文件

首先在站点根目录下新建 `_config.next.yml` 文件， `next` 表示使用的 Hexo 主题是 [next-themes](https://github.com/next-theme/hexo-theme-next)。

#### 拷贝 NexT 配置

在**站点根目录**下，使用以下命令拷贝 NexT 配置（或者去 [GitHub](https://github.com/next-theme/hexo-theme-next/blob/master/_config.yml) 上拷贝也可以）。

```bash
cp node_modules/hexo-theme-next/_config.yml _config.next.yml
```

同样的，在使用 `hexo clean && hexo g && hexo s` 命令重新启动本地 Hexo 服务器，打开默认地址 http://localhost:4000，即可看到 NexT 主题。

## 部署

### 部署到 GitHub Pages

准备:

- 一个和 GitHub 用户名同名的 username.github.io 的公开仓库
- [新增 SSH 密钥到 GitHub 帐户](https://docs.github.com/cn/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

#### 安装 `hexo-deployer-git` 

```bash
sudo npm install hexo-deployer-git --save
```

#### 配置 `_config.yml`

```
deploy:
  type: git
  repository: git@github.com:username/username.github.io.git
  branch: master
```

#### 部署

运行命令 `hexo d` 即可发布到 GitHub Pages 上，稍等一会儿即可通过 username.github.io 访问。

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