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
* git merge someone
> 如果想要用master分支来合并someone分支，主要先切换回master分支。someone分支有最新的commit，而在master分支中没有，所以现在的场景是让master也具有与someone分支上新增的那些commit

### A合并B，与B合并A有什么不同？
* 第一类情况，A、B都是来自master分支，那么一定是master分支收割A、B分支
* 第二类情况，A、B都是来自master分支，那么如果是A、B合并，此时Git会创建一个commit同时指向这两个分支A、B
> 假设由A来合并B分支

```sh
git checkout A			# 先切换到分支A
git merge B			# 合并分支B，此时Git会创建一个新的commit对象Nc同时指向A原来的commit对象，又指向B的commit对象，而A最终会贴到Nc上
```

> 有哪里不一样？就是Git会额外生成一个commit对象Nc，Nc对象会有两个老爸，谁合并谁就会在前面的区别

## 6.5 为什么我的分支没有“小耳朵”
> 非快转模式合并的好处是可以完整保留分支的样子

> git merge x --no-off, 参数--no-off指不要使用快转模式合并，这样会额外做出一个commit对象

## 6.6 合并过的分支要保留吗？
* 都可以
> 合并过的分支想删就删, 删除分支只是把一张贴纸撕下来而已, 被贴纸贴的东西不会因为撕下贴纸而消失

* 没有被合并的分支就是另一回事了

## 6.7 不小心把没有合并的分支删除了救得回来吗？
* 有一点要明确，删除掉分支后，原来的commit都还在.删除分支后，只是因为你不知道或没记下那些commit的SHA-1值，所以不容易再拿来利用
* 可以使用以下命令来把已经删除分支所对应的commit找到
```sh
git branch newBranch b329920		# b329929是被删除分支的commit对象的SHA-1值, 这是你知道被删除分支的commit的SHA-1值的情况
```

* 如果没有把刚刚删除的那个分支的SHA-1值记下来怎么办？
> 可以使用git reflog命令来查找，reflog默认会保留30天

### 其实所谓的“合并分支”，合并的并不是“分支”
> 合并分支其实是合并“分支指向的那个commit”

## 6.8 另一种合并方式（使用rebase）
* git rebase dog
> cat现在要重新定义cat的参考基准，并且将使用dog分支作为cat的新参考基准

* 谁rebase谁会有区别吗？
> 从最后的文件来说无区别

> 就历史记录来说有区别，谁rebase谁，会造成历史记录的先后顺序不同

### 怎么取消rebase
* 1.使用reflog

* 2.使用ORIG_HEAD，它会记录“危险操作”之前的HEAD位置
> 分支合并或reset都是危险操作

* 3.使用rebase的时机
> 如果已经push出去了，且因为rebase等于改动了历史记录，改动已经推出去的历史记录可能会给别人带来困扰，所以推出去的如果没有必要则不使用rebase

## 6.9 合并发生冲突了怎么办
## 6.10 为什么说在Git中开分支“很便宜”
> 分支的文件保存在.git/refs/heads/中

> 分支就是一个40字节的文件，所以不贵

## 6.11 Git如何知道现在是在哪一个分支
* cat .git/HEAD

## 6.12 HEAD也有缩写
* git 1.8.5版本之后的版本，在使用Git时，可以用@来代替HEAD
```sh
git reset HEAD^
git reset @^		# 与上面的等效
```

* ORIG_HEAD是什么？

## 6.13 可以从过去的某个commit再创建一个新的分支吗？
* git branch newBranch commit_SHA-1
> newBranch是新分支名

> commit_SHA-1是过去的某个commit的SHA-1值

* git checkout -b newBranch commit_SHA-1
> 与git branch newBranch commit_SHA-1功能相同

# 第7章 修改历史记录 
* reset, rebase, revert指令区别

|指令|修改历史记录|说明|
|:-|:-|:-|
|reset|是|把当前状态设置成某个指定commit状态，通常用于尚未推出去的commit|
|rebase|是|不管是新增、改动、删除commit，还是用来整理、编辑还没有推出去的commit，都相当方便，但通常只适用于尚未推出去的commit|
|revert|是|新增一个commit来反转（或称为取消）另一个commit的内容，原来的commit依旧保留在历史记录中。虽然会因此而增加commit数量，但通常比较适用于已经推出去的commit，或者不允许使用reset或rebase来修改历史记录指令的情景（如多人开发的项目）|

