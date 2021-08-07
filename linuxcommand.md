#### lsb_release -a 
>查看linux系统版本，也可以使用cat /proc/version
---
#### uname -a 
>查看内核版本
---
####  ps -aux
>查看进程列表，显示比较全面的命令组合。
---
#### sed
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
---
#### find
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
---
#### dd
用指定大小的块拷贝一个文件，并在拷贝的同时进行指定的转换。
注意：指定数字的地方若以下列字符结尾，则乘以相应的数字：b=512；c=1；k=1024；w=2

* if=文件名：输入文件名，缺省为标准输入。即指定源文件。< if=input file >
* of=文件名：输出文件名，缺省为标准输出。即指定目的文件。< of=output file >
* ibs=bytes：一次读入bytes个字节，即指定一个块大小为bytes个字节。
* obs=bytes：一次输出bytes个字节，即指定一个块大小为bytes个字节。
* bs=bytes：同时设置读入/输出的块大小为bytes个字节。
* cbs=bytes：一次转换bytes个字节，即指定转换缓冲区大小。
* skip=blocks：从输入文件开头跳过blocks个块后再开始复制。
* seek=blocks：从输出文件开头跳过blocks个块后再开始复制。
注意：通常只用当输出文件是磁盘或磁带时才有效，即备份到磁盘或磁带时才有效。
* count=blocks：仅拷贝blocks个块，块大小等于ibs指定的字节数。
* conv=conversion：用指定的参数转换文件。

>    ascii：转换ebcdic为ascii

>    ebcdic：转换ascii为ebcdic

>    ibm：转换ascii为alternate ebcdic

>    block：把每一行转换为长度为cbs，不足部分用空格填充

>    unblock：使每一行的长度都为cbs，不足部分用空格填充

>    lcase：把大写字符转换为小写字符

>    ucase：把小写字符转换为大写字符

>    swab：交换输入的每对字节

>    noerror：出错时不停止

>    notrunc：不截短输出文件

>    sync：将每个输入块填充到ibs个字节，不足部分用空（NUL）字符补齐。
* 举例
```sh
# 将本地的/dev/hdb整盘备份到/dev/hdd
~$> dd if=/dev/hdb of=/dev/hdd

#将/dev/hdb全盘数据备份到指定路径的image文件
~$> dd if=/dev/hdb of=/root/image

#将备份文件恢复到指定盘
~$> dd if=/root/image of=/dev/hdb

#备份/dev/hdb全盘数据，并利用gzip工具进行压缩，保存到指定路径
~$> dd if=/dev/hdb | gzip > /root/image.gz

#将压缩的备份文件恢复到指定盘
~$> gzip -dc /root/image.gz | dd of=/dev/hdb

#备份与恢复MBR
#备份磁盘开始的512个字节大小的MBR信息到指定文件：
#count=1指仅拷贝一个块；bs=512指块大小为512个字节。
~$> dd if=/dev/hda of=/root/image count=1 bs=512

#恢复
#将备份的MBR信息写到磁盘开始部分
~$> dd if=/root/image of=/dev/had

#备份软盘
~$> dd if=/dev/fd0 of=disk.img count=1 bs=1440k (即块大小为1.44M)

#拷贝内存内容到硬盘
~$> dd if=/dev/mem of=/root/mem.bin bs=1024 (指定块大小为1k) 

#拷贝光盘内容到指定文件夹，并保存为cd.iso文件
~$> dd if=/dev/cdrom(hdc) of=/root/cd.iso

#销毁磁盘数据
~$> dd if=/dev/urandom of=/dev/hda1
```
 
