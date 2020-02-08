---
title: typecho导航调用分类
date: 2020/1/14 23:52:44   
categories: 
- 程序源码
- typecho
tags: 
- typecho
- 导航
- 分类

---
# 找代码
找到header.php的以下代码
```
<?php $this->widget('Widget_Contents_Page_List')->to($pages); ?>
<?php while($pages->next()): ?>
<a<?php if($this->is('page', $pages->slug)): ?> class="current"<?php endif; ?> href="<?php $pages->permalink(); ?>" title="<?php $pages->title(); ?>"><?php $pages->title(); ?></a>
<?php endwhile; ?>
```
这个是独立页面"关于"的代码，然后如果想在导航的关于前面显示，就加在前面，反之加在后面，代码如下
## 加代码

```
<?php $this->widget('Widget_Metas_Category_List')->to($category);?>
<?php while ($category->next()):?>
<a <?php if($this->is('post')):?>
<?php if($this->category == $category->slug):?>class="current"<?php endif;?>
<?php else:?>
<?php if($this->is('category', $category->slug)):?>class="current"<?php endif;?>
<?php endif;?> href="<?php $category->permalink();?>"><?php $category->name();?>
</a>
<?php endwhile; ?>
```