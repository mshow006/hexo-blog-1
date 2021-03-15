---
title: 【Java 基础】反射
categories:
  - tech
tags:
  - java
comments: true
date: 2019-04-23 17:22:41
updated: 2021-03-15 13:08:30
---
官方定义：
> Reflection enables Java code to discover information about the fields, methods and constructors of loaded classes, and to use reflected fields, methods, and constructors to operate on their underlying counterparts, within security restrictions.

大意是：
> 反射使Java代码能够获取在运行时加载类的字段、方法和构造函数的信息，并使用反射字段、方法和构造函数在安全限制内对其基础对应项进行操作。

<!-- more -->

## Java反射中的主要类

- 类： `java.lang.Class`
- 方法：`java.lang.reflect.Method`
- 字段：`java.lang.reflect.Field`
- 修饰符：`java.lang.reflect.Modifier`

测试类：
```java
public class ReflectionDemo1 {
    public String name;

    public ReflectionDemo1(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "ReflectionDemo1{" +
                "name='" + name + '\'' +
                '}';
    }
}
```

## Class 类

部分源码如下：
```java
public final class Class<T> implements java.io.Serializable, GenericDeclaration, Type, AnnotatedElement {
	private Class(ClassLoader loader) {
		...
    }
    ...
}
```
可以看到 Class类 的构造器是私有的，也就是说 Class 类的实例对象只能由 Java 虚拟机创建，而不能在代码中显式的创建一个 Class 对象。


### 获取Class的三种方式

- 通过类名：`ClassName.class`;
- 通过类的对象：`ObjectName.getClass()`;
- 通过`Class.forName()`

```java
public static void main(String[] args) {

    // 通过类名获取Class
    Class clazz1 = ReflectionDemo1.class;
    // 通过实例对象获取Class
    ReflectionDemo1 demo1 = new ReflectionDemo1("demo1");
    Class clazz2 = demo1.getClass();
    // 通过Class.forName()
    Class clazz3 = null;
    try {
	    clazz3 = Class.forName("reflection.ReflectionDemo1");
    } catch (ClassNotFoundException e) {
	    e.printStackTrace();
    }

    System.out.println("clazz1 == clazz2 : " + (clazz1 == clazz2));
    System.out.println("clazz1 == clazz3 : " + (clazz1 == clazz3));
}
```
运行结果：
```
clazz1 == clazz2 : true
clazz1 == clazz3 : true
```
### 通过获取的 Class 创建对象实例

- 必须有无参构造器

```java
ReflectionDemo1 demo2 = (ReflectionDemo1) clazz1.newInstance();
```

### 静态加载类和动态加载类

- 静态加载：通过`new`创建的对象的方式
- 动态加载：通过`Class.forName()`创建对象的方式

二者的区别在于静态加载在编译时就需要加载类的信息（类必须存在），而动态加载在编译时不必知道类的信息。

例子：
假设现在有一个程序入口如下：
```java
public class StaticAndDynamicClassTest {
    public static void main(String[] args) {
        if("Read".equals(args[0])){
            Read r = new Read();
            r.start();
        }
        if("Write".equals(args[0])){
            Write w = new Write();
            w.start();
        }
    }
}
```
但是并没有声明"A"和"B"的类，此时编译就会报错
[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-dJEewpCq-1615784895896)(https://i.loli.net/2019/04/23/5cbec71b8e786.png)]

这里就会想，我们并不一定会用到该程序的所有方法，但是在编译时，要求加载所有用到的类。这就是静态加载导致的问题。

而我们想要是我们需要那个功能就加载那个类，不用的类不需要加载。这就是动态加载。

使用动态加载时，我们需要实现一个公共的接口，来避免强制类型转换过程中出现问题。

```java
public class StaticAndDynamicClassTest {
    public static void main(String[] args) {
        try {
            Class clazz = Class.forName(args[0]);
            Operation operation = (Operation) clazz.newInstance();
            operation.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

class Read implements Operation {

    @Override
    public void start() {
        System.out.println("Read...");
    }
}

class Write implements Operation {

    @Override
    public void start() {
        System.out.println("Write...");
    }
}

interface Operation {
    void start();
}
```
- 功能型的类尽量使用动态加载。

## Method 类

通过 Method 的方法，可以获取类的成员方法。
```java
public static void getClassMethodInfo(Object obj) {
        Class clazz = obj.getClass();
        System.out.println("类的名称：" + clazz.getName());

        // 在类中，一个成员方法就是一个Method对象
        // getMethods() 获取所有的 public 函数，包括父类继承来的
        // getDeclareMethods() 获取该类自己的所有函数，不限访问权限
        // getReturnType() 获取方法的返回类型
        System.out.println("类的成员方法：");
        Method[] methods = clazz.getMethods();
        for (Method method : methods) {
            System.out.print(method.getReturnType().getName() + " " + method.getName() + " (");
            Class[] paramTypes = method.getParameterTypes();
            for (int i = 0; i < paramTypes.length; i++) {
                System.out.print(paramTypes[i].getName());
                if (i < paramTypes.length - 1) {
                    System.out.print(", ");
                }
            }
            System.out.println(")");
        }
    }
```

测试：
```java
Class clazz4 = Class.forName("reflection.ReflectionDemo1");
ReflectionDemo1 demo3 = (ReflectionDemo1) clazz4.newInstance();
ClassMethodDemo.getClassMethodInfo(demo3);
```

输出：
```
类的名称：reflection.ReflectionDemo1
类的成员方法：
java.lang.String toString ()
java.lang.String getName ()
void setName (java.lang.String)
void wait ()
void wait (long, int)
void wait (long)
boolean equals (java.lang.Object)
int hashCode ()
java.lang.Class getClass ()
void notify ()
void notifyAll ()
```
更多方法：
```java
method.getModifiers(); // 获取方法修饰符的int值
method.isBridge(); // 判断是否是桥方法
method.isVarArgs(); // 判断是否使用了可变参数
method.getParameterCount(); // 获取参数个数
...
```
通过 Method 调用方法：
```java
method.invoke(Object obj, Object... args);
```


## Field类

通过 Field 的方法，可以获取类的成员变量的操作。
```java
public static void getClassFieldInfo(Object obj) {
        Class clazz = obj.getClass();
        System.out.println("类的名称：" + clazz.getName());

        // getFields() 获取所有的 public 成员变量
        // getDeclareFields() 获取该类自己的所有成员变量
        System.out.println("类的成员变量：");
        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            Class fieldType = field.getType();
            String typeName = fieldType.getTypeName();
            String fieldName = fieldType.getName();
            System.out.println(typeName + " " + fieldName);
        }
    }
```

测试：
```java
Class clazz5 = Class.forName("reflection.ReflectionDemo1");
ReflectionDemo1 demo4 = (ReflectionDemo1) clazz5.newInstance();
ClassMethodDemo.getClassMethodInfo(demo4);
```
输出：
```java
类的名称：reflection.ReflectionDemo1
类的成员变量：
java.lang.String java.lang.String
```

