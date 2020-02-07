---
title: 一个本地仓库push多个远程仓库
date: 2020-02-07 12:04:32
top:
categories: 技巧应用
tags: 
- git
- 多仓库
---

# 如何实现

此次教程是为了将自己本地的hexo源代码备份到多个仓库而做的一个小教程，注意.ssh不能备份，自己存好到自己的重要文件备份的地方，比如QQ微云，比如百度网盘，这个id_rsa.pub的公匙千万不能泄露

除了假如我有github/gitee/coding/阿里coding，如何在将hexo文章发布到自己的服务器网站之后，又将源代码多方位备份

### 1.本地仓库配置

首先选一个国内速度比较快的备份仓库clone本地，在本地硬盘任意盘新建一个www目录，然后clone至本地，这里我选的阿里云的code

```
$ git clone git@code.aliyun.com:chenuon/coder.git

```

因为我是做备份用的，所以clone下来之后，无论本地的coder目录下面有多少文件，只留.git文件夹，其他全部删除，这里注意本地文件夹一定要把隐藏文件夹显示出来，如下图

![只留.git](/img/clonegit.jpg)

然后继续本地git命令

```
$ git -remote -v   //查看当前目录的远程仓库配置,如下图

```

![本地仓库](/img/localgit.jpg)

继续添加你要备份的其他仓库，如果你只备份这一个，可以忽略下面添加其他仓库的步骤

```
$ git remote add origin git@github.com:/chenuon/chenuon.git   /添加github仓库，注意一定要origin标识

```

我暂时只添加这一个,`git remote -v`重新查看当前目录的远程仓库配置，如下图

![本地仓库更新](/img/localgit1.jpg)

提交更新后的本地仓库到github仓库试试

```
$ git push -f origin master  //这里因为我还没有重新add，所有还是提前原来的文件

```

- -f：参数f首次建议加上，以后可以不添加，因为有的人在远程创建项目的时候会随着创建文件，没有f参数就不会覆盖远程已有的，导致push失败
- github就是在上面自定义的指向`git@github.com:/chenuon/chenuon.git`的本地标识

### 2.备份文件上传

接下来就是将自己的本地的hexo源文件全部复制到你建立的www文件目录，进行git push，按照git的正常push方式add->commit>push

```
$ git status  //查看更新的未上传的文件，红色字体
$ git add .   //添加至缓存
$ git commit -m '备注信息'  //给上传的文件增加备注，这里一定要加
$ git push origin master //推送上传
```



