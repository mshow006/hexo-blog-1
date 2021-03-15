---
title: 用 Java 实现 LRU算法
categories:
  - null
tags:
  - null
comments: true
date: 2019-10-21 10:13:44
updated: 2021-03-15 12:42:01
---
## LRU 简介

LRU（Least Recently Used）,即最近最少使用。LRU是一种算法，常被应用于操作系统的内存页面置换算法（其他还有FIFO，LFU等）和缓存。

LRU算法的设计原则是：如果一个数据在最近一段时间没有被访问到，那么在将来它被访问的可能性也很小。也就是说，当限定的空间已存满数据时，应当把最久没有被访问到的数据淘汰。

<!-- more -->

## 实现思路

LRU 常用的实现思路是使用 双向链表 + HashMap 的数据结构。链表可以维护数据的有序性，方便数据的插入删除。而HashMap可以使查找删除操作时间复杂度为O（1）。

- 访问某个节点时，将其从原来的位置删除，并重新插入到链表头部。这样就能保证链表尾部存储的就是最近最久未使用的节点，当节点数量大于缓存最大空间时就淘汰链表尾部的节点。
- 为了使删除操作时间复杂度为 O(1)，就不能采用遍历的方式找到某个节点。HashMap 存储着 Key 到节点的映射，通过 Key 就能以 O(1) 的时间得到节点，然后再以 O(1) 的时间将其从双向队列中删除。

## 代码实现

```java
package lru;

import java.util.HashMap;
import java.util.Iterator;

/**
 * Created by yingming006 on 2019-09-18 08:47.
 */
public class LRU<K, V> implements Iterable {

    private Node head;
    private Node tail;
    private HashMap<K, Node> map;
    private int maxSize;

    private class Node {
        Node pre;
        Node next;
        K k;
        V v;

        Node(K k, V v) {
            this.k = k;
            this.v = v;
        }
    }

    public LRU(int maxSize) {
        this.maxSize = maxSize;
        this.map = new HashMap<>(maxSize * 4 / 3 + 1); // HashMap 的初始化

        head = new Node(null, null);
        tail = new Node(null, null);

        head.next = tail;
        tail.pre = head;
    }

    public V get(K key) {
        if (!map.containsKey(key)) {
            return null;
        }

        Node node = map.get(key);
        unlink(node);
        appendHead(node);

        return node.v;
    }

    public void put(K key, V value) {
        if (map.containsKey(key)) {
            Node node = map.get(key);
            unlink(node);
        }

        Node node = new Node(key, value);
        map.put(key, node);
        appendHead(node);

        if (map.size() > maxSize) {
            Node toRemove = removeTail();
            map.remove(toRemove.k);
        }
    }

    private void unlink(Node node) {
        Node pre = node.pre;
        Node next = node.next;

        pre.next = next;
        next.pre = pre;

        node.next = null;
        node.pre = null;
    }

    private void appendHead(Node node) {
        Node next = head.next;
        node.next = next;
        next.pre = node;
        node.pre = head;
        head.next = node;
    }

    private Node removeTail() {
        Node node = tail.pre;
        Node pre = node.pre;
        tail.pre = pre;
        pre.next = tail;

        node.next = null;
        node.pre = null;
        return node;
    }

    @Override
    public Iterator<K> iterator() {
        return new Iterator<K>() {
            private Node cur = head.next;

            @Override
            public boolean hasNext() {
                return cur != tail;
            }

            @Override
            public K next() {
                Node node = cur;
                cur = cur.next;
                return node.k;
            }
        };
    }
}
```