* 增加swap分区文件大小
```sh
#第一步：创建一个大小为256M的文件：
~$> dd if=/dev/zero of=/swapfile bs=1024 count=262144
#第二步：把这个文件变成swap文件：
~$> mkswap /swapfile
#第三步：启用这个swap文件：
~$> swapon /swapfile
#第四步：编辑/etc/fstab文件，使在每次开机时自动加载swap文件：
~$> /swapfile    swap    swap    default   0 0
```
* 测试硬盘的读写速度
```sh
~$> dd if=/dev/zero bs=1024 count=1000000 of=/root/1Gb.file
~$> dd if=/root/1Gb.file bs=64k | dd of=/dev/null
#通过以上两个命令输出的命令执行时间，可以计算出硬盘的读、写速度
```
* 确定硬盘的最佳块大小：
```sh
~$> dd if=/dev/zero bs=1024 count=1000000 of=/root/1Gb.file
~$> dd if=/dev/zero bs=2048 count=500000 of=/root/1Gb.file
~$> dd if=/dev/zero bs=4096 count=250000 of=/root/1Gb.file
~$> dd if=/dev/zero bs=8192 count=125000 of=/root/1Gb.file
#通过比较以上命令输出中所显示的命令执行时间，即可确定系统最佳的块大小
```
* 修复硬盘：
```sh
~$> dd if=/dev/sda of=/dev/sda 或dd if=/dev/hda of=/dev/hda
#当硬盘较长时间(一年以上)放置不使用后，磁盘上会产生magnetic flux point，当磁头读到这些区域时会遇到困难，并可能导致I/O错误。当这种情况影响到硬盘的第一个扇区时，可能导致硬盘报废。上边的命令有可能使这些数 据起死回生。并且这个过程是安全、高效的
```
* 利用netcat远程备份
```sh
~$> dd if=/dev/hda bs=16065b | netcat < targethost-IP > 1234
#在源主机上执行此命令备份/dev/hda
~$> netcat -l -p 1234 | dd of=/dev/hdc bs=16065b
#在目的主机上执行此命令来接收数据并写入/dev/hdc
~$> netcat -l -p 1234 | bzip2 > partition.img
~$> netcat -l -p 1234 | gzip > partition.img
#以上两条指令是目的主机指令的变化分别采用bzip2、gzip对数据进行压缩，并将备份文件保存在当前目录。
```

* 将一个很大的视频文件中的第i个字节的值改成0×41（也就是大写字母A的ASCII值）
```sh
~$> echo A | dd of=bigfile seek=$i bs=1 count=1 conv=notrunc
```
---
#### /dev/null和/dev/zero的区别
* /dev/null，外号叫无底洞，你可以向它输出任何数据，它通吃，并且不会撑着；它是空设备，也称为位桶（bit bucket）。任何写入它的输出都会被抛弃。如果不想让消息以标准输出显示或写入文件，那么可以将消息重定向到位桶

* /dev/zero，是一个输入设备，你可你用它来初始化文件。该设备无穷尽地提供0，可以使用任何你需要的数目——设备提供的要多的多。他可以用于向设备或文件写入字符串0

#### ldd
> 查看程序依赖的动态库有哪些. (注意， 需要绝对路径，或者在程序目录下)

#### cat /proc/kallsyms
> 查看内核导出的符号表

#### ls -l /sys/module/你想查看的内核模块名称/parameters/
> 查看内核模块，某一个模块的参数列表

#### mknod file type major minor
>手动生成设备结点, 如: mknod /dev/test1 c 200 0, 表示创建设备结点test1, c表示字符型设备(b为块设备)，主设备号200, 次设备号0

> linux中所有的设备结点都放在/dev/目录下，/dev/是基于RAM的虚拟文件系统，是动态生成的，使用devtmpfs虚拟文件系统挂载的。

#### lsblk
> 查看磁盘分区

#### fdisk -l
>  fdisk是一个创建和维护分区表的程序，它兼容DOS类型的分区表、BSD或者SUN类型的磁盘列表
> fdisk用于磁盘管理用的

#### dialog
> sudo pacman -S dialog

#### wifi-menu
> 用于设置无线


#### screenfetch
> 有点酷的系统概要

#### ls /sys/firmware/
> 查看系统启动模式，如果有efi，则是uefi启动，否则bios启动。

#### timedatectl set-ntp true
> 同步系统时间

#### chsh
> 切换shell

> 下面举例说明，切换当前用户的shell为fish

```sh
chsh -s /usr/bin/fish
```

> 可以查看/etc/passwd来确认用户的shell是什么

#### 不同用户使用vim的配置
* 以操作用户user1为例，将.vim文件夹拷贝到/home/user1/下
* 修改.vim所有者
```sh
chown -R user1:user1 /home/user1/.vim/
```
