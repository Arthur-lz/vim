* lsb_release -a 查看linux系统版本，也可以使用cat /proc/version

* uname -a 查看内核版本

*  ps -aux 查看进程列表，显示比较全面的命令组合。

* sed
```bash
~$: echo "Today is good day!" | sed 's/is/is a/'

Today is a good day!
```
>上面的例子中使用sed编辑器的s命令来将"is"替换成了"is a"

>sed 不会修改原文件内容，它只会将修改后的内容输出到标准输出

```bash
~$: echo "There are some dog and cat, oh, and a pig" | sed -e 's/dog/dogs/; s/cat/cats/; s/pig/pigs/'
There are some dogs and cats, oh, and a pigs
```
>当需要同时替换多个文本时，可以使用-e选项，如上面的例子。

```bash
~$: cat script.sed
  s/dog/dogs/
  s/cat/cats/
  s/pig/pigs/
~$: cat data1.txt
There are some dog and cat, oh, and a pig.
~$: sed -f script.sed data1.txt
There are some dogs and cats, oh, and a pigs.
```
>也可以将s命令保存到文件中，来批量修改输出的数据。
* find
>查找文件，不区分大小写, 以.o结尾
```bash
~$: find . -type f -iname "*.o"
```
>删除当前目录下及子目录下所有以.o结尾文件
```bash
~$: find . -type f -iname "*.o" | xargs rm -f
```
>计算查找到文件数量及总计大小
```bash
~$: find . -type f -iname "*.o" | wc 
```
