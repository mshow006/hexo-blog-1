---
title: 【Java 基础】 Arrays 类常用方法
categories:
  - tech
tags:
  - java
comments: true
date: 2019-03-23 13:46:35
updated: 2021-03-15 12:58:46
---
Arrays 类位于 java.util 包中， 是 Java 集合框架的一部分。 Arrays 类提供了静态方法，可以对数组进行动态的创建和访问。
#### 类的层次结构：

> java.lang.Object\
    ↳ java.util.Arrays

<!-- more -->

#### Arrays 类中的常用方法  
Arrays 类中的静态方法可以用来对数组进行赋值，排序，搜索等。

##### 1. `List<T> asList(T... a)`: 

==注意：该静态方法返回的是 Arrays 的内部静态类 ArrayList ，该类继承的是 AbstractList 类，只重写了部分方法，具体细节可以查看源码==

```java
Integer[] intArr = {10, 20, 15, 22, 35};

List<Integer> list = Arrays.asList(intArr);
```

##### 2. `binarySearch()`：

==注意：该方法调用前数组必须是已排序的，并且要查找元素在数组内唯一，否则结果可能不准确==

如果找到指定元素，返回其索引值，否则返回一个负数

```java
Integer[] intArr = {1, 3, 5, 7, 9};

// 在整个数组内查找元素
System.out.println(Arrays.binarySearch(intArr, 3)); // 1
// 在指定区间内查找元素
System.out.println(Arrays.binarySearch(intArr, 2, 4, 4)); // -3
```

##### 3. `T[] copyOf(T[] original, int newLength)`：

拷贝数组，从下标 0 开始拷贝 newLength 个元素，如果超过原数组长度，会用数组类型的默认值进行填充，其底层调用了 `System.arraycopy()` 方法

```java
int[] ints = {1, 3, 5};
Integer[] integers = {1, 3, 5};

int[] newInts = Arrays.copyOf(ints, 5);
Integer[] newIntegers = Arrays.copyOf(integers, 5);
        
// [1, 3, 5, 0, 0]
System.out.println(Arrays.toString(newInts));
// [1, 3, 5, null, null]
System.out.println(Arrays.toString(newIntegers));
```

##### 4. `T[] copyOfRange(T[] original, int from, int to)`：

拷贝数组，从索引 form 开始， 到索引 to - 1 结束，如果超出原数组范围，会用数组类型的默认值进行填充，其底层调用了 `System.arraycopy()` 方法

```java
int[] ints = {1, 3, 5};

int[] newInts1 = Arrays.copyOfRange(ints, 1, 1);
int[] newInts2 = Arrays.copyOfRange(ints, 1, 5);

// []
System.out.println(Arrays.toString(newInts1));
// [3, 5, 0, 0]
System.out.println(Arrays.toString(newInts2));
```

##### 5. `boolean equals()`

比较两个数组是否相等，如果两个数组以相同顺序包含相同元素，则返回true，否则返回false。

```java
// false
System.out.println(Arrays.equals(new int[]{1, 2}, new int[]{1, 3}));
// true
System.out.println(Arrays.equals(new int[]{1, 2}, new int[]{1, 2}));
```

##### 6. `boolean deepEquals(Object[] a1, Object[] a2)`

比较两个数组是否相等，如果两个数组以相同顺序包含相同元素，则返回true，否则返回false。

但是和 equals() 方法不同的是，deepEquals() 比较的是两个 Object 类型的数组，不能比较其他类型的数组。

```java
Object[] objects1 = new Object[]{"1", "2", "3"};
Object[] objects2 = new Object[]{"1", "2", "3"};

// true
System.out.println(Arrays.deepEquals(objects1, objects2));
```

##### 7. `sort()`
对数组进行从小到大排序，默认字典序排序（ASCII）

```java
public static void main(String[] args) {
        Integer[] ints = {1, 3, 2};
        String[] strings = {"a", "b", "A", "B"};

        // [1, 2, 3]
        Arrays.sort(ints);
        // [3, 2, 1]
        Arrays.sort(ints, Collections.reverseOrder());
        // [A, B, a, b]
        Arrays.sort(strings);
        // [a, A, b, B]
        Arrays.sort(strings, String.CASE_INSENSITIVE_ORDER);
        // [b, a, B, A]
        Arrays.sort(strings, Collections.reverseOrder());
        Integer[] integers = {1, 3, 2};
        // 注意要想自定义排序规则，必须使用基本类型的包装类
        // 底层使用的是compareTo
        // 下面这个可用Collections.reverseOrder()替代
        // [3, 2, 1]
        Arrays.sort(integers, (a, b) -> {
            if (a < b) {
                return 1;
            } else if (a > b) {
                return -1;
            } else return 0;
        });
    }
```

