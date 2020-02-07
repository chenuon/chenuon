---
title: typecho默认Markdown编辑器字体颜色和背景颜色代码
date: 2020/1/15 23:55:44   
categories: 
- 程序源码
- typecho
tags: 
- typecho
- Markdown

---
# 1.仅仅字体颜色
```
<font color="red">这里是红色</font>
```

效果如下：  
<font color="red">这里是红色</font>

# 2.添加背景颜色
```
    <table>
    <td bgcolor=#FFFF0>
    <font color="#FF0000">大西瓜</font>
    </td>
    </table>
```
效果如下：

<table>
<td bgcolor=#FFFF0>
<font color="#FF0000">大西瓜</font>
</td>
</table>

# 3.继续添加粗体

```
    <table>
    <td bgcolor=#FFFF0>
    <strong><font color="#FF0000">大西瓜</font></strong>
    </td>
    </table>
```

效果如下：  
<table>
<td bgcolor=#FFFF0>
<strong><font color="#FF0000">大西瓜</font></strong>
</td>
</table>