# 第8章 标签
## 8.1 使用标签
* 什么时候使用标签？
> 里程碑，如软件版本号之类的

* 两种标签
> 轻量标签，它指向的是某一个commit
```sh
git tag sometag commit_SHA-1
```

> 有附注标签，它指向的是某个tag对象，这个tag对象再指向那个commit

```sh
git tag sometag commit_SHA-1 -a -m "some message you want to say"

* 删除标签
```sh
git tag -d sometag
```

## 8.2 标签与分支有什么区别
> 留下的是标签，跟commit走的是分支

> 标签放在.git/refs/tags/中

> 分支放在.git/refs/heads/中

# 第9章 其他常见的情况及一些冷知识
## 9.1 手边的工作做到一半，临时要切换到别的任务
* 1. 先commit当前进度, 接着使用reset 命令
```sh
# 现在的工作在master分支
git add --all					# 第一步, 保存当前工作进度
git commit -m "not finish yet"			# 第一步, 保存当前工作进度
						# 第二步, 转去做其他工作 (需要切到别的分支，如cat）
...
git checkout master				# 第三步, 切换回原来的分支
git reset HEAD^					# 第四步, reset回去; 这是书中这样写的，但为什么要reset呢？直接到第三步切回原来的分支不就可以继续原来的工作继续了吗？
```

* 2.使用stash 
```sh
# 假设现在工作的分支是master
git stash					# 这一句执行完后，当前工作目录下的文件改动将“消失”，其实stash把它们保存起来了
git stash list					# 这一句是用来查stash中保存了什么，显示的结果没有那么具体
						# 现在可以去处理其他工作了，如切到别的分支cat
...
git checkout master				# 切换回原来的分支
git stash pop stash@\{0\}			# 把stash捡回来
```
> 个人建议使用第一种

## 9.2 不小心把账号密码放在Git中了，想把它删除该怎么办
* 首先要明确，在git中管理的文件都存在哪里（或存在哪些对象上）
> 本地工作目录中

> blob对象

> commit对象

> reflog

### 1. 直接删除.git目录、再把密码文件删除、再commit
> 无技术可言

> 之前的所有commit记录全部消失不见，永久性消失的那种

### 2. 使用filter-branch指令
> 这是批量修改每一个commit对象

```sh
git filter-branch --tree-filter "rm -f config/passwd.txt"
```
> 1.filter-branch指令可以根据不同的filter,一个一个commit去处理

> 2.这里使用了--tree-filter这个filter, 它可以在checkout到每个commit时执行指定的指令，执行完成后再自动重新commit。上面的例子，便是执行"强制删除config/passwd.txt"

> 3.因为删除了某个文件，所以在那之后的commit都会重新计算，即产生一份新的历史记录，信息一旦加到git中，真的要把它删除并不容易

### 3. 如果后悔了，怎样恢复到执行filter-branch指令之前的状态
```sh
git reset refs/original/refs/heads/master --hard
```

### 4. 如果已经推出去了
> 如果推出去了就像泼出去的水一样收不回来，能做的就是使用git push -f指令重新强制推一份刚刚filter-branch过的commit上去

### 5. 将其他分支的commit捡过来合并
```sh
git cherry-pick commit_id
```

### 6. 一次捡多个commit
```sh
git cherry-pick commit_id1 commit_id2 commit_id3
```

### 7. 捡过来的分支先不合并
```sh
git cherry-pick commit_id --no-commit
```

## 9.3 怎样把文件真正从git中移除
### 1. 删除.git目录
### 2. 使用rebase或filter-branch指令来整理
### 3. 全部断干净
```sh
git filter-branch -f --tree-filter "rm -f test.yml"
```
> 命令中增加了-f参数，是要强制写filter-branch的备份点

* 这里使用filter-branch指令把文件从工作目录中移除，这时文件test.yml的确不见了，但还有几个与资源回收有关的事情需要处理

```sh
rm .git/refs/original/refs/heads/masterg	# 这个文件还对刚刚做的filter-branch动作念念不忘，随时可以通过它再跳回去，所以要切断这条线
```

* 对这个文件念念不忘的还有reflog，所以也要清一下
```sh
git reflog expireg --all --expire=now	#这个指令是要求reflog立即过期（默认要30天），接着执行git fsck指令，就可以看到很多unreachable状态的对象了

