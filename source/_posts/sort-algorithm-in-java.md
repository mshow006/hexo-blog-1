---
title: 排序算法-Java实现
tags:
  - sort
comments: true
date: 2020-11-09 13:37:17
updated: 2020-11-09 13:37:17
---

### 冒泡排序

```java
public void sort(int[] array) {
    for (int i = array.length - 1; i > 0; i--) {
        boolean swapped = false;
        for (int j = 0; j + 1 <= i; j++) {
            if (array[j] > array[j + 1]) {
                swap(array, j, j + 1);
                swapped = true;
            }
        }
        if (!swapped) {
            // 本轮没有替换, 提前结束
            break;
        }
    }
}
```

## 选择排序
<!-- more -->

```java
    public void sort(int[] array) {
        int len = array.length;
        for (int i = 0; i < len - 1; i++) {
            // 初始化最小值索引
            int min = i;

            for (int j = i + 1; j < len; j++) {
                if(array[min] < array[j]) {
                    min = j;
                }
            }

            // 最小值索引已更改, 交换
            if(min != i) {
                swap(array, i, min);
            }
        }
    }
```

## 插入排序

```java
public void sort(int[] array) {
    for (int i = 1; i < array.length; i++) {
        int k = array[i];
        while (i - 1 >= 0 && array[i - 1] > k) {
            array[i] = array[i - 1];
            i--;
        }
        array[i] = k;
    }
}
```

## 快速排序

```java
public void sort(int[] array) {
    doSort(array, 0, array.length - 1);
}

private void doSort(int[] array, int left, int right) {
    if (left >= right) return;

    int i = left - 1, j = right + 1, mid = array[left + right >> 1];

    while (i < j) {
        do i ++; while (array[i] < mid);
        do j --; while (array[j] > mid);
        if(i < j) swap(array, i, j);
    }

    doSort(array, left, j);
    doSort(array, j + 1, right);
}
```

## 归并排序

```java
public void sort(int[] array) {
        doSort(array, 0, array.length - 1);
    }

    private void doSort(int[] array, int left, int right) {
        if (left >= right) return;

        int mid = left + right >> 1;
        doSort(array, left, mid);
        doSort(array, mid + 1, right);

        int i = left, j = mid + 1, k = 0;
        int[] tmp = new int[right - left + 1];
        while (i <= mid && j <= right) {
            if (array[i] < array[j]) tmp[k++] = array[i++];
            else tmp[k++] = array[j++];
        }

        while (i <= mid) tmp[k++] = array[i++];
        while (j <= right) tmp[k++] = array[j++];

        for (i = left, j = 0; i <= right; i++, j++) array[i] = tmp[j];
        // System.arraycopy(tmp, 0, array, left, right - left + 1);
    }
```

## 堆排序

```java
public void sort(int[] arr, int n) {
    int size = n;
    for (int i = 1; i <= size; i++) {
        push_up(arr, i);
    }
    for (int i = 1; i <= n; i++) {
        swap(arr, 1, size);
        size--;
        push_down(arr, size, 1);
    }
}

private void push_down(int[] arr, int size, int u) {
    int t = u, left = u * 2, right = u * 2 + 1;
    if (left <= size && arr[left] > arr[t]) t = left;
    if (right <= size && arr[right] > arr[t]) t = right;
    if (u != t) {
        swap(arr, u, t);
        push_down(arr, size, t);
    }
}

private void push_up(int[] arr, int u) {
    while (u / 2 > 0 && arr[u / 2] < arr[u]) {
        swap(arr, u / 2, u);
        u /= 2;
    }
}
```

源码地址：[AlgorithmsInJava/sort](https://github.com/yingming006/AlgorithmsInJava/tree/main/sort)