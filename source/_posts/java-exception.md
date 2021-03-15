---
title: 【Java基础】Java异常
categories:
  - tech
tags:
  - java
comments: true
date: 2019-05-08 20:53:22
updated: 2021-03-15 13:19:21
---
### 什么是异常

《Java编程思想》中异常的定义说明：

> 异常情形是指阻止当前方法或者作用域继续执行的问题。在这里一定要明确一点：异常代码某种程度的错误，尽管Java有异常处理机制，但是我们不能以“正常”的眼光来看待异常，异常处理机制的原因就是告诉你：这里可能会或者已经产生了错误，您的程序出现了不正常的情况，可能会导致程序失败！

>那么什么时候才会出现异常呢？只有在你当前的环境下程序无法正常运行下去，也就是说程序已经无法来正确解决问题了，这时它所就会从当前环境中跳出，并抛出异常。抛出异常后，它首先会做几件事。

>首先，它会使用new创建一个异常对象，然后在产生异常的位置终止程序，并且从当前环境中弹出对异常对象的引用，这时。异常处理机制就会接管程序，并开始寻找一个恰当的地方来继续执行程序，这个恰当的地方就是异常处理程序。

> 总的来说异常处理机制就是当程序发生异常时，它强制终止程序运行，记录异常信息并将这些信息反馈给我们，由我们来确定是否处理异常。

<!-- more -->

### 异常的分类

