---
title: mysql-note
categories:
  - tech
tags:
  - mysql
comments: true
date: 2019-10-21 10:12:24
updated: 2021-03-15 12:44:02
---
## 1. 数据库（DATABASE）的创建、删除、修改和查看

### 创建数据库：

```mysql
CREATE DATABASE [IF NOT EXISTS] <数据库名>
	[[DEFAULT] CHARACTER SET <字符集名>] [[DEFAULT] COLLATE <校对规则名>];
```

<!-- more -->

示例：

```mysql
-- 创建一个数据库，命名为 test_db_char，指定其默认字符集为 utf8，默认校对规则为 utf8_chinese_ci（简体中文，不区分大小写）
CREATE DATABASE IF NOT EXISTS test_db_char
	DEFAULT CHARACTER SET utf8
	DEFAULT COLLATE utf8_chinese_ci;
```

### 删除数据库： 

`DROP DATABASE [ IF EXISTS ] <数据库名> `

示例：`DROP DATABASE IF EXISTS test_db_del;`

### 修改数据库：

```mysql
ALTER DATABASE [数据库名] { [ DEFAULT ] CHARACTER SET <字符集名> |
	[ DEFAULT ] COLLATE <校对规则名>}
```

示例：

```mysql
-- 将数据库 test_db_char 的指定字符集修改为 gb2312，默认校对规则修改为 utf8_unicode_ci
ALTER DATABASE test_db_char
	DEFAULT CHARACTER SET gb2312
	DEFAULT COLLATE gb2312_chinese_ci;
```

### 查看数据库：

` SHOW DATABASES [LIKE '数据库名']; `

## 2. 数据类型

- 数字类型
  - 整数:  **TINYINT**、SMALLINT、MEDIUMINT、**INT**、**BIGINT** 
  - 浮点数: FLOAT 和 DOUBLE 
  - 定点数： **DECIMAL** 
- 日期和时间:  YEAR、TIME、DATE、DATETIME 和 **TIMESTAMP** 
- 字符串类型：**CHAR**、**VARCHAR**、BINARY、VARBINARY、BLOB、**TEXT**、ENUM 和 SET 
- 二进制(可用来存储图片、音乐等):  BIT、BINARY、VARBINARY、TINYBLOB、BLOB、MEDIUMBLOB 和 LONGBLOB 

### 数字类型

#### 整型

| type      | Storage | Signed（Unsigned）                                           |
| --------- | ------- | ------------------------------------------------------------ |
| TINYINT   | 1 Bytes | -128~127（255）                                              |
| SMALLINT  | 2 Bytes | -32768~32767（65535）                                        |
| MEDIUMINT | 3 Bytes | -8388608~8388607（16777215）                                 |
| INT       | 4 Bytes | -2147483648~2147483647（4294967295）（大约42亿）             |
| BIGINT    | 8 Bytes | -9223372036854775808〜9223372036854775807（18446744073709551615） |

#### 浮点型和定点型

| 属性          | 存储空间  | 可做精确计算 |
| ------------- | --------- | ------------ |
| FLOAT(M, D)   | 4 bytes   | 否           |
| DOUBLE(M, D)  | 8 bytes   | 否           |
| DECIMAL(M, D) | M+2 bytes | 是           |

> M表示该值的总共长度, D表示小数点后面的长度, M和D又称为精度和标度；
>
> 不论是定点还是浮点类型，如果用户指定的精度超出精度范围，则会四舍五入进行处理；
>
> 如float(7,4), 最大可存入-999.9999, 如果尝试存入999.00009, 则存入结果为999.0001

### 时间类型

| 类型名称  | 日期格式            | 日期范围                                          | 存储需求 |
| --------- | ------------------- | ------------------------------------------------- | -------- |
| YEAR      | YYYY                | 1901 ~ 2155                                       | 1 个字节 |
| TIME      | HH:MM:SS            | -838:59:59 ~ 838:59:59                            | 3 个字节 |
| DATE      | YYYY-MM-DD          | 1000-01-01 ~ 9999-12-3                            | 3 个字节 |
| DATETIME  | YYYY-MM-DD HH:MM:SS | 1000-01-01 00:00:00 ~ 9999-12-31 23:59:59         | 8 个字节 |
| TIMESTAMP | YYYY-MM-DD HH:MM:SS | 1970-01-01 00:00:01 UTC ~ 2038-01-19 03:14:07 UTC | 4 个字节 |

### 字符串类型

| 类型    | 长度         |
| ------- | ------------ |
| CHAR    | 0-255字节    |
| VARCHAR | 0-65535 字节 |
| TEXT    | 0-65 535字节 |

