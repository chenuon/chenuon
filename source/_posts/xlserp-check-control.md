---
title: xls系统开发(4)：审核反审双向控制
date: 2020-02-14 14:24:17
top: 
categories: 
- xls开发
tags: 
- erp系统
- xlserp系统
---

# 双向控制技巧

## 问题描述

xls系统开发过程中经常遇到如下问题：(此处以表单A、表单B、表单C为例)

```
表单A->审核->生成->表单B  
表单B->审核->生成->表单C

```

未经控制，会出现：

<table>
    <tr>
        <td bgcolor=#FFFF00><strong><font color="#FF0000">反审表单A，表单B成功删除，但是表单C仍然存在</font></strong></td>
    </tr>
</table>

## 解决方案

如上示例，问题拓展如下：

> 表单1->表单2->表单3->........->表单100

可知：

<table>
    <tr>
        <td bgcolor=#FFFF00><strong><font color="#FF0000">表单1~表单99，除去最后一个表单，其他均需另增加一项返回值识别</font></strong></td>
    </tr>
</table>

如图：

![返回值](/img/fhz.jpg)

同时：

<table>
    <tr>
        <td bgcolor=#FFFF00><strong><font color="#FF0000">表单表单2~表单99的业务公式内需往前一级返回一个返回值，此返回值可自定义</font></strong></td>
    </tr>
</table>

如图：

![返回此返回值到前一级](/img/fhz1.jpg)

<table>
    <tr>
        <td bgcolor=#FFFF00><strong><font color="#FF0000">最后，添加业务流程"报警"，并勾选终止后续case</font></strong></td>
    </tr>
</table>

![报警流程并终止](/img/baojing.jpg)

至此完成。