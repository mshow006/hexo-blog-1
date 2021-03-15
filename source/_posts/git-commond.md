---
title: Git 常用命令
categories:
  - tech
tags:
  - git
comments: true
date: 2019-05-08 21:32:42
updated: 2021-03-15 13:20:24
---

```bash
# 设置提交代码时的用户信息
$ git config [--global] user.name "[name]"
$ git config [--global] user.email "[email address]"

# 查看所有的已经做出的配置
$ git config --list
```

<!-- more -->

```bash
# 在当前目录初始化一个Git代码库
$ git init

# clone一个项目
$ git clone [url]
```

```bash
# 添加指定文件到暂存区
$ git add [file1] [file2] ...

# 添加当前目录的所有文件到暂存区
$ git add .

# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...

# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]
```

```bash
# 提交暂存区到仓库区
$ git commit -m [message]

# 提交暂存区的指定文件到仓库区
$ git commit [file1] [file2] ... -m [message]
```

```bash
# 列出所有本地分支
$ git branch

# 列出所有远程分支
$ git branch -r

# 列出所有本地分支和远程分支
$ git branch -a

# 新建一个分支，但依然停留在当前分支
$ git branch [branch-name]

# 新建一个分支，并切换到该分支
$ git checkout -b [branch]

# 合并指定分支到当前分支
$ git merge [branch]
```

```bash
# 查看历史记录 空格向下翻页 b向上翻页 q推出
$ git log
$ git log --pretty=oneline
$ git log [--oneline]
```

```bash
# 回退上一个提交版本
$ git reset --hard HEAD^
# 回退上上一个提交版本
$ git reset --hard HEAD^^
# 回退到commit_id 指定的提交版本
$ git reset --hard [commit_id]
```

```bash
# 本地库关联Github远程库
$ git remote add [shortname][url]

# 推送到远程仓库，将本地 master 分支推送到 origin 远程分支
$ git push -u origin master
```

```bash
# 从远程仓库获取最新内容，不会拉取
$ git fetch origin master
```

