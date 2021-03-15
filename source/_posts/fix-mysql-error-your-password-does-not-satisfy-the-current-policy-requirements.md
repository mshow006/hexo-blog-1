---
title: 解决 MySQL-Error:Your password does not satisfy the current policy requirements
categories:
  - tech
tags:
  - mysql
comments: true
date: 2019-08-30 21:20:31
updated: 2021-03-15 12:45:46
---
### 背景

MySQL版本：Server version: 5.7.27-0ubuntu0.18.04.1 (Ubuntu)

### 前言

今天打算在MySQL创建用户时遇到了下面这个错误：

```mysql
mysql> CREATE USER IF NOT EXISTS 'yingming006'@'%' IDENTIFIED BY 'yingming006';
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements
```

这是因为MySQL默认的密码策略问题，输入以下命令查看当前的密码策略设置

<!-- more -->

```mysql
SHOW VARIABLES LIKE 'validate_password%'
```

```bash
+--------------------------------------+--------+
| Variable_name                        | Value  |
+--------------------------------------+--------+
| validate_password_check_user_name    | OFF    |
| validate_password_dictionary_file    |        |
| validate_password_length             | 8      |
| validate_password_mixed_case_count   | 1      |
| validate_password_number_count       | 1      |
| validate_password_policy             | MEDIUM |
| validate_password_special_char_count | 1      |
+--------------------------------------+--------+
7 rows in set (0.01 sec)
```

参数说明：

- validate_password_check_user_name :用户名检测，默认关闭
- validate_password_dictionary_file :字典文件，就是要在字典规则里才能满足密码的条件。
- validate_password_length :密码的长度至少为8位
- validate_password_mixed_case_count ：密码中至少有一个大写小字母
- validate_password_number_count ：密码中至少一个数字
- validate_password_special_char_count :密码中至少一个特殊字符
- validate_password_policy :密码的安全策略 MEDIUM或者0 、LOW或者1、STRONG或者2
  LOW :策略仅测试密码长度。密码长度必须至少为8个字符。
  MEDIUM :策略添加了密码必须至少包含1个数字字符，1个小写字符，1个大写字符和1个特殊（非字母数字）字符的条件。
  STRONG :策略添加了长度为4或更长的密码子字符串不能匹配字典文件中的字词（如果已经指定）的条件。
  所以最终的密码设置策略就是：不得低于8位，而且必须至少有一个大写和一个小写字母、至少一个数字和至少的一个特殊字符组成；

在设置密码是建议的规则是：大写+小写+特殊字符+数字组成的8位以上密码

### 解决方案

根据自己的环境要求，设定适合的参数，我这里就方便测试更改了安全级别：

```mysql
mysql> SET GLOBAL validate_password_policy=LOW;
Query OK, 0 rows affected (0.00 sec)
```

再试一下：

```mysql
mysql> CREATE USER IF NOT EXISTS 'yingming006'@'%' IDENTIFIED BY 'yingming006';
Query OK, 0 rows affected (0.01 sec)
```

解决！