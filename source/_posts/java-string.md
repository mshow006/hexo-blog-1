---
title: 【Java 基础】String 类
categories:
  - tech
tags:
  - java
comments: true
date: 2019-04-11 20:37:43
updated: 2021-03-15 13:04:38
---
## 介绍
String 类被声明为 final，因此不可继承。

在 Java 9 之前，String 类使用 char 数组来存储；

```java
public final class String
    implements java.io.Serializable, Comparable<String>, CharSequence {
    /** The value is used for character storage. */
    private final char value[];
}
```

在 Java 9 中，String 类内部改用 byte 数组来存储，同时使用 coder 标识该字符串使用的编码方式。

<!-- more -->

```java
public final class String
    implements java.io.Serializable, Comparable<String>, CharSequence {
    /** The value is used for character storage. */
    private final byte[] value;

    /** The identifier of the encoding used to encode the bytes in {@code value}. */
    private final byte coder;
}
```

String 类内部数组被声明为 final，也就是说明 String 内数组初始化后不能在引用其他数组，同时 String 内部也不提供更改数组的方法，所以 String 类不可变。

### 不可变的好处

**1. String Pool 的需要**

如果一个 String 对象已经被创建过了，那么就会从 String Pool 中取得引用。只有 String 是不可变的，才可能使用 String Pool。

![String Pool](https://img-blog.csdnimg.cn/img_convert/bf841e5af9dc963a0973f602dfff0a70.png)

**2. 缓存 Hashcode**

因为字符串的 Hashcode 经常被使用，例如，在 HashMap 或 HashSet 中，不可变的 String 可以保证 Hashcode 总是相同，因此使用时只需计算一次。

**3. 安全性**

String 经常被用做参数，String 类的不可变可以保证参数不可变。例如，在网络连接或者打开文件等，如果 String 类是可变的，那么在打开文件传递参数时，目标文件可能就会发生改变，实际情况中是不允许的。

**4. 线程安全**

String 不可变性天生具备线程安全，可以在多个线程中安全地使用。 String 被设计为不可变是为了效率和安全。这也是在一般情况下优选不可变类的原因。

### String, StringBuffer and StringBuilder

**1. 可变性** 

- String 不可变
- StringBuffer 和 StringBuilder 可变

**2. 线程安全** 

- String 不可变，因此是线程安全的
- StringBuffer 是线程安全的，内部使用 synchronized 进行同步
- StringBuilder 不是线程安全的