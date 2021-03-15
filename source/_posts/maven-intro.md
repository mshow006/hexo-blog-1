---
title: Maven 简介和 pom.xml 文件简析
categories:
  - tech
tags:
  - maven
comments: true
date: 2019-11-21 17:52:42
updated: 2021-03-15 12:34:40
---
## Maven 简介

Maven 是一个项目管理和构建自动化工具，可以用于构建和管理任何基于Java的项目。它基于项目对象模型(POM)的概念来管理项目的构建、报告和文档。

<!-- more -->

Maven 使用约定优于配置的原则，它要求在没有定制之前，所有的项目都有如下的结构：

| 目录                               | 目的                                                                   |
| ---------------------------------- | ---------------------------------------------------------------------- |
| ${basedir}                         | 存放pom.xml和所有的子目录                                              |
| ${basedir}/src/main/java           | 项目的java源代码                                                       |
| ${basedir}/src/main/resources      | 项目的资源，比如说property文件，springmvc.xml                          |
| ${basedir}/src/test/java           | 项目的测试类，比如说Junit代码                                          |
| ${basedir}/src/test/resources      | 测试用用的资源                                                         |
| ${basedir}/src/main/webapp/WEB-INF | web应用文件目录，web项目的信息，比如存放web.xml、本地图片、jsp视图页面 |
| ${basedir}/target                  | 打包输出目录                                                           |
| ${basedir}/target/classes          | 编译输出目录                                                           |
| ${basedir}/target/test-classes     | 测试编译输出目录                                                       |

## pom.xml 文件简析

> 该pom.xml文件来自[spring-boot-plus]( https://github.com/geekidea/spring-boot-plus )，做了简化处理。

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <!-- 当前pom版本，默认4.0.0 -->
    <modelVersion>4.0.0</modelVersion>

    <!-- 公司或者组织的唯一标志，通常是反写域名 -->
    <groupId>io.geekidea</groupId>
    <!-- 本项目的唯一ID -->
    <artifactId>spring-boot-plus</artifactId>
    <!-- 版本号 (snapshot 快照、 alpha 内部测试、 beta 公测、 Release 稳定版、 GA 正式发布) -->
    <version>1.2.1.RELEASE</version>
    <!-- 打包方式 默认是jar (war zip pom) -->
    <packaging>jar</packaging>

    <!-- 项目名 -->
    <name>spring-boot-plus</name>
    <!-- 项目简介 -->
    <description>spring-boot-plus Project</description>
    <!-- 项目地址 -->
    <url>https://github.com/geekideaio/spring-boot-plus</url>
    <!-- 开源信息 -->
    <licenses>
        <license>
            <name>The Apache License, Version 2.0</name>
            <url>http://www.apache.org/licenses/LICENSE-2.0.txt</url>
        </license>
    </licenses>
    <developers>
        <developer>
            <id>spring-boot-plus</id>
            <name>geekidea</name>
            <email>geekidea@qq.com</email>
        </developer>
    </developers>

    <!-- 项目配置信息，编码方式，各依赖、插件版本号，在pom中的其它地方可以直接引用-->
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <project-parent.version>${parent.version}</project-parent.version>
        <java.version>1.8</java.version>
        <spring-boot.version>2.1.7.RELEASE</spring-boot.version>
        <mybatis-plus-boot-starter.version>3.1.2</mybatis-plus-boot-starter.version>

        <maven-compiler-plugin.version>3.8.1</maven-compiler-plugin.version>
    </properties>

    <!-- 依赖管理 -->
    <dependencies>
        <!-- 每个dependency都对应这一个jar包 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <!-- 作用域（compile 编译范围、provided 已提供范围、runtime 运行时范围、test 测试范围、system 系统范围） -->
            <scope>test</scope>
            <!-- 排除依赖传递 -->
            <exclusions>
                <exclusion>
                    <groupId>***</groupId>
                    <artifactId>***</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
    </dependencies>


    <!--MAVEN打包选择运行环境-->
    <!-- 1:local(默认) 本地 2:dev:开发环境 3:test 4:uat 用户验收测试 5.prod:生产环境 -->
    <profiles>
        <profile>
            <id>local</id>
            <properties>
                <profileActive>local</profileActive>
            </properties>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
        </profile>
        <profile>
            <id>dev</id>
            <properties>
                <profileActive>dev</profileActive>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>
        <profile>
            <id>test</id>
            <properties>
                <profileActive>test</profileActive>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>
        <profile>
            <id>uat</id>
            <properties>
                <profileActive>uat</profileActive>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>
        <profile>
            <id>prod</id>
            <properties>
                <profileActive>prod</profileActive>
            </properties>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
        </profile>
    </profiles>

</project>
```
