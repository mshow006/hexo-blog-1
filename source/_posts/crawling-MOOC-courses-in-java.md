---
title: crawling-MOOC-courses-in-java
categories:
  - tech
comments: true
date: 2019-07-24 11:16:47
updated: 2021-03-15 12:52:09
---
今天偶然间看到一篇关于 Java 爬虫入门的博客，想到以前就学过一点爬虫，于是乎就在博客的基础上写了一个 demo，用来爬取慕课网的实战课程。

首先需要发送 HTTP 请求到网页，用到了 HttpURLConnection 类，具体如下：

<!-- more -->

```java
package util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * @author yingming006
 * Date: 2019/6/22
 */
public class ConnectionUtil {
    public static String Connect(String address) {
        URL url = null;
        HttpURLConnection conn = null;
        InputStream in = null;
        BufferedReader reader = null;
        StringBuffer stringBuffer = null;
        try {
            url = new URL(address);
            // 得到 connection 对象
            conn = (HttpURLConnection) url.openConnection();
            // 建立连接
            conn.connect();
            // 获取输入流
            in = conn.getInputStream();
            reader = new BufferedReader(new InputStreamReader(in));
            stringBuffer = new StringBuffer();
            String line = null;
            while ((line = reader.readLine()) != null) {
                stringBuffer.append(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.disconnect();
            try {
                in.close();
                reader.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return stringBuffer.toString();
    }
}
```

接下来就是利用正则来解析 HTML：

```java
package util;

import pojo.Course;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author yingming006
 * Date: 2019/6/22
 */
public class Analyze {
    private Course course;

    public Course regexMain(String uid) {
        String url = "https://coding.imooc.com/class/" + uid + ".html";
        String result = ConnectionUtil.Connect(url); // 获取 html
        course = getCourseInfo(result, uid);
        return course;
    }

    private Course getCourseInfo(String targetStr, String uid) {
        course = new Course();
        // 提取标题
        Pattern titlePattern = Pattern.compile("title-box.*?</h1>");
        Matcher titleMatcher = titlePattern.matcher(targetStr);
        if (titleMatcher.find()) {
            String titleString = titleMatcher.group();
            int start = titleString.indexOf("<h1>"); // 计算字符串位置
            int end = titleString.indexOf("</h1>");
            String str = titleString.substring(start + 4, end).trim(); // 获取标题，去掉空格
            str = str.replaceAll("<br/>", " "); // 去掉标签
            course.setTitle(str);
        }
        // 优惠价
        Pattern salePricePattern = Pattern.compile("sale-price.*?</div>");
        Matcher salePriceMatcher = salePricePattern.matcher(targetStr);
        if (salePriceMatcher.find()) {
            String salePriceString = salePriceMatcher.group();
            int start = salePriceString.indexOf("￥");  // 计算字符串位置
            int end = salePriceString.indexOf("</div>");
            course.setSalePrice(Double.parseDouble(salePriceString.substring(start + 1, end)));
        } else {
            // System.out.println("无效id:" + uid); // 该课程没有优惠。。。
            return null;
        }

        // 原价
        // Pattern oriPricePattern = Pattern.compile("ori-price.*?</div>");
        // Matcher oriPriceMatcher = oriPricePattern.matcher(targetStr);
        // if (oriPriceMatcher.find()) {
        //     String oriPriceString = oriPriceMatcher.group();
        //     int start = oriPriceString.indexOf("￥");
        //     int end = oriPriceString.indexOf("</div>");
        //     course.setOriPrice(Double.parseDouble(oriPriceString.substring(start + 1, end)));
        // }

        // 讲师
        // Pattern nicknamePattern = Pattern.compile("<div class=\"nickname\">.*?</div>");
        // Matcher nicknameMatcher = nicknamePattern.matcher(targetStr);
        // if (nicknameMatcher.find()) {
        //     String nicknameString = nicknameMatcher.group();
        //     course.setLecturer(nicknameString.substring(22, nicknameString.length() - 6));
        // }
        course.setId(Integer.valueOf(uid));
        return course;
    }
}
```

Course 类如下：

```java
package pojo;

/**
 * @author yingming006
 * Date: 2019/6/22
 */
public class Course {
    private int id;
    private String title;
    private double oriPrice;
    private double salePrice;
    private String lecturer;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getOriPrice() {
        return oriPrice;
    }

    public void setOriPrice(double oriPrice) {
        this.oriPrice = oriPrice;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public String getLecturer() {
        return lecturer;
    }

    public void setLecturer(String lecturer) {
        this.lecturer = lecturer;
    }

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", salePrice=" + salePrice + "\t" +
                ", title='" + title + '\'' +
                // ", oriPrice=" + oriPrice +
                // ", lecturer='" + lecturer + '\'' +
                '}';
    }
}
```

测试一下：

```java
import java.util.*;

public class Main {
    
    public static void main(String[] args) {
        List<Course> courses = new ArrayList<>();
        Analyze analyze = new Analyze();
        for (int i = 1; i <= 400; i++) {
            Course course = analyze.regexMain(String.valueOf(i));
            if (course != null) {
                courses.add(course);
                System.out.println("发现课程\tid:" + course.getId() + "\ttitle:" + course.getTitle());
            }
        }
        for (Course cours : courses) {
            System.out.println(cours);
        }
    }
}
```



参考博客：[Java爬虫入门笔记](<https://blog.csdn.net/sinat_25295611/article/details/62053511>)