git init

git status

git add .

git commit -m  "message some you want to say for this commit"

git push remote add origin https://github.com/Arthur-lz/vim.git
或者
git remote add origin https://github.com/Arthur-lz/vim.git
git push -u origin master 
由上面这两句来分两步完成；因为有的时候可能直接执行上面的第一种方式会失败。

git pull


git config credential.helper store # before send git push, input it, could save your pass and username. 


git branch newbranch

git checkout newbranch

git checkout master

git merage

git branch -d newbranch

git clone https://github.com/Arthur-lz/vim.git

git rm  --cached somefile
########################################################################################################
git diff
查看本地与git 仓库不同部分；就是说本地文件与仓库中文件差异部分可以列出。

.gitattributes文件中定义的diff行，可以将git不能识别的二进制文件，通过diff来指定filter来转换成可以识别的格式txt
例如，docx类型的word文件，在没有配置diff前，git diff命令只可以给出二进制文件的属性信息，如文件大小、创建日期的不同，
如果在.gitattributes文件中增加如下这样一行

*.docx   diff=word

这表示，所有.docx类型的文件将使用word filter命令来将docx类型的文件转换成txt类型git可以识别文件内容的格式，
要使用word filter需要进行如下配置，

一、安装docx2txt程序
二、写一个wrapper脚本来变换输出为git期望的格式
三、配置git来使用这个脚本
四、git config diff.word.textconv docx2txt

配置之后,执行git diff时，任何以.docx为扩展名的文件，它都应该执行word filter（被定义为docx2txt程序）这将有效地在试图比较他们之前转换word文件为普通的text文件以便比较

########################################################################################################

git show
git log  显示提交日志

########################################################################################################
```sh
# 输入用户名git config --global user.name "yourname"  
# 输入邮箱git config --global user.email "youremail" 
# 消除由于Windows和Linux拼图中换行符的差异导致的问题git config --global core.autocrlf false 
# 消除由于路径或是文件名包含中文导致的乱码问题git config --global core.quotepath off
# 消除gui界面中文乱码问题，如果只使用命令行的话不用设置这个git config --global gui.encoding utf-8
# 配置ssh的秘钥，输完之后一路回车ssh-keygen -t rsa -C "youremail"
# 启用ssh-agenteval `ssh-agent`
# 添加秘钥ssh-add ~/.ssh/id_rsa
# 将它添加到一直的key列表中ssh-add -l
# 打开公钥文件，拷贝公钥，添加到自己的GitHub账户上去cat ~/.ssh/id_rsa.pub



