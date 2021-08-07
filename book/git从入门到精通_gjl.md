# Git 从入门到精通（高见龙）
## 4.1 用户设置
* 1.设置用户名
```sh
git config --global user.name "yourname"
```

* 2.设置邮箱
```sh
git config --global user.email "youremal"
```

* 3.检查当前设置
```sh
git config --list
```

## 4.2 可以给每个项目设置不同的作者吗？
```sh
git config --local user.name "yourname"
git config --local user.email "youremail"
```

## 4.3
* 设置缩写
```sh
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br branch
git config --global alias.l "log --oneline --graph"
git config --global alias.ls 'log --graph --pretty=format:"%h <%an> %ar %s"'
```

## 5.1 新增、初始Repository
* 进入一个目录，比如testRepo, 之后执行git init
```sh
git init
```

> 执行上面的git命令后，会在testRepo目录下生成一个.git目录，整个Git的精华都集中在这个目录中了

* 如果不想目录再被Git控制
> 你只需要删除.git目录

> 删除.git目录后，原来的git控制的所有版本都将找不回来了 

* /tmp目录，在系统重启时会被全部清空

## 5.2 把文件交给Git管理
* 1.在testRepo中新建一个文件
```sh
echo "hello git" > welcome.html

# 此时可以执行git status看一下Git有什么变化, 此时Git会提示welcome.html Untracked，即未被追踪

```

* 2.使用git add welcome.html让Git开始追踪文件welcome.html
> 执行完git add 后，现在可以执行git status再来看一下，welcome.html的状态变成newfile

### git add --all
> 这是将全部文件加到暂存区

### git add是对“文件新增、修改、删除”的一类操作添加到暂存区
* 比如对文件foo1做以下操作
```sh
echo "abc" > foo1		#（1）新建一个名为foo1的文件
git add foo1			#（2）将文件foo1加到暂存区
echo "def" >> foo1		#（3）向文件追加或修改foo1文件内容
git status			#（4）查看一下foo1在Git中的状态

# 位于分支 master
# 要提交的变更：
#   （使用 "git reset HEAD <file>..." 撤出暂存区）
#
#       新文件：    foo1
#
# 尚未暂存以备提交的变更：
#   （使用 "git add <file>..." 更新要提交的内容）
#   （使用 "git checkout -- <file>..." 丢弃工作区的改动）
#
#       修改：      foo1
#
# 未跟踪的文件:
#   （使用 "git add <file>..." 以包含要提交的内容）

```
> 在执行git status查看当前Git版本库状态时发现，foo1有两个记录，这是为什么？

> 其实在步骤（2）中是把foo1文件加入暂存区了，但在步骤（3）中双编辑了该文件。对Git来说，编辑的内容并没有再次被加入暂存区，所以此时暂存区中的数据还是步骤（2）中加进来的那个文件

> 这也就是说，如果步骤（3）对文件的改动是你想要的，那么必须再次执行git add foo1命令，把foo1文件再次加入暂存区

### 5.2.3 git add --all与git add .参数有什么不一样？
#### 1.Git版本
* Git 1.x版本
|使用参数|新增文件|修改文件|删除文件|
|:-|:-|:-|:-|
|-all|Y|Y|Y|
|.|Y|Y|X|


* Git 2.x版本之后
|使用参数|新增文件|修改文件|删除文件|
|:-|:-|:-|:-|
|-all|Y|Y|Y|
|.|Y|Y|Y|

#### 2.执行命令时的目录位置
* git add --all
> 对应此项目中所有异动都会被加入暂存区

* git add .
> 只会对当前目录及它的子目录中的异动加入暂存区

> 在当前目录外的其他目录，就不会被加到暂存区

### 5.2.4 把暂存区的内容提交到存储库里存档 
* 通过git add命令把异动加到暂存区，不算是完成整个流程。如果想将暂存区的内容永久保存下来，就需要使用git commit命令
> 注意：完成git commit才算是完成整个流程

> Git每次的commit都只会处理暂存区中的内容；这也就是说，在执行commit命令前，如果有文件异动没有被加入到暂存区，则这一次的commit就不会包含这些未在暂存区的文件异动

* 原则上在commit时要输入此次提交的信息
> 正常情况下是这样：git commit -m "NO33 bug is fix"
> 也可以这样执行commit来不加信息git commit --allow-empty -m ""

## 5.3 工作区、暂存区、存储库
* git add 命令把文件从工作区移至暂存区
* git commit命令把暂存区中的文件移至存储库
> git commit -a -m "msg"，可以将add与commit合并，但不处理未追踪的文件

## 5.4 查看记录
### 5.4.2 常见问题
* 想要找某个人或某些人的commit
```sh
git log --oneline --author="author1"			#找author1作者的commit日志
git log --oneline --author="author1\|authur2"		#找author1, author2作者的日志

```

* 想要找commit信息中是否含有某些关键字
```sh
git log --oneline --grep="someKey"			# 在commit信息中搜索someKey
```

* 在commit文件中找某些关键字
```sh
git log -S "fileKey"					# 在commit提交的所有文件中搜索关键字filekey
```

## 5.5 如何在Git中删除文件或变更文件名
### 5.5.1 删除文件
* git rm file1
> 它实现rm file1和git add file1这两个命令

> 文件会进入暂存区，不需要再执行git add

* 如果不想让git再控制这个文件了，可以加上--cached参数
```sh
git rm file1 --cached 			#此命令不会执行rm file1, 即git不再追踪文件file1了
```

### 5.5.2 改名
* git mv file1 filenew
> 让git 把文件file1改名为filenew

> 执行完git mv命令后，可以查一下git状态，可以发现有renamed：file1 -> filenew记录
* 如果使用mv file1 filenew，则还需要执行git add --all命令将文件异动加入暂存区












