---
title: 【JVM 笔记】Java对象模型
categories:
  - tech
tags:
  - jvm
comments: true
date: 2019-04-29 20:31:43
updated: 2021-03-15 13:16:35
---
Java 对象模型实际上是说 Java 对象在虚拟中的表示机制。比如对象在内存中的存储结构，以及对象在 JVM 内部的表示方式等。

### Java 对象在内存中的结构

- 对象头（Header） 

  1. 对象自身的运行时数据（Mark Word）：存储哈希码、GC 分代年龄、锁状态标志、线程持有的锁、偏向线程 ID、偏向时间戳等。

     synchronized 用的锁就是存在 Mark Word 中，在运行期间，Mark Word 里存储的数据会随着锁标志位的变化而变化，会有以下五种变化。**注意无锁态和偏向锁的锁标志位相同，额外增加了一个字节来判断。**

<!-- more -->

    ![32 位虚拟机中储存空间分布](https://img-blog.csdnimg.cn/20190506211243911.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)
>  在 32 位的 HotSpot 虚拟机 中对象未被锁定的状态下，Mark Word 的32个Bits空间中的25Bits用于存储对象哈希码（HashCode），4Bits 用于存储对象分代年龄，2Bits 用于存储锁标志位，1Bit 固定为 0，表示非偏向锁。

  2. 类型指针（Class Metadata Address）：用来确定该对象是哪个类的实例。

  3. 数组长度（Array length）：仅存在于数组对象对象中。

- 实例数据（Instance Data）

  - 存储对象的各种类型的字段内容（包括从父类继承的）。

- 对齐填充（Padding）

  - 对齐数据不是必然存在的，只起占位符的作用，没有特别的含义。

下图是普通对象实例与数组对象实例在 JVM 中的结构：

[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-V4Bdnuws-1615785398841)(https://ask.qcloudimg.com/http-save/yehe-1345101/4ilhtfzhes.jpeg?imageView2/2/w/1620)]

### OOP-Klass 二分模型

什么是 OPP-Klass 二分模型？

OOP-Klass 二分模型是 HotSpot 为 Java 对象在虚拟机中的表示所设计的一套模型。

- OOP（ordinary object pointer 或者 OOPS）指的是普通对象指针，来描述对象的实例信息。
- Klass：包含元数据和方法信息，描述 Java 类，也就是对象实例的具体类型。

### 对象在内存中的存储

简单来说就是：对象存储在堆上，对象的引用存储在栈上。

不简单的说法是：

> 对象的实例（instantOopDesc)保存在堆上，对象的元数据（instantKlass）保存在方法区，对象的引用保存在栈上。

方法区用于存储虚拟机加载的类信息、常量、静态变量、即时编译器编译后的代码等数据（也就是元数据）。

举个例子：

```java
class Model
{
    public static int a = 1;
    public int b;

    public Model(int b) {
        this.b = b;
    }
}

public static void main(String[] args) {
    int c = 10;
    Model modelA = new Model(2);
    Model modelB = new Model(3);
}
```

上述代码在 JVM 中的存储结构：

![Java对象在内存中的存储结构](https://img-blog.csdnimg.cn/img_convert/869ff88510014460bbe8ed486f6fc17f.png)

### 对象在 JVM 中的简单实现

每一个 Java 类，在被 JVM 加载的时候，JVM 会给这个类创建一个`instanceKlass`（对象所对应的类型），保存在方法区，用来在 JVM 层表示该 Java 类。

当我们在 Java 代码中，使用 `new` 创建一个对象的时候，JVM 会创建一个`instanceOopDesc`（描述 Java 类的实例） 对象，这个对象包含两部分信息：对象头和元数据。

对象头中包含了运行时数据，元数据其实就是指向描述类型的 Klass 对象（之前创建的 `instanceKlass`）的指针。


> 本文所有描述都是基于 HotSpot，图片出处来自水印
>
> 参考资料：
>
> 《Java 并发编程的艺术》
>
> 《HotSpot 实战》
>
> [深入理解多线程（二）—— Java的对象模型](https://www.hollischuang.com/archives/1910)
>
> [深入理解多线程（三）—— Java的对象头](https://www.hollischuang.com/archives/1953)
>
> [Java对象结构【面试+工作】](https://cloud.tencent.com/developer/article/1350269)