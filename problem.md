# 问题
## markdown无法预览
* 环境: centos 7, linux 3.10.0
* 现象：md文件无法在vim里使用MarkdownPreview预览，打不开浏览器
* 问题排查：
> 1.查看server.py文件，找到其服务器及默认端口，可以正常在浏览器里输入http://127.0.0.1:8686/static/htmls/index.html来访问文件index.html，这说明本地的服务器已经运行