![java异常](https://img-blog.csdnimg.cn/20190508205246476.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

所有的异常都是由`Throwable`继承而来，它有两个子类：`Error` 和 `Exception`.

- Error 类主要描述了 Java 运行时系统的内部错误和资源耗尽错误，代表了JVM本身的错误。出现此类错误时无法处理，JVM 会终止程序，不能捕获，例如`OutOfMemoryError`。

- Exception 类就是常提到的异常类，可以被Java异常处理机制使用，是异常处理的核心。。例如`NullPointerException`、`IndexOutOfBoundsException`。

根据 Javac 对异常的处理要求，将异常类分为2类：

> 非检查异常（unchecked exception）：Error 和 RuntimeException 以及他们的子类。javac 在编译时，不会提示和发现这样的异常，不要求在程序中处理这些异常。所以如果愿意，我们可以编写代码处理（使用try…catch…finally）这样的异常，也可以不处理。
>
> 对于这些异常，我们应该修正代码，而不是去通过异常处理器处理 。这样的异常发生的原因多半是代码写的有问题。如除0错误ArithmeticException，错误的强制类型转换错误ClassCastException，数组索引越界ArrayIndexOutOfBoundsException，使用了空对象NullPointerException等等。

> 检查异常（checked exception）：除了Error 和 RuntimeException的其它异常。javac强制要求程序员为这样的异常做预备处理工作（使用try…catch…finally或者throws）。在方法中要么用try-catch语句捕获它并处理，要么用throws子句声明抛出它，否则编译不会通过。
>
> 这样的异常一般是由程序的运行环境导致的。因为程序可能被运行在各种未知的环境下，而程序员无法干预用户如何使用他编写的程序，于是程序员就应该为这样的异常时刻准备着。如SQLException , IOException,ClassNotFoundException 等。

需要明确的是：检查和非检查是对于javac来说的，这样就很好理解和区分了。

### 初识异常

下面的代码会演示2个异常类型：ArithmeticException 和 InputMismatchException。前者由于整数除0引发，后者是输入的数据不能被转换为int类型引发。

```java
public class AllDemo
{
      public static void main (String [] args )
      {
            System . out. println( "----欢迎使用命令行除法计算器----" ) ;
            CMDCalculate ();
      }
      public static void CMDCalculate ()
      {
            Scanner scan = new Scanner ( System. in );
            int num1 = scan .nextInt () ;
            int num2 = scan .nextInt () ;
            int result = devide (num1 , num2 ) ;
            System . out. println( "result:" + result) ;
            scan .close () ;
      }
      public static int devide (int num1, int num2 ){
            return num1 / num2 ;
      }
}
/*****************************************
 
----欢迎使用命令行除法计算器----
0 0
Exception in thread "main" java.lang.ArithmeticException : / by zero
     at com.example.AllDemo.devide( AllDemo.java:30 )
     at com.example.AllDemo.CMDCalculate( AllDemo.java:22 )
     at com.example.AllDemo.main( AllDemo.java:12 )
 
----欢迎使用命令行除法计算器----
r
Exception in thread "main" java.util.InputMismatchException
     at java.util.Scanner.throwFor( Scanner.java:864 )
     at java.util.Scanner.next( Scanner.java:1485 )
     at java.util.Scanner.nextInt( Scanner.java:2117 )
     at java.util.Scanner.nextInt( Scanner.java:2076 )
     at com.example.AllDemo.CMDCalculate( AllDemo.java:20 )
     at com.example.AllDemo.main( AllDemo.java:12 )
*****************************************/
```

![异常](https://img-blog.csdnimg.cn/20190508205310258.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01TaG93MDA2,size_16,color_FFFFFF,t_70)

异常是在执行某个函数时引发的，而函数又是层级调用，形成调用栈的，因此，只要一个函数发生了异常，那么他的所有的 caller 都会被异常影响。当这些被影响的函数以异常信息输出时，就形成的了异常追踪栈。

异常最先发生的地方，叫做异常抛出点。

从上面的例子可以看出，当devide函数发生除0异常时，devide函数将抛出ArithmeticException异常，因此调用他的CMDCalculate函数也无法正常完成，因此也发送异常，而CMDCalculate的caller——main 因为CMDCalculate抛出异常，也发生了异常，这样一直向调用栈的栈底回溯。这种行为叫做异常的冒泡，异常的冒泡是为了在当前发生异常的函数或者这个函数的caller中找到最近的异常处理程序。由于这个例子中没有使用任何异常处理机制，因此异常最终由main函数抛给JRE，导致程序终止。

上面的代码不使用异常处理机制，也可以顺利编译，因为2个异常都是非检查异常。但是下面的例子就必须使用异常处理机制，因为异常是检查异常。

代码中我选择使用throws声明异常，让函数的调用者去处理可能发生的异常。使用 `throws IOException` 是因为FileNotFoundException是IOException的子类，在处理范围内。

```java
@Test
public void testException() throws IOException
{
    //FileInputStream的构造函数会抛出FileNotFoundException
    FileInputStream fileIn = new FileInputStream("E:\\a.txt");
 
    int word;
    //read方法会抛出IOException
    while((word =  fileIn.read())!=-1) 
    {
        System.out.print((char)word);
    }
    //close方法会抛出IOException
    fileIn.clos
}
```

### 异常的捕获

- **使用try-catch语句块**

如果程序在try语句块中的任何代码抛出了一个在catch子句中说明的异常类，那么①程序将跳过try语句块中的其余代码②程序将执行catch子句中的代码。如果没有异常，将跳过catch语句块。一个try至少要跟一个catch或者finally。

- **在函数签名中使用 throws** 

```java
// try-catch 捕获异常
public void read(String filename) {
    try {
        InputStream in = new FileInputStream(filename);
        int b;
        while ((b = in.read()) != -1) {
            System.out.println(b);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}

// 使用 throws
public void read(String filename) throws IOException {
    InputStream in = new FileInputStream(filename);
    int b;
    while ((b = in.read()) != -1) {
        System.out.println(b);
    }
}
```

**finally 块的执行**

finally块不管异常是否发生，只要对应的try执行了，则它一定也执行。只有一种方法让finally块不执行：`System.exit()`。因此finally块通常用来做资源释放操作：关闭文件，关闭数据库连接等等。

良好的编程习惯是：在try块中打开资源，在finally块中清理释放这些资源。

需要注意的地方:

1. finally块没有处理异常的能力。处理异常的只能是catch块。

2. 在同一try…catch…finally块中 ，如果try中抛出异常，且有匹配的catch块，则先执行catch块，再执行finally块。如果没有catch块匹配，则先执行finally，然后去外面的调用者中寻找合适的catch块。

3. 在同一try…catch…finally块中 ，try发生异常，且匹配的catch块中处理异常时也抛出异常，那么后面的finally也会执行：首先执行finally块，然后去外围调用者中寻找合适的catch块。

**finally 和 return**

首先一个不容易理解的事实：在 try块中即便有return，break，continue等改变执行流的语句，finally也会执行。

```java
public static void main(String[] args)
{
    int re = bar();
    System.out.println(re);
}
private static int bar() 
{
    try{
        return 5;
    } finally{
        System.out.println("finally");
    }
}
/*输出：
finally
*/
```

可以参考下面的动图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190508205729417.gif)
也就是说：try…catch…finally中的 return 只要能执行，就都执行了，他们共同向同一个内存地址（假设地址是0×80）写入返回值，后执行的将覆盖先执行的数据，而真正被调用者取的返回值就是最后一次写入的。那么，按照这个思想，下面的这个例子也就不难理解了。

finally中的return 会覆盖 try 或者catch中的返回值：

```java
public static void main(String[] args) {
    int result;

    result = foo();
    System.out.println(result);     /////////2

    result = bar();
    System.out.println(result);    /////////2
}

@SuppressWarnings("finally")
public static int foo() {
    trz {
        int a = 5 / 0;
    } catch(Exception e){
        return 1;
    } finally{
        return 2;
    }

}

@SuppressWarnings("finally")
public static int bar() {
    try {
        return 1;
    } finally {
        return 2;
    }
}
```

finally中的return会抑制（消灭）前面try或者catch块中的异常

```java
class TestException
{
    public static void main(String[] args)
    {
        int result;
        try{
            result = foo();
            System.out.println(result);           //输出100
        } catch (Exception e){
            System.out.println(e.getMessage());    //没有捕获到异常
        }
 
        try{
            result  = bar();
            System.out.println(result);           //输出100
        } catch (Exception e){
            System.out.println(e.getMessage());    //没有捕获到异常
        }
    }
 
    //catch中的异常被抑制
    @SuppressWarnings("finally")
    public static int foo() throws Exception
    {
        try {
            int a = 5/0;
            return 1;
        }catch(ArithmeticException amExp) {
            throw new Exception("我将被忽略，因为下面的finally中使用了return");
        }finally {
            return 100;
        }
    }
 
    //try中的异常被抑制
    @SuppressWarnings("finally")
    public static int bar() throws Exception
    {
        try {
            int a = 5/0;
            return 1;
        }finally {
            return 100;
        }
    }
}
```

finally中的异常会覆盖（消灭）前面try或者catch中的异常

```java
class TestException
{
    public static void main(String[] args)
    {
        int result;
        try{
            result = foo();
        } catch (Exception e){
            System.out.println(e.getMessage());    //输出：我是finaly中的Exception
        }
 
        try{
            result  = bar();
        } catch (Exception e){
            System.out.println(e.getMessage());    //输出：我是finaly中的Exception
        }
    }
 
    //catch中的异常被抑制
    @SuppressWarnings("finally")
    public static int foo() throws Exception
    {
        try {
            int a = 5/0;
            return 1;
        }catch(ArithmeticException amExp) {
            throw new Exception("我将被忽略，因为下面的finally中抛出了新的异常");
        }finally {
            throw new Exception("我是finaly中的Exception");
        }
    }
 
    //try中的异常被抑制
    @SuppressWarnings("finally")
    public static int bar() throws Exception
    {
        try {
            int a = 5/0;
            return 1;
        }finally {
            throw new Exception("我是finaly中的Exception");
        }
 
    }
}
```

>不要在finally中使用return。
>
>不要在finally中抛出异常。
>
>减轻finally的任务，不要在finally中做一些其它的事情，finally块仅仅用来释放资源是最合适的。
>
>将尽量将所有的return写在函数的最后面，而不是try … catch … finally中。

> [全面解读Java异常](https://blog.csdn.net/a724888/article/details/80114720)
>
> [你所需要的java异常的处理和设计及深入理解，看这篇就差不多了](<https://juejin.im/post/5ae66791f265da0b92655c5d#heading-13>)