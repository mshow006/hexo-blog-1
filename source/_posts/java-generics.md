---
title: 【Java基础】泛型
categories:
  - tech
tags:
  - java
comments: true
date: 2019-04-21 16:59:35
updated: 2021-03-15 13:07:25
---

## 简介
泛型其实就是值得**类型参数**

Java SE 1.5 引入泛型 `ArrayList<String> lists = new ArrayList<String>();`

Java SE 1.7 构造函数中可以省略泛型类型 `ArrayList<String> lists = new ArrayList<>();`

好处：使得程序具有更好的**可读性**和**安全性**

<!-- more -->

## 为什么使用泛型

在未使用泛型之前，需要使用 Object 变量，然后再进行强制类型转换。

实例：ArrayList 集合类

**Java SE 1.5 之前的 ArrayList**

```java
/**
 *  befor Java SE 1.5
 */
public class ArrayList extends AbstractList implements List, RandomAccess, Cloneable, Serializable
{
    ...
    Object[] elementData;
    ...
    public boolean add(Object paramObject){ ... }
    ...
    public Object get(int paramInt){ ... }
}
```

可以看到 ArrayList 类中存在一个 Object 数组，并且其中的 get() 方法中返回类型为 Object，这就使得获取一个数组中的值时必须进行强制类型转换：

```java
ArrayList files = new ArrayList();
...
String filename = (String) files.get(index);
```

另外，该方法没有检验变量类型，所以可以像 ArrayList 中添加任意类的对象：

```java
files.add(new File("..."));
```

**Java SE 1.5 与其之后的 ArrayList**

```java
public class ArrayList<E> extends AbstractList<E>
        implements List<E>, RandomAccess, Cloneable, java.io.Serializable {
    ...
    Object[] elementData;
    ...
    public boolean add(E e) { ... }
    ...
    public E get(int index) { ... }
}
```

从 Java SE 1.5 有了泛型之后，ArrayList 类有一个类型参数用来指定元素的类型：

`ArrayList<String> lists = new ArrayList<>();`

这样有着更好的可读性。并且可以进行检查，避免了插入错误类型的对象。

## 定义一个简单的泛型类并使用泛型方法

```java
public class Container<T> {
    private T value;

    public T getValue() {
        return value;
    }

    public void setValue(T value) {
        this.value = value;
    }

    public static void main(String[] args) {
        Container<String> container = new Container<>();
        container.setValue("Hello World");
        System.out.println(container.getValue());
    }
}
```

其中，`Container<T>` 就是一个泛型类，`T getValue()` 是一个泛型方法。

上面的泛型方法是定义在泛型类中的，也可定义在普通类中，格式一致。

输出：
```java
Hello World
```



## 类型变量的限定

在声明泛型类或者是泛型方法时需要对泛型加以约束。举个例子：

```java
public static <T> T min(T a, T b){
	return a.compareTo(b) > 0 ? a : b;
}
```

```

上面的方法编译不能通过，原因就是我们无法确定 Ｔ 实现了`compareTo()` 方法。

所以需要对　Ｔ　设置限定：

```
```java
 public static <T extends Comparable> T min(T a, T b){
    return a.compareTo(b) > 0 ? a : b;
}
```

这里使用 `extends` 关键字和继承的概念有点像，接近子类的概念

一个类型变量或者通配符可以有多个限定，例如：
```java
 <E extends Comparable & Serializable, K extends Serializable>
```
限定类型用`&`分隔，而`,`用来分隔类型变量

## 类型擦除

先来看一段代码：
```java
class Generic<T>{
    T value;
}

public class GenericErased {
    public static void main(String[] args) {
        Class c1 = new Generic<String>().getClass();
        Class c2 = new Generic<Integer>().getClass();
        Class c3 = Generic.class;
        System.out.println(c1 == c2);
        System.out.println(c1 == c3);
        System.out.println(c2 == c3);
    }
}
```

运行结果：
```
true
true
true
```
可以看到，`ArrayList<String>` 和 `ArrayList<Integer>` 是同一种类型。

这是因为在定义一个泛型时，自动提供了一个相应的原始类型，原始类型的名字就是删除类型参数后的泛型类型名。擦除类型变量后，替换为限定类型（无限定类型的用 Object ）。

`Generic`类的原始类型如下：
```java
class Generic<Object>{
    Object value;
}
```

## 约束性和局限性

在使用 Java 泛型时需要考虑一些限制，大多数的限制都是由类型擦除引起的。

### 1. 不能使用基本类型实例化类型参数

在 Java 泛型中，没有 `Generic<int>`，只有`Generic<Integer>`。

原因就是类型擦除。擦除之后，Generic 类含有 Object 类型的域，而 Object 不能存储 Integer。

### 2. 运行时类型查询只适用于原始类型

虚拟机中的对象总有一个特定的非泛型类型。因此，所有的类型查询只产生原始类型。

下面的测试代码是错误的：
```java
boolean a instanceof Generic<String>; // Error
boolean a instanceof Generic<T>; // Error
```

`getClass()` 方法返回的总是原始类型：

```java
class Generic<T>{
    T value;
}

public class GenericErased {
    public static void main(String[] args) {
        Class c1 = new Generic<String>().getClass();
        Class c2 = new Generic<Integer>().getClass();
        Class c3 = Generic.class;
        System.out.println(c1.toString());
        System.out.println(c2.toString());
        System.out.println(c3.toString());
    }
}
```
结果为：
```
class packagename.Generic
class packagename.Generic
class packagename.Generic
```

### 3. 不能创建泛型类型的数组

不能实例化泛型的数组，例如：

```java
Generic<String> table = new Generic<String>[10]; // Error
```

但是可以声明通配符类型的数组，然后进行类型转化：
```java
Generic<String>[] table = (Generic<String>[]) new Generic<?>[10];
```
**但是这样做的结果是不安全的**

只有一种安全有效的方法是：使用 `ArrayList:ArrayList<Generic<String>>`

### 4. 不能实例化类型变量
不能使用像`new T(...)`，`new T[...]` 或是 `T.class` 这样的表达式中的类型变量。

例如，下面的`Generic`构造器是非法的：
```java
public Generic(T t){
	t = new T();  // Error
}
```
类型擦除后，上面的代码会变为：
```java
public Generic(Object t){
  	t = new Object();
}
```
而实际情况下一般不会调用 `new Object()`。

例如：
```java
Integer t = 1;
t = new Object(); // Error
```
### 5. 泛型类型不允许静态化

不能在静态域或方法中引用类型变量。
```java
public class Generic<T>{
    private static T value;	// Error
    public static T getValue(){...} // Error
}
```
类型擦除后，只留下Generic类，不能确定具体类型，所以不允许静态化。

### 6. 不能抛出或捕获泛型类的异常

既不能抛出也不能捕获泛型类的异常。

```java
public class Problem<T> extends Exception{ ... } // Error
```
`catch` 语句中不能使用泛型：
```java
try{
    ...
} catch(T e){ // Error
    ...
}
```
但是，在异常规范中使用类型变量是允许的：
```java
public static <T extends Throwable> void doWork(T t) throws T // OK
{
    try{
        ...
    } catch (Throwable throwable){
        throw throwable;
    }
}
```

## 通配符类型

### 概念

通配符类型中，允许参数类型变化， 用`<?>`来标识。

例如 `Pair<? extends Employee>` 表示任何泛型 Pair 类型，它的类型参数是 `Employee`的子类。

### 通配符的超类型限定

`? super Manager`

### 无限定通配符
`?`
