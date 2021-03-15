---
title: MySQL用户管理-创建、授权、查看、删除
categories:
  - tech
tags:
  - mysql
comments: true
date: 2019-12-18 19:05:26
updated: 2021-03-15 12:29:56
---

### 测试环境

- 服务器版本：WSL 2 Ubuntu 18.04

- MySQL版本：5.7.28-0ubuntu0.18.04.4 (Ubuntu)

在开始之前，请确保服务器已安装 MySQL，并拥有 root 权限。

<!-- more -->

### 创建一个新的用户账号

MySQL 中的用户账号是由用户名和主机名组成，例如`'root'@'localhost'`。

运行以下命令即可创建一个用户名为`database_user`，密码为`user_password`的用户：

```mysql
mysql> CREATE USER '`database_user`'@'localhost' IDENTIFIED BY '`user_password`';
```

上述命令中，主机名为`localhost`，表示只能从本地主机（即运行该 MySQL Server 的服务器），如果要授予该用户来自其他主机的访问权限，只需将`localhost`改为远程登录 IP 或者 `%`，`%`表示通配符，意味着该用户能够从任何主机进行远程连接。 

如果不确定用户是否存在，可以使用以下命令：

```mysql
mysql> CREATE USER IF NOT EXISTS '`database_user`'@'localhost' IDENTIFIED BY '`user_password`';
```

### 修改MySQL用户密码

其实不同的 MySQL 版本修改用户密码的命令是不一样的。

在终端执行` mysql --version`可以查看 MySQL 版本。

如果是  MySQL 5.7.6 + 或者  MariaDB 10.1.20 +，需要使用以下命令来更改：

```mysql
mysql> ALTER USER 'database_user'@'localhost' IDENTIFIED BY 'new_password';
```

如果是  MySQL 5.7.5 - 或者  MariaDB 10.1.20 -，则需要使用以下命令来更改：

```mysql
mysql> SET PASSWORD FOR 'database_user'@'localhost' = PASSWORD('new_password');
```

### 查看所有MySQL用户账号

MySQL 中用户账户的全部信息都保存在`mysql.user`表中。

使用以下命名查看`mysql.user`表结构：

```mysql
mysql> DESC mysql.user;
```

可以看到结构如下：

<img src="https://i.loli.net/2019/12/18/AWn9bm2tR48vLoT.png" >

查看用户账号信息：

```mysql
mysql> SELECT user, host FROM mysql.user;
```

结果和以下内容相似：

```bash
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| database_user    | %         |
| database_user    | localhost |
| debian-sys-maint | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
| root             | localhost |
+------------------+-----------+
6 rows in set (0.00 sec)
```

### 删除MySQL用户账号

```mysql
mysql> DROP USER IF EXISTS 'database_user'@'localhost';
```

### 给MySQL用户授权

 MySQL支持的权限的完整列表 [点这里]( https://dev.mysql.com/doc/refman/5.7/en/grant.html )。

这里介绍几个常用的例子。

授予指定用户所有权限：

```mysql
mysql> GRANT ALL PRIVILEGES ON database_name.* TO 'database_user'@'localhost';
```

授予所有用户所有权限：

```mysql
mysql> GRANT ALL PRIVILEGES ON *.* TO 'database_user'@'localhost';
```

授予指定用户对指定表所有权限：

```mysql
mysql> GRANT ALL PRIVILEGES ON database_name.table_name TO 'database_user'@'localhost';
```

授予指定用户对指定表的指定权限：

```mysql
mysql> GRANT SELECT, INSERT, DELETE ON database_name.* TO database_user@'localhost';
```

### 撤销MySQL用户权限

撤销用户所有权限：

```mysql
mysql> REVOKE ALL PRIVILEGES ON database_name.* TO 'database_user'@'localhost';
```

### 显示MySQL用户权限

```mysql
mysql> SHOW GRANTS FOR 'database_user'@'localhost';
```

<img src="https://i.loli.net/2019/12/18/xcUtA1OnaCZWd4j.png" >

### 总结

该教程总结了 MySQL 用户的基本管理实例，如果向了解更多，请参考 [MySQL 5.7 官方文档]( https://dev.mysql.com/doc/refman/5.7/en/ )。

感谢：[How to Manage MySQL Databases and Users from the Command Line]( https://linuxize.com/post/how-to-manage-mysql-databases-and-users-from-the-command-line/ )


 