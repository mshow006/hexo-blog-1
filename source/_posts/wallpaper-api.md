---
title: 壁纸 Api
categories:
  - tech
comments: true
date: 2022-03-17 13:58:14
updated: 2022-03-17 13:58:14
---

> 原文链接：[https://www.jianshu.com/p/fb1d1ad58a0b](https://www.jianshu.com/p/fb1d1ad58a0b)

### 不分类别获取壁纸接口

url: `http://service.picasso.adesk.com/v1/vertical/vertical`

- skip：略过数量
- limit：返回数量
- order：排序方式，`hot`、`favs`、`new`
- adult：布尔值
- first：起始位置

url 示例：`http://service.picasso.adesk.com/v1/vertical/vertical?limit=30&skip=180&adult=false&first=0&order=hot`

<!-- more -->

```json
{
  "msg": "success",
  "res": {
    "vertical": [{
      "preview": "http://img5.adesk.com/61c56f49e7bce71fecd85c85?sign=fe1d860cb43ee8d08f702f57db6fe839&t=6232dd30",
      "thumb": "http://img5.adesk.com/61c56f49e7bce71fecd85c85?imageMogr2/thumbnail/!350x540r/gravity/Center/crop/350x540&sign=fe1d860cb43ee8d08f702f57db6fe839&t=6232dd30",
      "img": "http://img5.adesk.com/61c56f49e7bce71fecd85c85?imageMogr2/thumbnail/!1080x1920r/gravity/Center/crop/1080x1920&sign=fe1d860cb43ee8d08f702f57db6fe839&t=6232dd30",
      "views": 0,
      "cid": [
        "4e4d610cdf714d2966000002"
      ],
      "rule": "&imageMogr2/thumbnail/!$<Width>x$<Height>r/gravity/Center/crop/$<Width>x$<Height>",
      "ncos": 100,
      "rank": 44865,
      "source_type": "vertical",
      "tag": [
        "风景",
        "俯瞰",
        "大海"
      ],
      "url": [],
      "wp": "http://img5.adesk.com/61c56f49e7bce71fecd85c85?sign=fe1d860cb43ee8d08f702f57db6fe839&t=6232dd30",
      "xr": false,
      "cr": false,
      "favs": 46,
      "atime": 1640901926,
      "id": "61c56f49e7bce71fecd85c85",
      "store": "qiniu",
      "desc": ""
    }]
  },
  "code": 0
}
```

- msg：响应信息
- res：返回的数据
- vertical：返回的壁纸数据
- preview：壁纸地址
- thumb：小缩略图地址
- img：大缩略图地址
- views：查看数
- cid：所属的类别ID
- rank：点赞数
- tag：壁纸标签
- rule：返回不同大小壁纸规则
- wp：手机版下载地址
- favs：收藏数
- atime：创建时间（单位：秒）
- id：ID
- store：云服务器地址
- desc：描述
- code：返回码

### 获取手机壁纸类别

url：`http://service.picasso.adesk.com/v1/vertical/category`

adult：布尔值
first：起始位置

url 示例：`http://service.picasso.adesk.com/v1/vertical/category?adult=false&first=1`

```json
{
  "msg": "success",
  "res": {
    "category": [{
        "count": 50741,
        "ename": "girl",
        "rname": "美女",
        "cover_temp": "56a964df69401b2866828acb",
        "name": "美女",
        "cover": "http://img5.adesk.com/62285717e7bce71c5900cf6b?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=35570d03e00166d76d9b8b5e175f27f4&t=6232dfab",
        "rank": 1,
        "filter": [],
        "sn": 1,
        "icover": "582c34f869401b347e0b43fb",
        "atime": 1291266021,
        "type": 1,
        "id": "4e4d610cdf714d2966000000",
        "picasso_cover": "62285717e7bce71c5900cf6b"
      },
      {
        "count": 93572,
        "ename": "animation",
        "rname": "动漫",
        "cover_temp": "56a221c969401b3f4aa6700a",
        "name": "动漫",
        "cover": "http://img5.adesk.com/621fb8c731f6132b32dc1924?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=4a2d3bdbca95f767527e29c75e2d79b0&t=6232dfab",
        "rank": 4,
        "id": "4e4d610cdf714d2966000003",
        "icover": "5880889ae7bce7755f3607d9",
        "sn": 2,
        "atime": 1291266057,
        "type": 1,
        "filter": [],
        "picasso_cover": "621fb8c731f6132b32dc1924"
      },
      {
        "count": 72666,
        "ename": "landscape",
        "rname": "风景",
        "cover_temp": "56a770e269401b756c748b28",
        "name": "风景",
        "cover": "http://img5.adesk.com/622028a4e7bce71c8655ed0a?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=9ede89966a1427f42e2de06ebe3a8042&t=6232dfab",
        "rank": 3,
        "id": "4e4d610cdf714d2966000002",
        "icover": "581b0f2a69401b34865e6cd2",
        "sn": 3,
        "atime": 1291266049,
        "type": 1,
        "filter": [],
        "picasso_cover": "622028a4e7bce71c8655ed0a"
      },
      {
        "count": 14459,
        "ename": "game",
        "rname": "游戏",
        "cover_temp": "569f40fa69401b26c648eb87",
        "name": "游戏",
        "cover": "http://img5.adesk.com/6225b11e7e978a3cd90c5c80?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=7df9fdcedf149eb3ee6f3f4c84da32ab&t=6232dfab",
        "rank": 15,
        "filter": [],
        "sn": 4,
        "icover": "5866127069401b347e0bd82b",
        "atime": 1300683934,
        "type": 1,
        "id": "4e4d610cdf714d2966000007",
        "picasso_cover": "6225b11e7e978a3cd90c5c80"
      },
      {
        "count": 9644,
        "ename": "text",
        "rname": "文字",
        "cover_temp": "56a1f92369401b3f529d3a3f",
        "name": "文字",
        "cover": "http://img5.adesk.com/622027a6e7bce71c8655ed08?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=906dc985247fd5b8e715d2ce097d54c3&t=6232dfab",
        "rank": 5,
        "filter": [],
        "sn": 5,
        "icover": "5864e5a769401b34865f1ccc",
        "atime": 1359601742,
        "type": 1,
        "id": "5109e04e48d5b9364ae9ac45",
        "picasso_cover": "622027a6e7bce71c8655ed08"
      },
      {
        "count": 8134,
        "ename": "vision",
        "rname": "视觉",
        "cover_temp": "56a076f769401b323d865538",
        "name": "视觉",
        "cover": "http://img5.adesk.com/6222047be7bce71c703a6e0e?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=c4dbe8da8cb90631edb7d90895ac1d6b&t=6232dfab",
        "rank": 8,
        "filter": [],
        "sn": 6,
        "icover": "57f8be3d69401b347e0ab423",
        "type": 1,
        "id": "4fb479f75ba1c65561000027",
        "picasso_cover": "6222047be7bce71c703a6e0e"
      },
      {
        "count": 15103,
        "ename": "emotion",
        "rname": "情感",
        "cover_temp": "56a03f5369401b26beeaea1d",
        "name": "情感",
        "cover": "http://img5.adesk.com/622854b1e7bce71c4459aeb1?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=21938b7d193132db5a958446d06a2c87&t=6232dfab",
        "rank": 2,
        "id": "4ef0a35c0569795756000000",
        "icover": "57c53c8769401b644d2782fb",
        "sn": 7,
        "type": 1,
        "filter": [],
        "picasso_cover": "622854b1e7bce71c4459aeb1"
      },
      {
        "count": 8214,
        "ename": "creative",
        "rname": "设计",
        "cover_temp": "569b34af69401b7dd39e9fc3",
        "name": "设计",
        "cover": "http://img5.adesk.com/6228542ae7bce71c2e6344aa?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=2d8708b4d2c1c4c53917cf789c3d1f57&t=6232dfab",
        "rank": 9,
        "id": "4fb47a195ba1c60ca5000222",
        "icover": "575e7a9869401b01d8ef3ece",
        "sn": 8,
        "type": 1,
        "filter": [],
        "picasso_cover": "6228542ae7bce71c2e6344aa"
      },
      {
        "count": 19797,
        "ename": "celebrity",
        "rname": "明星",
        "cover_temp": "56a9a70669401b338161138c",
        "name": "明星",
        "cover": "http://img5.adesk.com/621aed547e978a3d509297ca?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=d88dc7eba736d9706cb5bd89a786f1c6&t=6232dfab",
        "rank": 6,
        "id": "5109e05248d5b9368bb559dc",
        "icover": "5460349269401b3a428a47a7",
        "sn": 9,
        "atime": 1359601746,
        "type": 1,
        "filter": [],
        "picasso_cover": "621aed547e978a3d509297ca"
      },
      {
        "count": 23969,
        "ename": "stuff",
        "rname": "物语",
        "cover_temp": "56a61f1c69401b54eff72f31",
        "name": "物语",
        "cover": "http://img5.adesk.com/6221f84ee7bce71c2e634347?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=a94c3eae17792db073c8a222da1fe3c1&t=6232dfab",
        "rank": 10,
        "filter": [],
        "sn": 10,
        "icover": "557b8cf269401b1704e91bfc",
        "type": 1,
        "id": "4fb47a465ba1c65561000028",
        "picasso_cover": "6221f84ee7bce71c2e634347"
      },
      {
        "count": 4229,
        "ename": "man",
        "rname": "男人",
        "cover_temp": "569b541d69401b7dc8ce2c68",
        "name": "男人",
        "cover": "http://img5.adesk.com/61eda609e7bce7680c384418?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=9be3e19342906c165cfa78edb20b70ad&t=6232dfab",
        "rank": 13,
        "id": "4e4d610cdf714d2966000006",
        "icover": "550ba05469401b46dbf0b687",
        "sn": 12,
        "atime": 1298251540,
        "type": 1,
        "filter": [],
        "picasso_cover": "61eda609e7bce7680c384418"
      },
      {
        "count": 23698,
        "ename": "machine",
        "rname": "机械",
        "cover_temp": "56a99e1f69401b1ce58c12dc",
        "name": "机械",
        "cover": "http://img5.adesk.com/621f5755e7bce77337d18626?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=d1da6a91343d934b5953cd25f657a334&t=6232dfab",
        "rank": 12,
        "id": "4e4d610cdf714d2966000005",
        "icover": "5028b42aedd6a9410c002552",
        "sn": 13,
        "atime": 1297756191,
        "type": 1,
        "filter": [],
        "picasso_cover": "621f5755e7bce77337d18626"
      },
      {
        "count": 13628,
        "ename": "cityscape",
        "rname": "城市",
        "cover_temp": "569b540969401b7dd39ea06d",
        "name": "城市",
        "cover": "http://img5.adesk.com/61ea1b77e7bce7794a5829e3?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=e90eb7da0d262617700bb546f418d1bb&t=6232dfab",
        "rank": 7,
        "filter": [],
        "sn": 14,
        "icover": "5792cf7369401b71e3555741",
        "type": 1,
        "id": "4fb47a305ba1c60ca5000223",
        "picasso_cover": "61ea1b77e7bce7794a5829e3"
      },
      {
        "count": 19477,
        "ename": "animal",
        "rname": "动物",
        "cover_temp": "56a4d1da69401b753a684e69",
        "name": "动物",
        "cover": "http://img5.adesk.com/621b3aa031f6132b32d9cc73?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=faf13a5ef95b22526cdad453c11e58ce&t=6232dfab",
        "rank": 14,
        "filter": [],
        "sn": 16,
        "icover": "58636cda69401b34865f1406",
        "atime": 1291266042,
        "type": 1,
        "id": "4e4d610cdf714d2966000001",
        "picasso_cover": "621b3aa031f6132b32d9cc73"
      }
    ]
  },
  "code": 0
}
```

- msg：响应信息
- res：返回的数据
- category：返回的分类数据
- ename：英文名
- atime：创建时间
- name：中文名
- cover：封面
- id：ID
- desc：描述
- code：返回码

### 获取某类手机壁纸下壁纸

url：`http://service.picasso.adesk.com/v1/vertical/category/{类别ID}`

拼接参数与解析均与手机壁纸接口一致

url 示例：
`http://service.picasso.adesk.com/v1/vertical/category/4e4d610cdf714d2966000003/vertical?limit=30&adult=false&first=1&order=new`


### 下载手机壁纸

url：`http://img5.adesk.com/{壁纸ID}`

### 获取电脑壁纸类别

url：`http://service.picasso.adesk.com/v1/wallpaper/category`

```json
{
  "msg": "success",
  "res": {
    "category": [{
        "count": 50741,
        "ename": "girl",
        "rname": "美女",
        "cover_temp": "56a964df69401b2866828acb",
        "name": "美女",
        "cover": "http://img5.adesk.com/62285717e7bce71c5900cf6b?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=5a2956df9396d0ddcb7bc0c714874de3&t=6232e3d3",
        "rank": 1,
        "filter": [],
        "sn": 1,
        "icover": "582c34f869401b347e0b43fb",
        "atime": 1291266021,
        "type": 1,
        "id": "4e4d610cdf714d2966000000",
        "picasso_cover": "62285717e7bce71c5900cf6b"
      },
      {
        "count": 93572,
        "ename": "animation",
        "rname": "动漫",
        "cover_temp": "56a221c969401b3f4aa6700a",
        "name": "动漫",
        "cover": "http://img5.adesk.com/621fb8c731f6132b32dc1924?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=7b79490301dc7806f3093a2f852a7e97&t=6232e3d3",
        "rank": 4,
        "id": "4e4d610cdf714d2966000003",
        "icover": "5880889ae7bce7755f3607d9",
        "sn": 2,
        "atime": 1291266057,
        "type": 1,
        "filter": [],
        "picasso_cover": "621fb8c731f6132b32dc1924"
      },
      {
        "count": 72666,
        "ename": "landscape",
        "rname": "风景",
        "cover_temp": "56a770e269401b756c748b28",
        "name": "风景",
        "cover": "http://img5.adesk.com/622028a4e7bce71c8655ed0a?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=ad812c3432241b6cb8cb7d4ec07e273b&t=6232e3d3",
        "rank": 3,
        "id": "4e4d610cdf714d2966000002",
        "icover": "581b0f2a69401b34865e6cd2",
        "sn": 3,
        "atime": 1291266049,
        "type": 1,
        "filter": [],
        "picasso_cover": "622028a4e7bce71c8655ed0a"
      },
      {
        "count": 14459,
        "ename": "game",
        "rname": "游戏",
        "cover_temp": "569f40fa69401b26c648eb87",
        "name": "游戏",
        "cover": "http://img5.adesk.com/6225b11e7e978a3cd90c5c80?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=061424b187e2cf52f0ccfb1f92fca7aa&t=6232e3d3",
        "rank": 15,
        "filter": [],
        "sn": 4,
        "icover": "5866127069401b347e0bd82b",
        "atime": 1300683934,
        "type": 1,
        "id": "4e4d610cdf714d2966000007",
        "picasso_cover": "6225b11e7e978a3cd90c5c80"
      },
      {
        "count": 9644,
        "ename": "text",
        "rname": "文字",
        "cover_temp": "56a1f92369401b3f529d3a3f",
        "name": "文字",
        "cover": "http://img5.adesk.com/622027a6e7bce71c8655ed08?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=b3653941c80060f6925f0a3ed81fc0d0&t=6232e3d3",
        "rank": 5,
        "filter": [],
        "sn": 5,
        "icover": "5864e5a769401b34865f1ccc",
        "atime": 1359601742,
        "type": 1,
        "id": "5109e04e48d5b9364ae9ac45",
        "picasso_cover": "622027a6e7bce71c8655ed08"
      },
      {
        "count": 8134,
        "ename": "vision",
        "rname": "视觉",
        "cover_temp": "56a076f769401b323d865538",
        "name": "视觉",
        "cover": "http://img5.adesk.com/6222047be7bce71c703a6e0e?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=1e9d2545314a8b25ebba0715b81f471b&t=6232e3d3",
        "rank": 8,
        "filter": [],
        "sn": 6,
        "icover": "57f8be3d69401b347e0ab423",
        "type": 1,
        "id": "4fb479f75ba1c65561000027",
        "picasso_cover": "6222047be7bce71c703a6e0e"
      },
      {
        "count": 15103,
        "ename": "emotion",
        "rname": "情感",
        "cover_temp": "56a03f5369401b26beeaea1d",
        "name": "情感",
        "cover": "http://img5.adesk.com/622854b1e7bce71c4459aeb1?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=08b01ff93e66ce8f805cd248a190f2ee&t=6232e3d3",
        "rank": 2,
        "id": "4ef0a35c0569795756000000",
        "icover": "57c53c8769401b644d2782fb",
        "sn": 7,
        "type": 1,
        "filter": [],
        "picasso_cover": "622854b1e7bce71c4459aeb1"
      },
      {
        "count": 8214,
        "ename": "creative",
        "rname": "设计",
        "cover_temp": "569b34af69401b7dd39e9fc3",
        "name": "设计",
        "cover": "http://img5.adesk.com/6228542ae7bce71c2e6344aa?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=f8c8e8f23778fdc9c2f720032fcd7758&t=6232e3d3",
        "rank": 9,
        "id": "4fb47a195ba1c60ca5000222",
        "icover": "575e7a9869401b01d8ef3ece",
        "sn": 8,
        "type": 1,
        "filter": [],
        "picasso_cover": "6228542ae7bce71c2e6344aa"
      },
      {
        "count": 19797,
        "ename": "celebrity",
        "rname": "明星",
        "cover_temp": "56a9a70669401b338161138c",
        "name": "明星",
        "cover": "http://img5.adesk.com/621aed547e978a3d509297ca?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=8527735b63029d117787c0b87a3f5592&t=6232e3d3",
        "rank": 6,
        "id": "5109e05248d5b9368bb559dc",
        "icover": "5460349269401b3a428a47a7",
        "sn": 9,
        "atime": 1359601746,
        "type": 1,
        "filter": [],
        "picasso_cover": "621aed547e978a3d509297ca"
      },
      {
        "count": 23969,
        "ename": "stuff",
        "rname": "物语",
        "cover_temp": "56a61f1c69401b54eff72f31",
        "name": "物语",
        "cover": "http://img5.adesk.com/6221f84ee7bce71c2e634347?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=35989be63b749d151f34b636b51c05ba&t=6232e3d3",
        "rank": 10,
        "filter": [],
        "sn": 10,
        "icover": "557b8cf269401b1704e91bfc",
        "type": 1,
        "id": "4fb47a465ba1c65561000028",
        "picasso_cover": "6221f84ee7bce71c2e634347"
      },
      {
        "count": 4229,
        "ename": "man",
        "rname": "男人",
        "cover_temp": "569b541d69401b7dc8ce2c68",
        "name": "男人",
        "cover": "http://img5.adesk.com/61eda609e7bce7680c384418?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=69d73bd51ad39a4d74ea1fa69bb7b620&t=6232e3d3",
        "rank": 13,
        "id": "4e4d610cdf714d2966000006",
        "icover": "550ba05469401b46dbf0b687",
        "sn": 12,
        "atime": 1298251540,
        "type": 1,
        "filter": [],
        "picasso_cover": "61eda609e7bce7680c384418"
      },
      {
        "count": 23698,
        "ename": "machine",
        "rname": "机械",
        "cover_temp": "56a99e1f69401b1ce58c12dc",
        "name": "机械",
        "cover": "http://img5.adesk.com/621f5755e7bce77337d18626?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=c75597c04db791a98bd9c4c49bb80e2c&t=6232e3d3",
        "rank": 12,
        "id": "4e4d610cdf714d2966000005",
        "icover": "5028b42aedd6a9410c002552",
        "sn": 13,
        "atime": 1297756191,
        "type": 1,
        "filter": [],
        "picasso_cover": "621f5755e7bce77337d18626"
      },
      {
        "count": 13628,
        "ename": "cityscape",
        "rname": "城市",
        "cover_temp": "569b540969401b7dd39ea06d",
        "name": "城市",
        "cover": "http://img5.adesk.com/61ea1b77e7bce7794a5829e3?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=c5362681d0b1ebca3ae5646ae691aa8e&t=6232e3d3",
        "rank": 7,
        "filter": [],
        "sn": 14,
        "icover": "5792cf7369401b71e3555741",
        "type": 1,
        "id": "4fb47a305ba1c60ca5000223",
        "picasso_cover": "61ea1b77e7bce7794a5829e3"
      },
      {
        "count": 19477,
        "ename": "animal",
        "rname": "动物",
        "cover_temp": "56a4d1da69401b753a684e69",
        "name": "动物",
        "cover": "http://img5.adesk.com/621b3aa031f6132b32d9cc73?imageMogr2/thumbnail/!640x480r/gravity/Center/crop/640x480&sign=705ab717782939e20f8a9aa38ae6047d&t=6232e3d3",
        "rank": 14,
        "filter": [],
        "sn": 16,
        "icover": "58636cda69401b34865f1406",
        "atime": 1291266042,
        "type": 1,
        "id": "4e4d610cdf714d2966000001",
        "picasso_cover": "621b3aa031f6132b32d9cc73"
      }
    ]
  },
  "code": 0
}
```

- msg：响应信息
- res：返回的数据
- category：返回的类别数据
- count：总数量
- ename：英文名
- name：类别中文名
- cover：封面
- atime：创建时间
- id：ID
- picasso_cover：封面图ID
- code：返回码

### 获取类别下的电脑壁纸

url：`http://service.picasso.adesk.com/v1/wallpaper/category/{类别ID}/wallpaper`

拼接参数与解析与手机壁纸接口类似

url 示例：
`http://service.picasso.adesk.com/v1/wallpaper/category/4e4d610cdf714d2966000003/wallpaper?limit=30&adult=false&first=1&order=new`

```json
{
  "msg": "success",
  "res": {
    "wallpaper": [{
      "atime": 1486361895,
      "thumb": "http://img0.aibizhi.adesk.com/download/58981527e7bce7486b6417aa?sign=d232d5c7d5fab1275974c46fce68168e&t=62337eb8",
      "img": "http://img0.aibizhi.adesk.com/download/58981527e7bce7486b6417b3?sign=87f449ecde6754a154581fd1b255dae4&t=62337eb8",
      "cid": [
        "4e4d610cdf714d2966000001"
      ],
      "url": [],
      "views": 0,
      "ncos": 1,
      "rank": 5169,
      "tag": [
        "动物",
        "鸟",
        "飞翔",
        "天空",
        "云"
      ],
      "wp": "http://img0.aibizhi.adesk.com/wallpaper?imgid=5864b7ff69401b34865f1853&sign=187714f53aa0bfd448aa228cb80aeb7c&t=62337eb8",
      "xr": false,
      "cr": false,
      "favs": 46,
      "preview": "http://img0.aibizhi.adesk.com/download/58981526e7bce7486b64178c?sign=8fd247e4b63e8896f2e2bc2fe0c80ff2&t=62337eb8",
      "id": "5864b7ff69401b34865f1853",
      "store": "adesk",
      "desc": ""
    }]
  },
  "code": 0
}
```

### 获取电脑壁纸专辑

url：`http://service.picasso.adesk.com/v1/wallpaper/album`

拼接参数与手机壁纸接口类似

url 示例：`http://service.picasso.adesk.com/v1/wallpaper/album?limit=10&adult=false&first=1&order=hot`


```
{
  "msg": "success",
  "res": {
    "album": [{
      "ename": "小动物",
      "isfeed": false,
      "tag": [],
      "id": "4cf727fa716ec22db1000000",
      "hide": false,
      "recommend": false,
      "utime": 1646391904,
      "type": 1,
      "status": "online",
      "user": {
        "gcid": "",
        "name": "安卓壁纸蛋蛋君",
        "gender": 1,
        "follower": 5584,
        "avatar": "http://img0.adesk.com/download/53bcf873174cf12dc1add149",
        "viptime": 978278400,
        "following": 0,
        "isvip": false,
        "id": "4d5a2259716ec209a4000000"
      },
      "favs": 3542,
      "atime": 1291266042,
      "desc": "感谢生命中有他们的温暖陪伴",
      "count": 2162,
      "name": "小动物",
      "url": [],
      "cover": "http://img0.adesk.com/download/53a16dc569401b6f29dae5c9",
      "lcover": "http://img0.adesk.com/download/53a16dc569401b6f29dae5cb",
      "sn": 999
    }],
    "banner": [{
      "value": {
        "ename": "",
        "isfeed": false,
        "tag": [],
        "id": "5d15ab5fe7bce720a3e5802b",
        "hide": false,
        "top": 0,
        "recommend": false,
        "utime": null,
        "type": 1,
        "status": "online",
        "user": {
          "gcid": "3e8e52505c96bd98d331b2929f6955e2",
          "name": "就是小清新",
          "gender": 0,
          "follower": 41378,
          "avatar": "http://img0.aibizhi.adesk.com/download/5c94c22831f6136a1c2b5d9e",
          "viptime": 1553766753,
          "following": 0,
          "isvip": false,
          "id": "5965cd0be7bce7312ef79fbf"
        },
        "favs": 5407,
        "atime": 1561701215,
        "desc": "可可爱爱，没有脑袋。",
        "count": 327,
        "name": "可爱文字",
        "url": [],
        "cover": "http://img5.adesk.com/5e7356e8e7bce73927c8e9a9?imageView2/3/h/240&sign=c7790f1afc97eeff991f47868d297ee0&t=6232e47c",
        "lcover": "http://img5.adesk.com/5e7356e8e7bce73927c8e9a9?imageView2/3/h/720&sign=c7790f1afc97eeff991f47868d297ee0&t=6232e47c",
        "subname": "",
        "sn": 999
      },
      "offtm": 1564969947,
      "target": "5d15ab5fe7bce720a3e5802b",
      "img": "5d478bdbe7bce720e1161ce9",
      "v4_thumb": "http://img0.adesk.com/download/",
      "new_img": "5d478bdbe7bce720e1161cea",
      "new_thumb": "http://img0.adesk.com/download/5d478bdbe7bce720e1161cea",
      "oid": null,
      "thumb": "http://img0.adesk.com/download/5d478bdbe7bce720e1161ce9",
      "module": 5,
      "_id": "5d478bdbe7bce720e1161ceb",
      "reco": "",
      "ontm": 1564969947,
      "desc": "",
      "atime": 1564969947,
      "type": 7,
      "id": "5d478bdbe7bce720e1161ceb",
      "market": [],
      "uid": "5d1ea8000422081fb3cfd810"
    }]
  },
  "code": 0
}
```

- msg：响应信息
- res：返回的数据
- album：返回的专辑数据
- name：专辑名
- desc：描述
- cover：封面
- lcover：大封面
- atime：创建时间
- favs：收藏数
- id：ID
- banner：返回的banner信息（与专辑无关，是时间的banner）
- value：banner宣传的专辑信息
- offtm：时间
- img：封面图片ID
- atime：创建时间
- target：所宣传的专辑的ID
- thumb：封面图片地址
- id：ID
- code：返回码

### 获取专辑下的壁纸

url：`http://service.picasso.adesk.com/v1/wallpaper/album/{专辑ID}/wallpaper`

拼接参数、解析与手机壁纸接口类似

url 示例：
`http://service.picasso.adesk.com/v1/wallpaper/album/5acc579be7bce7253c78cf9c/wallpaper?limit=30&adult=false&first=1&order=new`

```json
{
  "msg": "success",
  "res": {
    "album": {
      "ename": "",
      "isfeed": false,
      "tag": [],
      "id": "5d15ab5fe7bce720a3e5802b",
      "hide": false,
      "top": 0,
      "recommend": false,
      "utime": null,
      "type": 1,
      "status": "online",
      "user": {
        "gcid": "3e8e52505c96bd98d331b2929f6955e2",
        "name": "就是小清新",
        "gender": 0,
        "follower": 41378,
        "avatar": "http://img0.adesk.com/download/5c94c22831f6136a1c2b5d9e",
        "viptime": 1553766753,
        "following": 0,
        "isvip": false,
        "id": "5965cd0be7bce7312ef79fbf"
      },
      "favs": 5407,
      "atime": 1561701215,
      "desc": "可可爱爱，没有脑袋。",
      "count": 327,
      "name": "可爱文字",
      "url": [],
      "cover": "http://img5.adesk.com/5e7356e8e7bce73927c8e9a9?imageView2/3/h/240&sign=79fc13fb0daae74fa0e4dee40ec52ed1&t=6232e62e",
      "lcover": "http://img5.adesk.com/5e7356e8e7bce73927c8e9a9?imageView2/3/h/720&sign=79fc13fb0daae74fa0e4dee40ec52ed1&t=6232e62e",
      "subname": "",
      "sn": 999
    },
    "wallpaper": [],
    "subject": []
  },
  "code": 0
}
```

### 下载电脑壁纸

url：`http://img5.adesk.com/{壁纸ID}`


> `http://service.aibizhi.adesk.com/`
> `http://service.picasso.adesk.com/`