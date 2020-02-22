---
title: 【傻瓜式】史上最详细的hexo部署到个人服务器 (git+nginx+hexo)
date: 2020-01-29 19:44:28
categories: 
- 程序源码
- hexo
tags: 
- hexo
- git
- nginx
- node
- linux
top: 10
---
# 从0到1
本次以阿里云重新安装系统开始为例，详细讲解步骤：  
## 一、本地环境【客户端】  
这里以本地的win7电脑为例，  
### 1.下载node，
默认安装，安装完成之后，`node -v`看看版本号
[node下载](http://sz-btfs.ftn.qq.com/ftn_handler/393789bfcb014d6799f1445cbc31a3abb8915f8220fe8fbec4d3f0ba847c48252729a0666e5161d62da0bb2aba4f25a4945b10a4b1f2095a892344db5e64c94c/?fname=node-v12.14.1-x64.msi&k=2c3937356465e1cdfcdc15314235051c540a0103065151024b0b0f025318030051581a5455070e1e040e0f005d575555530d0e0d6420375d095d52181204051d570d1904494d01074854445c6441&fr=00&&txf_fid=991d104663800bba790a73dd771322c86ff392e1)  
### 2.安装hexo
安装完node环境后，本地cmd运行  
```
npm install -g hexo-cli  

```
然后`hexo -v`查看版本  
### 3.hexo初始化
本地cmd执行以下命令(默认目录，不管他，一般在administrator的文档目录)  
```
hexo init myblog && cd myblog
npm install  

```
### 4.hexo配置
打开myblog文件夹，首先打开package.json，添加如下script  
如下图：特别注意1、2两个地方，现有的就更改，没有的就增加  
![package配置](/img/pack.jpg)

### 5.本地测试
执行代码`npm run start`开启本地测试，打开浏览器，访问127.0.0.1:4000打开hexo页面  
![hexo默认页面](/img/hexo.jpg)  
<table>
<tr>
<td bgcolor=#FFFF0>
<strong><font color="#FF0000">【日志列表排序插件】</font></strong>
</td>
</tr>
</table>
执行以下命令，日志列表才能按照顺序来排序,同时也带了置顶功能，编写文章，加入一个`top:`即可：  

```
npm install hexo-generator-index-pin-top --save  

```

### 6.本地git
下载git,默认安装路径,  
[git下载](http://sz-btfs.ftn.qq.com/ftn_handler/088af645b19c44bf57aad409d4b099c72699f4a19d0b9488dbd03db94546a14208093863060f90efa46a43e629e71b5d598158104d7382f9fe9eab44a2640da5/?fname=Git-2.25.0-64-bit.exe&k=7b306463d1e20ec4abd5466747330616555600535151005a1c515601581e005f0508490104560114075650075001525a025152576126347e584449514f010117011d52574c515d4d1f551c066147&fr=00&&txf_fid=af87796ee35491daae8ae0864063e7f4357cb6f2)  
打开git的.ssh目录`(我的是C:\Users\Administrator\.ssh)`，然后右键git bash如下图  
![git](/img/git.jpg)  
执行如下命令：
```
git config --global user.name "你的用户名"  
git config --global user.email 你的邮箱  
ssh-keygen -t rsa -C "你的邮箱"  
git config --global core.autocrlf false //禁用自动转换，这个不设置后面上传时会出现警告  

```
然后得到和我同样的两个文件(压缩包不算，是我自己压缩的,known_hosts这个是本地ssh链接服务器生成的)  
最后特别注意，一定要执行以下命令安装本地的一个git上传hexo插件

<table>
<tr>
<td bgcolor=#FFFF0>
<strong><font color="#FF0000">【git上传插件】</font></strong>
</td>
</tr>
</table>  

```
npm install hexo-deployer-git --save  

```

## 二、linux环境【服务器】

以centos系统为例，我这里吧我的ubuntu换成centos8了  
![更换系统](/img/ghxt.jpg)  

### 1.搭建git环境
xshell进入后台，安装git  
```
yum install git  

```
然后  
```
git --version  

```
查看git版本  
创建一个git用户，然后按照以下代码步骤一步一步完成：  
```
adduser git //添加git用户
passwd git // 设置git密码  
su git // 切换用户  
cd /home/git/   //进入git目录
mkdir .ssh  //创建免密公匙目录  
mkdir -p projects/blog // 创建文件来放置hexo静态工程  
mkdir repos && cd repos //创建文件放置git仓库  
git init --bare blog.git // 创建一个裸露的仓库  
cd blog.git/hooks  //进入钩子目录
vi post-receive //创建hook钩子函数(git提交时自动部署)  

hook钩子函数内容:  (注xshell命令vi/vim这两个命令的用法，输入之后按一下i字母键代表输入，输入完了之后，先按Esc键，再输入:wq代表保存退出，:q是退出不保存)
#!/bin/sh 
git --work-tree=/home/git/projects/blog --git-dir=/home/git/repos/blog.git checkout -f  

```

修改权限  
```
chmod +x post-receive
exit // 退出到 root 登录
chown -R git:git /home/git/repos/blog.git // 添加权限  

```
到这里服务器git环境搭建完成，测试下能否可能服务器的目录到本地：  
随便打开一个文件夹，输入以下命令：  

```
git clone git@server_ip:/home/git/repos/blog.git  

```
成功以后如图  
![克隆ok](/img/gittest.jpg)  

### 2.建立ssh免密登录：  
这里注意，还是git用户，不能退出，不能切换到root管理用户
创建authorized_keys文件  

```
cd /home/git/.ssh  //注意是用git用户进这个目录，不是root
touch authorized_keys  //存放客户端的ssh公钥(id_rsa.pub)  
chmod 600 authorized_keys   //配置权限  
cd .. //退出.ssh目录  
chmod 700 .ssh  //.ssh目录必须700权限  

```

然后用winscap远程连接服务器，打开这个文件，注意看以下操作：  
客户端本地(就是我自己的电脑)进入.ssh目录，右键git bash，同上面的操作，然后输入如下命令:  
`cat id_rsa.pub`，复制公匙key，从ssh-rsa开始复制到最后的邮箱地址.com,如下图:  
![免密key](/img/pubkey.jpg)  
粘贴到刚刚前面winscap打开的authorized_keys里面，复制完了注意，粘贴的时候后面不能有任何的空格和回车，最后是鼠标点到最后，按del键清空下，这里就是把本地的id_rsa.pub内容复制到authorized_keys里面  
测试下能否本地免密登录，首次联系会提示你输入`yes`，然后输入密码，如下图  
![首次连接](/img/fist.jpg)  
![免密成功](/img/sslok.jpg)  
到此免密成功！

### 3.限制git登录
git用户的登录权限禁掉，只能clone和push，修改目录/etc/下面的passwd文件  

```
cat /etc/shells // 查看`git-shell`是否在登录方式里面，有则跳过
which git-shell // 查看是否安装 
vi /etc/shells
添加(which git-shell)显示出来的路劲，通常在 /usr/bin/git-shell

```

修改

```
cd /etc  
vi passwd

```
更改方式如下：

```
将原来的
git:x:1000:1000:,,,:/home/git:/bin/bash //原来的
修改为:
git:x:1000:1000:,,,:/home/git:/usr/bin/git-shell //修改后的  

```



### 4.nginx配置

这里非常重点，特别注意，容易出很多错。所以在root根目录，先执行以下几个命令，执行过程中就不会报错了:  
```
yum update  //更新  
yum -y install pcre-devel openssl openssl-devel  
yum -y install gcc-c++  
yum install -y zlib-devel  

```
然后安装nginx，执行以下命令，一步一步来:  
```
centos8系统自带nginx，所以直接yum  
yum install nginx  //安装
nginx -t  //测试安装  
systemctl enable nginx  //添加系统自启动
systemctl start nginx  //启动服务,还有stop/restart  

```
以上代码只要前面的环境都安装了，到这里不会报任何错误的，然后修改nginx配置文件：  

```
cd /etc/nginx/
vi nginx.conf
修改 root 路径为: /home/git/projects/blog; 
同时将 user 改为 root  

```
如下图，改三个地方：  
![修改处](/img/nginxconf.jpg)  

```
#user everyone;修改为user root; //注意去掉#字符  
server_name localhost;修改为server_name 你的域名or公网IP  
root index;修改为root /home/git/projects/blog; 

```
改完后记得`systemctl restart nginx`，就可以访问你的域名啦

```
npm  run  start  

```
###  5.修改hexo配置
返回本地hexo根目录，找到_system.yml，代码样式如下   
```
deploy:
  type: git
  repo: git@serverId:/home/git/repos/blog.git  //serverID是你的服务器地址或者git地址
  branch: master   

```

如果有多个仓库，repo这里填写方式一定要特别注意：  
```
repo:
  linxu: git@serverId:/home/git/repos/blog.git //注意缩进
  github: git@your git site    //注意缩进

```
每个仓库都可以命名一个名称,我自己的就写的linxu,还有例如github等等，这个可以随便写，没有规定，但是要  

特别注意，多个仓库并列，必须要缩进，不能和repo并齐，否则上传会出错

### 6.上传测试

至此，所有配置均完成，然后本地cmd写一篇文章测试下

```
hexo new hello

```

生成的hello.md文件在`myblog/source/_pos`下面，打开可以看到发现默认的文章title就是你新建的hello.md

的hello，这里有个小技巧，修改`myblog\scaffolds`下面的post.md，如下：

```
title: {{ title }}  //标题：注意窍门，hexo new的是你网页打开的链接显示，title可以改成中文
date: {{ date }}  //时间轴
top:   //置顶排序，数字越大越靠前
categories:   //分类
tags:   //标签

```

这样下次新建文章，就带有上面的这些字段了，

## 三、部署完成

### 1.总结

> 回顾从2008年开始入坑座网站，到现在共12年了，中间陆陆续续中断了几年，经历了纠结域名、纠结sitemap、纠结商业化、纠结JS/CSS/PHP/HTML等等，到去年年底，已经几年没碰网站的我，又重新开始了这一切，不过人到中年，不纠结了，有一个喜欢的域名、一个国内的小水管服务器，再备案，落伍太久的我，一开始选择的还是多年前沿用的emlog，结果发现emlog无故把我的论坛账号封停了，就转战typecho，无意中发现hexo的这个主题3-hexo，所以就又转过来了，前后花了半个月的时间，因为不懂hexo的模式，钻研了下服务器的使用和git的使用。

总归：

​      部署完成，web维持正常更博即可，转移重心到正轨：`xls系统开发`和`Python学习`

ps：我的服务器是不知道哪里的小水管，不是阿里云的，所以增加了一下步骤：

服务器远程操作，开放443端口

1.先查看服务器防火墙开放的端口

```
firewall-cmd --zone=public --list-ports     //查看防火墙的开放端口

```

2.允许防火墙放行443端口

　　命令含义：

　　　　--zone #作用域

　　　　--add-port=443/tcp #添加端口，格式为：端口/通讯协议

　　　　--permanent #代表永久生效，没有此参数重启后失效

```
firewall-cmd --zone=public --add-port=443/tcp --permanent

```

3.重启防火墙

```
firewall-cmd --reload

```