git fsck --unreachable
Checking object directories: 100% (256/256), done.
unreachable blob 8baef1b4abc478178b004d62031cf7fe6db6f903

git gc --prune=now		# 这是启动git的资源回收机制，叫“垃圾车”过来，把它们立即运走

git fsck			# 查一下
Checking object directories: 100% , done.
Checking objects: 100%, done.
# 垃圾被运走后，再使用git reset commitID -hard命令恢复也是会失败，git已经找不到原来的那个SHA-1值了
# 如果这些内容已经被推出去了，最后要再加一步，使用git push -f 把在线的记录覆盖
```

## 9.4 你知道git有资源回收机制吗
* 在git中，每当把文件加到暂存区时，git便会根据文件内容制作出blob对象
* 每当完成commit时，便会跟着生成所需的Tree对象和commit对象
* 随着对象越来越多，当满足条件时，git会自动触发资源回收机制来整理这些对象，同时也会unreachable状态的对象清除, 这样除了能让这些备份的档案何种缩小，还能让对象的检索更有效率

### danglingg与unreachable对象有什么不同？
* unreachable对象：没有任何对象或指示标指向它，所以它是无法到达的。虽然它无法到达，但它可以指向其他对象

* dangling对象：与unreachable对象一样，没有任何对象或指标指着它，它也没有指着其他对象，完全是悬在天边的一个对象

## 9.5 断头（detached HEAD）是怎么一回事？
### 1. 断头的原因
* HEAD是指向某一个分支的指示标，可以把它当作当前所在的分支来看待

* 正常情况下, HEAD会指向某一个分支，而分支会指向某一个commit，但HEAD偶尔会发生没有指到某个分支的情况，这种状态的HEAD便称为deatched HEAD

* 之所以出现这种状态，原因如下
> 使用checkout指令直接跳转到某个commit，而那个commit当前刚好没有分支指向它

> rebase的过程其实也是处于不断的detached HEAD状态

> 切换到某个远端分支时

### 2. 在这种断头的状态下能做什么？
> 其实这种状态没有什么特别的，只是HEAD刚好指向某个没有分支指着的commit罢了，这不影响操作git或进行commit

* 影响的话，就是当HEAD回到其他分支以后，这个commit就不容易找到了（除非记下这个commit的SHA-1值）。如果一直不找它，过段时间以后它就会被git启动的资源回收机制收走。所以，如果还想留下这个commit，创建一个分支指向它即可

> 可以明确的让Git创建一个分支指向某个commit

```sh
git branch branch_name commit_id
# 或者如下这样也可以
git checkout -b branch_name commit_id
```

### 3. 为什么切换到远端分支也会是断头状态
> 前面提到，当HEAD没有指向某个分支时，它会呈现detached状态。更确切的说，应该是当HEAD没有指向某个本地的分支时，就会呈现断头状态

```sh
git branch 		# 查本地分支
git branch --remote	# 查远端分支
```

### 4. 怎样脱离deatched HEAD状态
* 只需要让HEAD有任何分支可以指向即可
> 例如，让它回到master分支

```sh
git checkout master	# 这样HEAD就解除detached状态了
```

# 第10章 远端共同协作---使用GitHub
## 10.2 将内容Push到GitHub上
### 1.在GitHub上创建新项目(Create repository)
> 要上传文件到GitHub, 需要先在上面创建一个新的项目

> 存取权限中选择Private需要资费$7/月？

### 2.把内容推送到远端点
* 1) 首先，需要设置一个远端点
```sh
git remote add origin git@github.com:yourgithubaccount/yourgit_repository.git

