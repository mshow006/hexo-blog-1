---
title: 【Java基础】Java集合框架（三）Map常用实现类
categories:
  - tech
tags:
  - java
comments: true
date: 2019-05-18 21:46:49
updated: 2021-03-15 12:54:46
---
java.util.Map接口常用的实现类有HashMap、Hashtable、LinkedHashMap、TreeMap和ConcurrentHashMap，类继承关系如下图所示：
![map概览](https://img-blog.csdnimg.cn/20190518214624884.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

<!-- more -->

## HashMap

HashMap 根据键的hashCode值存储数据，大多数情况下可以直接定位到它的值，因而具有很快的访问速度，但遍历顺序却是不确定的。 最多允许一个键值为null。

JDK1.8 之前 HashMap 由 数组+链表 组成的，数组是 HashMap 的主体，链表则是主要为了解决哈希冲突而存在的（“拉链法”解决冲突）。

JDK1.8 以后在解决哈希冲突时有了较大的变化，当链表长度大于阈值（默认为 8）时，将链表转化为红黑树，以减少搜索时间。

![HashMap底层结构](https://img-blog.csdnimg.cn/20190518214506221.jpeg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

### 类的部分属性

**默认属性**：

```java
public class HashMap<K,V> extends AbstractMap<K,V> implements Map<K,V>, Cloneable, Serializable {
    // 默认的初始容量是16,必须是2的n次幂
    static final int DEFAULT_INITIAL_CAPACITY = 1 << 4;   
    // 最大容量，如果一个更大的初始化容量在构造函数中被指定，将被MAXIMUM_CAPACITY替换，必须是2的n次幂
    static final int MAXIMUM_CAPACITY = 1 << 30; 
    // 默认的加载因子
    static final float DEFAULT_LOAD_FACTOR = 0.75f;
    // 当桶(bucket)上的结点数大于这个值时会转成红黑树
    static final int TREEIFY_THRESHOLD = 8; 
    // 当桶(bucket)上的结点数小于这个值时树转链表
    static final int UNTREEIFY_THRESHOLD = 6;
    // 存储元素的数组（bucket）
    transient Node<k,v>[] table; 
}
```

**Node结构**：

```java
static class Node<K,V> implements Map.Entry<K,V> {
    final int hash; // 键的hash值，
    final K key; // 键
    V value; // 值
    Node<K,V> next; // 指向下个节点的引用
}
```

**TreeNode结构**：

```java
static final class TreeNode<K,V> extends LinkedHashMap.Entry<K,V> {
    TreeNode<K,V> parent;  // 红黑树
    TreeNode<K,V> left;
    TreeNode<K,V> right;
    TreeNode<K,V> prev;
    boolean red;
}
```

### 常用方法

#### hash(Object key)

不管增加、删除、查找键值对，都需要用到hash()方法。

```java
static final int hash(Object key) {
	int h;
	return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
```

计算位置分为三步，第一步，取key的hashCode，第二步，key的hashCode高16位异或低16位，第三步，将第一步和第二部得到的结果进行异或运算（取模）。

#### put(K key, V value)

将键值对插入map中，如果key已存在，则替换相应的value。

```java
public V put(K key, V value) {
    return putVal(hash(key), key, value, false, true);
}
// hash key的hash值
// onlyIfAbsent 如果是true，即使指定参数key在map中已经存在，也不会替换value
// evict 如果是false，数组table在创建模式中
final V putVal(int hash, K key, V value, boolean onlyIfAbsent,boolean evict) {
}
```

**putVal() 简单步骤**：

1. 如果指定参数hash在表中没有对应的桶，即为没有碰撞，直接将键值对插入到哈希表中即可。
2. 如果定位到的数组位置有元素就和要插入的 key 比较，如果key相同就直接覆盖；如果 key 不相同，就判断该节点是否是一个树节点，如果是就调用 `e = ((TreeNode<K,V>)p).putTreeVal(this, tab, hash, key, value) `将元素添加进入；如果不是就遍历链表插入，插入后判断链表是否需要转换成树。

![hashmap的插入](https://img-blog.csdnimg.cn/2019051821453831.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

#### get(Object key)

```java
public V get(Object key) {
    HashMap.Node<K,V> e;
    // 如果通过key获取到的node为null，则返回null，否则返回node的value。
    return (e = getNode(hash(key), key)) == null ? null : e.value;
}
```

#### resize()

当HashMap对象内部的数组无法装载更多的元素时，HashMap就需要扩大数组的长度，以便能装入更多的元素。当然数组是无法自动扩容的，扩容方法使用一个**新的数组代替**旧数组。

resize方法非常巧妙，因为每次扩容都是翻倍，与原来计算（n-1）&hash的结果相比，节点要么就在原来的位置，要么就被分配到“原位置+旧容量”这个位置。

## HashTable

- HashTable 和 HashMap 都实现了Map接口

- 数组 + 链表方式存储
- 默认容量：11（质数）
- put操作：首先进行索引计算 `(key.hashCode() & 0x7FFFFFFF)% table.length`；若在链表中找到了，则替换旧值，若未找到则继续。
- rehash：HashTable 的扩容，当总元素个数超过 容量 * 加载因子 时，扩容为原来 2 倍并加1并重新散列；将新元素加到链表头部
- 对修改 Hashtable 内部共享数据的方法添加了 synchronized，保证线程安全

#### HashTable 和 HashMap 的区别

- 默认容量不同，扩容大小不同
- 线程安全性：HashTable 是线程安全，给方法加锁
- 效率不同：HashTable 要慢，因为加锁

```java
public synchronized V put(K key, V value);
public synchronized V get(Object key);
public synchronized boolean contains(Object value)
public synchronized V remove(Object key);
public synchronized void clear();
```

## LinkedHashMap

LinkedHashMap继承HashMap并实现了Map接口，同时具有可预测的迭代顺序（按照插入顺序排序）。它与HashMap的不同之处在于，维护了一条贯穿其全部Entry的双向链表。

HashMap的数据结构是数组+双向链表+红黑树（since JDK1.8）。

```java
public class LinkedHashMap<K,V> 
	extends HashMap<K,V> 
	implements Map<K,V>;
```



### 常用方法

#### containsValue( Object value)

如果linkedHashMap中的键值对有一对或多对的value为参数value，返回true

```java
public boolean containsValue(Object value) {
    //遍历双向循环链表
    for (LinkedHashMap.Entry<K,V> e = head; e != null; e = e.after) {
        V v = e.value;
        if (v == value || (value != null && value.equals(v)))
            return true;
    }
    return false;
}
```

#### get( Object key)

返回指定的key对应的entry的value，如果entry为null或者value为null，则返回null

```java
public V get(Object key) {
    Node<K,V> e;
    //如果key对应的entry为null，返回null
    if ((e = getNode(hash(key), key)) == null)
        return null;
    //如果迭代顺序为按访问顺序迭代
    if (accessOrder)
        //将e插入双向链表末尾
        afterNodeAccess(e);
    //返回value
    return e.value;
}
```

### 与 HashMap 比较

相同点：

- 都是基于哈希表的实现，存储的是键值对映射。
- 都继承了AbstractMap，实现了Map、Cloneable、Serializable。
- 它们的构造函数都一样。
- 默认的容量大小是16，默认的加载因子是0.75。
- 都允许key和value为null。
- 都是线程不安全的。

不同点：

- 底层结构：HashMap是数组+链表+红黑树；LinkedHashMap是数组+链表+红黑树+双向循环链表。
- HashMap无序，LinkedHashMap有序。

## TreeMap

```java
public class TreeMap<K,V>
    extends AbstractMap<K,V>
    implements NavigableMap<K,V>, Cloneable, java.io.Serializable
```

TreeMap是基于红黑树实现的一个保证有序性的Map，继承了AbstractMap，实现了NavigableMap、Cloneable、java.io.Serializable接口。NavigableMap接口继承自SortedMap接口，意味着TreeMap中的元素是有序的。

### 与HashMap比较

**相同点**：

- 存储的是键值对映射。
- 都继承了AbstractMap，实现了Cloneable、Serializable。
- 都是非同步的，即线程不安全。

**不同点**：

- 数据结构：HashMap是数组+链表+红黑树；TreeMap是红黑树。
- HashMap无序，TreeMap有序。
- TreeMap实现了NavigableMap接口。
- 增删改查操作复杂度：HashMap是O(1)，TreeMap是O(log n)。

<!-- ## ConcurrentHashMap

HashMap的线程安全实现。

待补充。。。 -->