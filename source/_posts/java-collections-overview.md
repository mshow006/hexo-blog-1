---
title: 【Java基础】Java集合框架（一）概览
categories:
  - tech
tags:
  - java
comments: true
date: 2021-03-15 12:56:55
updated: 2021-03-15 12:56:55
---

![Java集合框架](https://img-blog.csdnimg.cn/20190515130837158.gif)

从图中可以看出，Java集合框架主要包括两种类型的容器，一种是**Collection**，存储对象的集合，另一种是**Map**，存储键值对映射表。Collection 接口又有3种子接口，List、Set和Queue。

<!-- more -->

### Collection

![Collection](https://img-blog.csdnimg.cn/20190515130850462.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

#### List 接口

实现 List 接口的数据结构允许重复元素，可通过索引访问元素，例如 LinkedList、ArrayList、Vector

常用实现类：

- ArrayList：允许重复元素，底层数据结构可变数组。
- Vector：和 ArrayList 类似，但它是线程安全的。
- LinkedList：允许重复元素，底层数据结构双链表。

#### Set 接口

实现 Set 接口的数据结构不允许重复的元素，例如 HashSet、LinkedHashSet

常用实现类：

- HashSet：不允许重复的元素，底层数据结构 hash table。
- LinkedHashSet：不允许重复的元素，底层数据结构 hash table 与双链表。

- TreeSet：不允许重复的元素，底层数据结构红黑树。

#### Queue 接口

常用实现类：

- LinkedList：可以用它来实现双向队列。
- PriorityQueue：基于堆结构实现，可以用它来实现优先队列。

### Map

![Map](https://img-blog.csdnimg.cn/20190515130904846.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

实现 Map 接口的数据结构存储键值对，不允许重复的 key，例如 HashMap、LinkedHashMap、Hashtable

常用实现类：

- HashMap：不允许重复的 key，底层数据结构 hash table。
- HashTable：和 HashMap 类似，但它是线程安全的。
- LinkedHashMap：不允许重复的 key，底层数据结构 hash table 与双链表。
- TreeMap：不允许重复的 key，底层数据结构红黑树

> 参考文章：[一文快速了解Java集合框架 - ImportNew](http://www.importnew.com/31223.html)