```
> git remote指令主要进行与远端有关的操作

> add 指令表示要加入一个远端点

> origin是一个代名词，指的是后面的那串GitHub服务器的位置

> 远端的节点默认使用origin这个名称; 如果是从服务器上clone下来的，其默认远端点名称就是origin; 这只是惯例，不用该名称或之后想更改都可以，例如改为七龙珠dragonball

```sh
git remote add dragonball git@github.com:yourgithubaccount/yourgit_repository.git
```

* 2)把内容推上去
```sh
git push -u origin master
```
> (1)把master分支的内容推向origin位置

> (2)在origin远端服务器上，如果master不存在，就创建一个名为master的分支

> (3)如果服务器上存在master分支，就会移动服务器上的master分支的位置，使它指到当前最新的commit上

> (4)设置upstream，就是-u参数做的事

* upstream是什么意思？
> 上游，本质上就是另一个分支的名字而已

> 在git中，每个分支可以设置一个上游分（最多一个上游），它会指向并追踪某个分支

> 通常upstream会是远端服务器上的某个分支，但要设置成本地端的其他某个分支也可以

> 如果设置了upstream，当下次执行git push指令时，就会用它来当默认值，例如

```sh
git push -u origin master	#就会把origin/master设置为本地master分支的upstream，当下次执行git push指令而不加任何参数时，Git就会猜出是要推往origin远端点，并且把master分支推上去
```
> 反之，如果没有设置upstream，则必须在每次push时都要告诉git要推的远端点是什么，如下这样

```sh
git push origin master 		# 如果不带参数origin master，则git就不知道该push什么分支，以及要push到哪里
```

* git push origin master与git push origin master:master指令效果相同
> 这两个指令执行相同的操作：把本地的master分支推上去后，在服务器上更新master分支的进度；如果不存在该分支，就创建一个master分支。

> 如果推上去之后想更改名称，可以把后面的名称改掉

```sh
git push origin master:cat		# 这样把本地master分支推上去之后，就不会在线创建master分支了，而是创建一个名为cat的分支（或更新进度）
```

## 10.3 Pull下载更新
* Pull = Fetch + Merge
### Fetch
* 要做的第一件事是：把当前线上有但本地没有的内容抓一份下来，同时移动origin相关分支（这里是origin/master）

* 用远端分支更新本地分支
```
git merge origin/master
```

### git pull -rebase
> 在多人共同开发时，大家都在自己的分支进行commit，所以拉回来用一般的方式合并时，常会出现为了合并而生成额外commit的情况。为了合并而生成的commit本身并没有什么问题，但如果不想要这个额外的commit，可考虑使用rebase方式进行合并

## 10.4 为什么有时候推不上去？
###解决办法
* 1.第一招：先拉再推
* 2.第二招：无视规则，强推
```sh
git push -f
```

## 10.7与其他开发者的互动---使用PullRequest（PR）
## 10.9怎么删除远端的分支
* git push origin :youwantdel
> 是的，就是在分支前面加上冒号。其实明白git push origin master:master，也就明白为什么这样写了

> 这条指令的本质就是推一个空分支到远端的youwantdel分支，这变相地把youwantdel分支删除了

# 第11章 使用Git Flow
## 分支应用场景
> 根据Git Flow的建议，分支主要分为Master、Develop、Hotfix、Release、Feature五个分支

* 1.Master分支
> 主要用来存放稳定、随时可上线的项目版本

* 2.Develop分支
> 是所有开发分支中的基础分支

> 当要新增功能时，使用的Feature分支是从Develop分支分出去的

* 3.Hotfix分支
> 当在线产品发生紧急问题时，会从Master分支划出一个Hotfix分支进行修复

> Hotfix分支修复完成之后，会合并回Master分支，同时合并一份到Develop分支

* 4.Release分支
> 当认为Develop分支足够成熟时，可以把Develop分支合并到Release分支

> 在其中进行上线前的测试，测试完成后，Release分支将会同时合并到Master分支和Develop分支

* 5.Feature分支
> 如果要新增功能，就要使用Feature会。Feature分支从Develop分支分出。完成后合并回Develop分支























