# 使用说明
<将 Tools bin目录放到环境变量里 执行 global [参数 bin目录path]> 
例子：global C:\Tools\bin

conifg目录结构 根据命令名称划分
请求相关命令 配置 相同规则
1：name 2:url 3:proxy  4:download or no download

当 allow 放到 global目录下时 所有文件都将下载 相应配置不生效

所有功能 都是可配置的
genv 设置环境变量

gclone git 下载用的 [在config/gclone/config 可配置下载别名 和url 使用代理 和 是否下载]

gcurl http 下载文件用的 [在config/gcurl/config 可配置下载别名 和url 使用代理 和 是否下载]

grun 运行文件 exe 等等用的

gl 执行linux命令用的