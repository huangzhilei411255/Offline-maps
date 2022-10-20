# html_report 对应模块 -> 云踪（导出html报告）
## 该项目为VUE源码，npm run build 编译后，将dist目录中的东西考到服务器上作为模板（自动化）

### dist中目录结构：
####static/
####static/data (数据js文件，由前台动态加载，需要后台java程序生成并拷贝到该目录中)
####static/fonts (字体，模板生成时自动生成)
####static/img (图片，模板生成时自动生成)
####static/js (框架js，模板生成时自动生成)
####static/css (样式，模板生成时自动生成)
####static/init.js (初始化数据结构文件，模板生成时自动生成)
####static/attach (附件文件，需要后台java程序生成并拷贝到该目录中)
####index.html (html报告首页)
