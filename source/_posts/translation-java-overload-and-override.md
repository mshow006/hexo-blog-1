---
title: 【译】【Java 基础】Java 的重载（overload）和重写（override）
categories:
  - tech
tags:
  - java
comments: true
date: 2019-03-25 23:11:47
updated: 2021-03-15 12:59:56
---
原文链接：[Overriding vs. Overloading in Java](https://www.programcreek.com/2009/02/overriding-and-overloading-in-java-with-examples/)

<img src="https://www.programcreek.com/wp-content/uploads/2009/02/overloading-vs-overriding.png">

重载（Overload）和重写（Override）是Java中两个比较重要的概念。但是对于新手来说也比较容易混淆，本文通过两个简单的例子来说明他们之间的区别。

<!-- more -->

### 1. 定义

- **重载**：在**同一个类**中，有**两个或多个**具有**相同方法名和不同的参数**的方法，称作重载。
- **重写**：在**不同类**中（指父类和子类）中，**两个**具有**相同方法名和相同参数**的方法，称作重写。

### 2. 重载 VS 重写

关于重写和重载，你应该知道的几点：

1. 重写是指在运行时，根据引用变量所指向的实际对象的类型来调用方法；重载是指在编译时根据参数变量的类型判断应该调用哪个方法。
2. 重写是和类的多态性相关的，重载则不是。
3. 重写是一个运行时概念，而重载是一个编译时的概念。

### 3. 一个重写的例子

下面是一个重写的例子，在读完代码后，可以猜一下输出。

```java
class Dog{
    public void bark(){
        System.out.println("woof ");
    }
}
class Hound extends Dog{
    public void sniff(){
        System.out.println("sniff ");
    }
 
    public void bark(){
        System.out.println("bowl");
    }
}
 
public class OverridingTest{
    public static void main(String [] args){
        Dog dog = new Hound();
        dog.bark();
    }
}
```

Output：

> bowl

在上面的例子中，`dog` 变量被声明为 `Dog` 类。在编译时，编译器检查 `Dog` 类是否具有 `bark()` 方法。只要存在 `bark()` 方法，代码就可以编译通过。在运行时，一个 `Hound` 类被实例化，并赋值给 `dog` ， JVM虚拟机明白 `dog` 变量指向 `Hound` 对象的引用，所以调用了 `Hound` 的 `bark()` 方法，这就是所谓的动态多态性。

### 4. 一个重载的例子

```java
class Dog{
    public void bark(){
        System.out.println("woof ");
    }
 
    //overloading method
    public void bark(int num){
    	for(int i=0; i<num; i++)
    		System.out.println("woof ");
    }
}
```

在上面重载的例子中，通过使用不同的参数来调用两个bark方法。编译器认为它们是不同的两个方法，因为具有不同的方法签名（方法名和参数）。