>- （1）**char**:  定长格式，但是长度范围是 0~255. 当你想要储存一个长度不足 255 的字符时，Mysql 会用空格来填充剩下的字符。因此在读取数据时，char 类型的数据要进行处理，把后面的空格去除。
-  （2）**varchar**:  关于 varchar，有的说最大长度是 255，也有的说是 65535，查阅很多资料后发现是这样的：varchar 类型在 5.0.3 以下的版本中的最大长度限制为 255，而在 5.0.3 及以上的版本中，varchar 数据类型的长度支持到了 65535，也就是说可以存放 65532 个字节（注意是字节而不是字符！！！）的数据（起始位和结束位占去了3个字节），也就是说，在 5.0.3 以下版本中需要使用固定的 TEXT 或 BLOB 格式存放的数据可以在高版本中使用可变长的 varchar 来存放，这样就能有效的减少数据库文件的大小。
-  （3）**text**: 与 char 和 varchar 不同的是，text 不可以有默认值，其最大长度是 2 的 16 次方-1
>
>**总结起来，有几点：**
>
>-  经常变化的字段用 varchar
>-  知道固定长度的用 char
>-  尽量用 varchar
>-  超过 255 字符的只能用 varchar 或者 text
>-  能用 varchar 的地方不用 text
>
>**该部分引用自[菜鸟教程]( https://www.runoob.com/mysql/mysql-data-types.html )**

## 3.数据表（TABLE）的创建、删除、修改和查看

### 创建数据表：

` CREATE TABLE <表名> ([表定义选项])[表选项][分区选项]; `

 其中，`[表定义选项]`的格式为：  `<列名1> <类型1> [,…] <列名n> <类型n> `

示例：

```mysql
CREATE TABLE IF NOT EXISTS `runoob_tbl`(
	`runoob_id` INT UNSIGNED AUTO_INCREMENT,
	`runoob_title` VARCHAR(100) NOT NULL DEFAULT 'RUNOOB_TITLE',
	`runoob_author` VARCHAR(40) NOT NULL DEFAULT 'RUNOOB_AUTHOR',
	`runoob_context` TEXT NULL,
	`submission_date` DATE,
	PRIMARY KEY ( `runoob_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

- AUTO_INCREMENT定义列为自增的属性，一般用于主键，数值会自动加1。
- PRIMARY KEY关键字用于定义列为主键。 您可以使用多列来定义主键，列间以逗号分隔。
- ENGINE 设置存储引擎，CHARSET 设置编码。

### 删除数据表：

` DROP TABLE [IF EXISTS] <表名> [ , <表名1> , <表名2>] … `

示例：`DROP TABLE IF EXISTS runoob_tbl`

### 修改数据表：

`ALTER TABLE <表名> [修改选项] `

修改选项的语法格式如下：

```mysql
{ ADD COLUMN <列名> <类型>
| CHANGE COLUMN <旧列名> <新列名> <新列类型>
| ALTER COLUMN <列名> { SET DEFAULT <默认值> | DROP DEFAULT }
| MODIFY COLUMN <列名> <类型>
| DROP COLUMN <列名>
| RENAME TO <新表名> }
```

#### 添加字段：

` ALTER TABLE <表名> ADD <新字段名> <数据类型> [约束条件] [FIRST|AFTER 已存在的字段名]； `

示例：

```mysql
-- 修改表 tb_emp1 的结构，在表的第一列添加一个 int 类型的字段 col1
ALTER TABLE tb_emp1
	ADD COLUMN col1 INT FIRST;
```

> 提示：“FIRST 或 AFTER 已存在的字段名”用于指定新增字段在表中的位置，如果 SQL 语句中没有这两个参数，则默认将新添加的字段设置为数据表的最后列。 

#### 删除字段：

` ALTER TABLE <表名> DROP <字段名>； `

示例：

```mysql
-- 修改表 tb_emp1 的结构，删除 col2 字段
ALTER TABLE tb_emp1
	DROP col2;
```


#### 修改字段数据类型：

`ALTER TABLE <表名> MODIFY <字段名> <数据类型>`

示例：

```mysql
-- 修改表 tb_emp1 的结构，将 name 字段的数据类型修改成 VARCHAR(30)
ALTER TABLE tb_emp1
	MODIFY name VARCHAR(30);
```

#### 修改字段名称：

`ALTER TABLE <表名> CHANGE <旧字段名> <新字段名> <新数据类型>； `

示例：

```mysql
-- 修改表 tb_emp1 的结构，将 col1 字段名称改为 col3，同时将数据类型变为 CHAR(30)
ALTER TABLE tb_emp1
	CHANGE col1 col3 CHAR(30);
```

>  如果不需要修改字段的数据类型，可以将新数据类型设置成与原来一样，但数据类型不能为空 

#### 修改表名：

` ALTER TABLE <旧表名> RENAME [TO] <新表名>； `

示例：

```mysql
ALTER TABLE tb_emp1
	RENAME TO tb_emp2;
```

### 查看数据表结构：

`DESC <表名>;`

```mysql
mysql> desc tbl;
+-----------------+------------------+------+-----+---------------+----------------+
| Field           | Type             | Null | Key | Default       | Extra          |
+-----------------+------------------+------+-----+---------------+----------------+
| test            | int(11)          | YES  |     | NULL          |                |
| runoob_id       | int(10) unsigned | NO   | PRI | NULL          | auto_increment |
| runoob_title    | varchar(100)     | NO   |     | RUNOOB_TITLE  |                |
| runoob_author   | varchar(40)      | NO   |     | RUNOOB_AUTHOR |                |
| runoob_context  | text             | YES  |     | NULL          |                |
| submission_date | date             | YES  |     | NULL          |                |
+-----------------+------------------+------+-----+---------------+----------------+
```

查看表结构：

`SHOW CREATE TABLE <表名>;`


## 4.数据表（TABLE）的查询

### MySQL SELECT 基本语法

```mysql
SELECT
{* | <字段列名>}
[
FROM <表 1>, <表 2>…
[WHERE <表达式>
[GROUP BY <group by definition>
[HAVING <expression> [{<operator> <expression>}…]]
[ORDER BY <order by definition>]
[LIMIT[<offset>,] <row count>]
]
```

- `{*|<字段列名>}`包含星号通配符的字段列表，表示查询的字段，其中字段列至少包含一个字段名称，如果要查询多个字段，多个字段之间要用逗号隔开，最后一个字段后不要加逗号。
- `FROM <表 1>，<表 2>…`，表 1 和表 2 表示查询数据的来源，可以是单个或多个。
- WHERE 子句是可选项，如果选择该项，将限定查询行必须满足的查询条件。
- `GROUP BY< 字段 >`，该子句告诉 MySQL 如何显示查询出来的数据，并按照指定的字段分组。
- `HAVING <表达式>`，该子句用于指定一组行或聚合的过滤条件，通常和`GROUP BY`一起使用。
- `[ORDER BY< 字段 >]`，该子句告诉 MySQL 按什么样的顺序显示查询出来的数据，可以进行的排序有升序（ASC）和降序（DESC）。
- `[LIMIT[，]]`，该子句告诉 MySQL 每次显示查询出来的数据条数。

### 1. 数据检索（SELECT）

```mysql
-- 检索单个列
SELECT prod_name FROM products;
-- 检索多个列
SELECT prod_id, prod_name, prod_price FROM products;
-- 检索所有列
SELECT * FROM products;
-- 检索不同的行(去重)
SELECT DISTINCT vend_id FROM products;
-- 限制结果(LIMIT)
SELECT prod_name FROM products LIMIT 5;
-- 使用完全限制的表名,列名
SELECT products.prod_name FROM crashcourse.products;
```

### 2. 数据排序（ORDER BY）

```mysql
SELECT 
   select_list
FROM 
   table_name
ORDER BY 
   column1 [ASC|DESC], 
   column2 [ASC|DESC],
   ...;
```

### 3. 数据过滤（WHERE）

```mysql
SELECT 
    select_list
FROM
    table_name
WHERE
    search_condition;
```

| 比较运算符                | 说明                               |
| ------------------------- | ---------------------------------- |
| =                         | 等于                               |
| <                         | 小于                               |
| <=                        | 小于等于                           |
| >                         | 大于                               |
| >=                        | 大于等于                           |
| <=>                       | 安全的等于，不会返回 UNKNOWN       |
| <> 或!=                   | 不等于                             |
| IS NULL 或 ISNULL         | 判断一个值是否为 NULL              |
| IS NOT NULL               | 判断一个值是否不为 NULL            |
| LEAST                     | 当有两个或多个参数时，返回最小值   |
| GREATEST                  | 当有两个或多个参数时，返回最大值   |
| BETWEEN value1 AND value2 | 判断一个值是否落在两个值之间       |
| IN                        | 判断一个值是IN列表中的任意一个值   |
| NOT IN                    | 判断一个值不是IN列表中的任意一个值 |
| LIKE                      | 通配符匹配                         |
| REGEXP                    | 正则表达式匹配                     |

### 4. 数据分组（GROUP BY 和 HAVING）

```MYSQL
-- 检索总计订单价格大于等于50的订单号和总计订单的价格，按总计订单价格排序。
-- GROUP BY 子句按订单号分组数据，以便SUM(*)函数能够返回总计订单价格
-- HAVING 子句过滤数据，只返回总计订单价格大于等于50的订单
-- ORDER BY 子句排序输出
SELECT order_num, SUM(quantity * item_price) AS ordertotal
FROM orderitems
GROUP BY order_num
HAVING SUM(quantity * item_price) >= 50;
ORDER BY ordertotal;
```

> **HAVING 和 WHERE 的差别**
>
> WHERE 在数据分组前进行过滤，HAVING 在数据分组后进行过滤。