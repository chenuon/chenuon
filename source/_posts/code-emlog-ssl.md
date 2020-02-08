---
title: emlog使用ssl问题解决方案
date: 2019/12/5 15:06:18  
categories: 
- 程序源码
- emlog
tags: 
- emlog
- ssl

---
## 方案和下载

##### 第一步：服务器后台/虚拟空间后台添加ssl域名绑定

##### 第二步：后台更改网站地址为https://www.xxxx.com

##### 第二步：下载一下插件，后台激活

###### 下载地址一：
http://t.cn/AieVp1BK

###### 下载地址二：
链接：https://pan.baidu.com/s/1og76Tkxa3hRXGKmUYeA8sw  
提取码：t3xh 

## FAQ：
如无法正常开启
暂参考一下修改步骤：
#### 第一步：
网站跟目录下 /include/lib/option.php，请将以下内容粘贴到 get function 的 default 判断分支之前（在Emlog 5.3.1下是第43行）  
```
case 'blogurl':
return realUrl();
break;
```

#### 第二步：
 /include/lib/function.base.php，请将以下内容粘贴到文件的末尾

/\*\*获取当前访问的base url\*\*/
```
function realUrl() {
static $real_url = NULL;
if ($real_url !== NULL) {
    return $real_url;
}
$emlog_path = EMLOG_ROOT . DIRECTORY_SEPARATOR;
$script_path = pathinfo($_SERVER['SCRIPT_NAME'], PATHINFO_DIRNAME);
$script_path = str_replace('\\', '/', $script_path);
$path_element = explode('/', $script_path);
$this_match = '';
$best_match = '';
$current_deep = 0;
$max_deep = count($path_element);
while($current_deep < $max_deep) {
    $this_match = $this_match . $path_element[$current_deep] . DIRECTORY_SEPARATOR;
    if (substr($emlog_path, strlen($this_match) * (-1)) === $this_match) {
        $best_match = $this_match;
    }
    $current_deep++;
}
$best_match = str_replace(DIRECTORY_SEPARATOR, '/', $best_match);
$real_url  = $_SERVER['HTTPS'] === 'on' ? 'https://' : 'http://';
$real_url .= $_SERVER["SERVER_NAME"];
$real_url .= in_array($_SERVER['SERVER_PORT'], array(80, 443)) ? '' : ':' . $_SERVER['SERVER_PORT'];
$real_url .= $best_match;
return $real_url;
}
```
#### 第三步：
/init.php  
请用以下代码覆盖同名的define （在Emlog 5.3.1下是第39行）  
```
define('DYNAMIC_BLOGURL', Option::get("blogurl"));
```
#### 第四步：
最后如果网站使用http访问就强制转向https  
在你的模板下的header.php中增加以下代码  
```
if(!isset($_SERVER['HTTPS'])){
Header("HTTP/1.1 301 Moved Permanently");
header('Location: https://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
```
位置如图：  
![具体位置](/img/site-img.jpg)
