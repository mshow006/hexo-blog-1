---
title: 三层架构和MVC模式
categories:
  - tech
tags:
  - mvc
comments: true
date: 2019-11-09 20:07:26
updated: 2021-03-15 12:39:26
---
三层架构和 MVC 模式是两个完全不一样的概念。

先来看下二者的定义。

> **三层架构**（Three-Tier Architecture）： 是最基本的项目分层结果。秉承“高内聚，低耦合”的思想，将整个业务应用划分为：UI层（表示层）、BLL（业务逻辑层）、DAL层（数据访问层）。系统的主要功能和业务逻辑在业务逻辑层进行处理。 
>
> UI：表示层，也叫做用户界面层，用来接受用户的请求，以及数据返回。
>
> BLL：业务逻辑层，主要负责对数据层的操作，对数据业务逻辑的处理。
>
> DAL：数据访问层，直接操作数据库，包括增、删、改、查、备份、还原等操作。

<!-- more -->

<img src="https://i.loli.net/2019/11/04/q5PbV3OUKAIxNCL.png" >

> **MVC** 即 Model View Controller 。MVC 是一种很好的设计模式的综合应用。 
>
> M 即Model（模型层），主要负责处理业务逻辑以及与数据库的交互。
>
> V 即View（视图层），主要用于显示数据和提交数据。
>
> C 即Controller（控制器），主要用于接受请求并控制请求转发。

<img src="https://i.loli.net/2019/11/04/cCOUalP7h6HsJ3x.png" >

关于二者的区别呢，主要有以下几点：

① **MVC是一种复合设计模式，而三层是一个软件架构（主要）。**

软件架构是用接口来实现的，而设计模式则是一种设计思想、设计理念的升华，也可以算做一种解决方案。一个系统一般只有一个软件架构，而可以有多个设计模式，因为设计模式是可以复用的。

② 在三层架构中没有定义Controller的概念，而MVC中也没有将业务的逻辑访问看成两个层。当然了。在三层中也提到了Model，但是三层架构中Model(Entry)的概念与MVC中Model的概念是不一样的，“三层”中典型的Model层是以实体类构成的，而MVC里，则是由业务逻辑与访问数据组成的。

③三层架构划分为：View(UI)、BIZ（BLL）、ADO（DAL）、Entity（Model）、Controller。而MVC把 BIZ（BLL）、ADO（DAL）、Model（Entity） 统一称之为 模型(MODEL)，得到：View、Controller、模型(MODEL) 三层。

但是，三层架构和 MVC 模式的核心却是一样的，即 **分层，解耦**。
