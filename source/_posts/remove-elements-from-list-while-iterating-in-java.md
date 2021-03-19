---
title: 遍历列表(List)时删除元素
categories:
  - tech
tags:
  - java-collection
comments: true
date: 2021-01-25 16:07:29
updated: 2021-03-19 12:07:29
---

Java 中的 List 集合，使用寻常的 `for` 循环进行遍历时删除操作时会引起 `ConcurrentModificationException` 异常，本文主要记录一下避免引起异常的方法。

首先我们准备一个 `List`:

```java
    List<String> books = new ArrayList<>();
    books.add("C++");
    books.add("Java");
    books.add("Python");
```

## Collection#removeAll()

<!-- more -->

利用 `Collection#removeAll()` 方法，先找到要删除的对象，在完成迭代后进行删除。

```java
    List<String> found = new ArrayList<>();
    for (String book : books) {
        if ("Java".equals(book)) {
            found.add(book);
        }
    }
    books.removeAll(found);
```

这种方式理解简单，同时可以对其他的集合进行操作(`Collection`, `Set` 等)。

但是有一个问题，就是我们对 `List` 遍历了两次: 第一次在 `for` 循环中找到要删除的对象，第二次是在 `books` 中找到要删除的对象并将其删除，这是非常影响效率的。

## Iterator

使用 `Iterator` 可以在迭代中删除对象。

```java
    Iterator<String> iter = books.iterator();
    while(iter.hasNext()){
        if(iter.next().equals("Java")){
            iter.remove();
        }
    }
```

使用 `Iterator` 迭代集合时，必须保证集合是可以被迭代并且可以删除元素的，否则会抛出 `UnsupportedOperationException`。

## Collection#removeIf() (JDK >= 1.8)

`Collection#removeIf()` 使用了 `JDK 1.8` 的 `Lambda` 特性，对每一个匹配到的元素使用了 `Iterator` 的 `remove()` 方法。

```java
    books.removeIf(s -> s.equals("Java"));
```

## stream API (JDK >= 1.8)

使用 `stream` 过滤掉需要删除的元素，剩下的元素组成一个新的 `List`。

```java
    List<String> filtered = books.stream()
            .filter(b -> b.equals("Java"))
            .collect(Collectors.toList());
```

这样原始 `List` 的数据结构并未发生改变，创建了一个新的 `List`，可以方便对原始数据进行操作，显然这种方式用途更加适用需要保存原始数据。
