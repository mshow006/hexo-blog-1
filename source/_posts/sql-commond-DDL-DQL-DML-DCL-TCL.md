---
title: SQL命令:DDL,DQL,DML,DCL和TCL
categories:
  - tech
tags:
  - sql
comments: true
date: 2019-11-20 22:51:03
updated: 2021-03-15 12:37:24
---

<img src="https://i.loli.net/2019/11/14/ptPu9y2gIsFjl7U.png" >

SQL 是一种数据库查询和程序设计语言，用于存取数据以及查询、更新和管理关系数据库系统。 SQL使用某些命令（例如，创建，删除，插入等）来执行所需的任务。 

<!-- more -->

SQL 命令主要由以下几类：

- DDL – Data Definition Language
- DQl – Data Query Language
- DML – Data Manipulation Language
- DCL – Data Control Language
- TCL – Transaction Control Language 


### 1. DDL – Data Definition Language

DDL：创建和修改数据库中[数据库对象]( https://www.geeksforgeeks.org/database-objects-in-dbms/ )（Table ,  View 等）结构。

- CREATE： 在数据库中创建对象

  创建数据库：` CREATE DATABASE IF NOT EXISTS test_db;`

- DROP： 从数据库中删除对象

  删除数据库：` DROP DATABASE IF NOT EXISTS test_db;` 

- ALTER： 修改数据库对象

  修改数据表：`ALTER TABLE tb_emp1 ADD COLUMN col1 INT FIRST;`（在表的第一列添加一个 int 类型的字段 col1 ）

- TRUNCATE：从表中删除所有记录

  `TRUNCATE TABLE  table_name;`

- COMMETN：添加注释

- RENAME：重命名数据库中的表名，字段名

### 2. DQL -  **Data Query Language** 

DQL ：用于用于从数据库查询数据。 

- SELECT

### 3. DML - Data Manipulation Language

DML：  用于在添加（插入），删除和修改（更新）数据 。

- INSERT：插入数据
- UPDATE：更新数据
- DELETE：删除数据

### 4. DCL – Data Control Language

DCL： 授权，角色控制等。

- GRANT：为用户赋予访问权限
- REVOKE：撤回授权权限

### 5. TCL – Transaction Control Language

TCL：处理数据库中的事务。

- COMMIT：提交一个事务

- SAVEPOINT：在事务中设置保存点，可以回滚到此保存点

- ROLLBACK：回滚事务

- SET TRANSACTION：改变事务选项



参考：[SQL|DDL,DQL,DML,DCL and TCL Commands - GeeksforGeeks](https://www.geeksforgeeks.org/sql-ddl-dql-dml-dcl-tcl-commands/)