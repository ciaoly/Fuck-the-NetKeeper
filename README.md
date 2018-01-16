# 基于openwrt + pppoe-server 破解netkeeper
-----------------
思路参考[issue #138](https://github.com/miao1007/Openwrt-NetKeeper/issues/138), 同时也copy了[huipengly/Openwrt-NetKeeper](https://github.com/huipengly/Openwrt-NetKeeper/tree/master/netkeeper4-use-pppoer-server)部分代码.

## 使用方法  
### 1. 安装rp-pppoe-server  
```
opkg install rp-pppoe-server
```
**注意:** 如果使用opkg不能安装的话, 修改软件源或者手动下载rp-pppoe-server.ipk文件进行安装.[mt7620的潘多拉固件可用的pppoe-server.ipk](http://downloads.openwrt.org.cn/PandoraBox/ralink/mt7620_old/packages/)
### 2. 将项目中所有文件拷贝到路由器中
需要将文件的所在目录与路由器中目录对应
### 3. 执行netkeeper_conf.sh
```./netkeeper_conf.sh```
### 4. 在路由器配置页面设置密码和拨号接口
打开路由器后台管理界面, 在"网络/Netkeeper Tool"下设置
### 5. 电脑使用Netkeeper客户端拨号
拨号客户端会提示691错误, 稍后几秒检查是否联网. 若否, 则重新使用客户端拨号.
