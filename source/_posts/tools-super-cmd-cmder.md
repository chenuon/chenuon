---
title: 超级cmder下载与集成右键菜单
date: 2020-02-07 23:29:22
top:
categories: 常用软件
tags: 
- cmder
---

# 介绍

为何用cmder，

- 复制复制方便，可选择直接ctrl+c,即可
- 可用git，可设置窗口和字体颜色
- 可多窗口，并且很多快捷键和谷歌浏览器操作类似,等等很多功能。

### 1.下载

[cmder官方下载](https://github-production-release-asset-2e65be.s3.amazonaws.com/11276147/3aa07700-3262-11ea-8a1a-ba55f69fdebd?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200207%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200207T124410Z&X-Amz-Expires=300&X-Amz-Signature=a1c878a227f13926deb718729f560340a6f0fa7d6966e1ed382d826bf8133e58&X-Amz-SignedHeaders=host&actor_id=59986158&response-content-disposition=attachment%3B%20filename%3Dcmder.7z&response-content-type=application%2Foctet-stream)

我下载然后转存国内了，速度很快

[我的下载](http://sz-btfsv2.ftn.qq.com/ftn_handler/795f3d7e508bab839024a7c9cc0fd8215e5fa53ffbc36223aea2730b8996f524faeb12b4b4f8c9088a0b16d062f7d0f30c02d6cc08e352d588e6c47013423dab/?fname=cmder.7z&k=0c633231929a23cbab8610354231041805565755535705521c5b5602071c020205551f085257041a0307020351080f5353010555643936545c0757434a064c3745&fr=00&&txf_fid=7527da8aa9fce6c9638f366d8f217947a471dce8)

![360杀毒1](/img/36001.jpg)

![360杀毒2](/img/36002.jpg)

```
360木马查杀扫描日志
开始时间: 2020-2-8 10:45:03
扫描用时: 00:16:25
扫描类型: 自定义扫描
扫描引擎:360云查杀引擎（本地木马库）  360启发式引擎  QEX脚本查杀引擎 
扫描文件数: 12252
系统关键位置文件: 0
系统内存运行模块: 0
压缩包文件: 1
安全的文件数: 6127
发现安全威胁: 0
已处理安全威胁: 0


扫描选项
扫描后自动关机: 否
扫描模式: 速度最快
管理员：是


扫描内容
F:\package office\cmder.7z


白名单设置

扫描结果
未发现安全威胁

```



### 2.右键集成

关于cmder如何加入到右键菜单里面，操作如下：

把 Cmder 安装目录的路径添加到系统环境变量 Path 变量中：电脑 → 属性 → 高级系统设置 → 环境变量 → 系统变量 → Path → 编辑 → 新建

```
名称：cmder    //名称
目录：x:/xxx/cmder.exe    /你的cmder目录

```

进入 Cmder 目录，右键以管理员身份运行 Cmder.exe 程序

输入 Cmder.exe /REGISTER ALL 并回车即可

将Cmder默认的命令提示符`"λ"`改为`“$”`，
在`cmder\vendor`中的`clink.lua`内做如下修改"λ"替换成"$"

### 3.常用快捷键

```
Tab       自动路径补全
Ctrl+T    建立新页签
Ctrl+W    关闭页签
Ctrl+Tab  切换页签
Alt+F4    关闭所有页签
Alt+Shift+1 开启cmd.exe
Alt+Shift+2 开启powershell.exe
Alt+Shift+3 开启powershell.exe (系统管理员权限)
Ctrl+1      快速切换到第1个页签
Ctrl+n      快速切换到第n个页签( n值无上限)
Alt + enter 切换到全屏状态
Ctr+r       历史命令搜索
Tab         自动路径补全
Ctrl+T      建立新页签
Ctrl+W      关闭页签
Ctrl+Tab    切换页签
Alt+F4      关闭所有页签
Alt+Shift+1 开启cmd.exe
Alt+Shift+2 开启powershell.exe
Alt+Shift+3 开启powershell.exe (系统管理员权限)
Ctrl+1      快速切换到第1个页签
Ctrl+n      快速切换到第n个页签( n值无上限)
Alt + enter 切换到全屏状态
Ctr+r       历史命令搜索
Win+Alt+P   开启工具选项视窗

```

### 4.中文乱码问题

将下面的4行命令添加到cmder/config/aliases文件末尾,如果还是不行参考前面字体设置，将前面提到的字体设置里面的Monospace的复选框不选中。还有就是养成良好的编码习惯文件命名最好不要有中文。

```
l=ls --show-control-chars 
la=ls -aF --show-control-chars 
ll=ls -alF --show-control-chars 
ls=ls --show-control-chars -F

```

