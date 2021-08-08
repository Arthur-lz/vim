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



## 5.14 不小心使用hard模式reset了某个commit，还救得回来吗?
> 在执行reset前一定要确认工作区中的内容已经存到git存储库了，否则reset --hard会被删除，如果不加--hard参数不会删除工作区的，但会删除暂存区的

* 1.退回reset前

* 2.使用reflog
> 切换分支或reset都会让HEAD移动，而HEAD移动时会在reflog中留下一条记录

> git log命令加上参数-g，也可以进行reflog

## 5.15 HEAD是什么
* HEAD简介
> HEAD指向某一个分支，通常可以把它当作“当前所在分支”来看

> 在.git目录有一个HEAD文件

```
cat .git/HEAD
ref: refs/heads/master			# 从文件可以看出，HEAD当前正指向master分支
cat .git/refs/heads/master		# master分支是一个40个字节的文件
```

## 5.16 可以只commit一个文件的部分内容吗
* git add -p
> 在add命令中增加参数-p，Git就会询问是否要把这个区域加到暂存区，如果选择y则把整个文件加进支。如果只想送出部分内容，选择e，接着会出现编辑器让你选择想要加到暂存区的的区域

## 5.17 SHA-1值是怎么算出来的？
* SHA-1是一种杂凑算法
> 计算结果通常以40个十六进制的数字表示

> 特点，输入一样的值，就有一样的输出值

* 使用git内置的hash-object命令计算SHA-1值
```sh
echo "hello, lz" | git hash-object --stdin
cat somefile | git hash-object --stdin
```

## 5.18 .git目录中有什么？Part 1
* Git中的4种对象
> bolb对象

> tree对象

> commit对象

> tag对象

* 小结
> 把文件加入Git之后，文件的内容会被转成blob对象存储

> 目录及文件名会存放在tree对象内，tree对象会指向blob对象或其他的tree对象

> commit对象会指向某个tree对象。除了第一个commit，其他的commit都会指向前一次的commit对象

> Tag对象会指向某个commit对象

> 分支虽然不属于这4种对象之一，但它会指向某个commit对象

> 往git服务器上推送之后，在.git/refs下就会多出一个remote目录，里面放的是远端的分支，基本上与本地分支类似，同样也会指向某个commit对象

> HEAD也不属于这4种对象之一，它会指向某个分支

## 5.19 .git目录中有什么？Part 2
* Git在checkout时的变化
> 当checkout到另一个commit时，可能会出现detached HEAD情况，这是因为目标commit没有分支指着

> Git 根据这条git checkout somecommitnum，把原本放在.git/objects中以SHA-1计算命令的目录及文件，一个一个地复原成原来的样子

> git 不是做差异备份。在Git切换commit时会像拎葡萄一样整串抽出来，所以checkout效率相对较高，因为它不需要一个一个的拼凑历史记录（差异备份的需要拼凑）

> git的这种方式存放文件，就算只改了一字也会做出一个新的对象，那会不会很浪费空间？所以Git提出了资源回收机制，启动该机制时，Git会非常有效率的压缩对象。

* git什么时候会自动触发资源回收机制
> (1) 当.git/objects目录的对象或打包过的packfile数量过多时，Git会自动触发资源回收命令

> (2) 当执行git push命令把内容推至远端服务器时

* git 手动触发资源回收机制
```sh
git gc
```

# 第6章
## 6.2 开始使用分支
* git branch 
> 查看当前项目所有分支

* git branch someone
> 创建一个名为someone的分支

* git branch -m oldname newname
> 修改分支名称oldname为newname

* git branch -d someone
> 删除分支someone

> 如果被删的分支有合并未完成，则无法使用-d来删除分支，此时需要使用-D来强制删除分支 

* git branch -D someone
> 强制删除分支someone

* 没有什么分支是不可以删除的
> master分支也可以删除，它只是默认分支，没有什么特别

* git checkout branchname
> 切换分支到branchname

## 6.3 对分支的误解
* Git中的分支并不是通过复制目录或文件来进行改动的，分支就是一张贴纸，贴在某个commit上而已
* 一个分支不够就来两个吧
> 创建新分支前，HEAD指向master，而master贴在最近一次的commit上
> 刚创建的分支newBranch与master分支贴在同一个地方

> 接下来执行git checkout newBranch命令，切换到newBranch分支。此时，HEAD转而指向newBranch分支，表示newBranch是当前的分支

> 接着进行一次commit，这个新的commit会指向前一个commit，然后newBranch分支上的贴纸就会被撕下来，转而贴到最新的那个commit上；当然HEAD也是一样

* 切换分支不会影响已经在工作目录中的那些改动

## 6.4 合并分支





