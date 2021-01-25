---
title: 遍历列表(List)时删除元素
categories:
  - tech
tags:
  - list
comments: true
date: 2021-01-25 16:07:29
updated: 2021-01-25 16:07:29
---

Java 中的 List 集合，使用寻常的 `for` 循环进行遍历时删除操作时会引起 `ConcurrentModificationException` 异常，本文主要记录一下避免引起异常的方法。

首先我们准备一个 `List`:

```java
    List<String> books = new ArrayList<>();
    books.add("C++");
    books.add("Java");
    books.add("Python");
```

## Collection#RemoveAll()

利用 `Collection#RemoveAll()` 方法，先找到要删除的对象，在完成迭代后进行删除。

```java
    String title = "Java";
    List<String> found = new ArrayList<>();
    for (String book : books) {
        if ("Java".equals(book)) {
            found.add(book);
        }
    }
    books.removeAll(found);
```

这种方式理解简单，但是有一个问题，就是我们对 `List` 遍历了两次: 第一次在 `for` 循环中找到要删除的对象，第二次是在 `books` 中找到要删除的对象并将其删除，这是非常影响效率的。

## Iterator

使用 `Iterator`