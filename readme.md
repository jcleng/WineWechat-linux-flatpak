# flatpak微信


wine的包是使用的[deepin-wine
](https://github.com/zq1997/deepin-wine#%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B)的包

https://deepin-wine.i-m.dev/

首次打开会初始化wine和解压软件安装包,会慢一点(提示下载Wine.mono,可以进行取消)

重新安装微信包可以进入容器内删除软件目录

```shell
flatpak run --command=sh org.winehq.WineWechat
rm -rf $XDG_DATA_HOME/weixin_deepin
```

dll提示错误可以关闭重新打开


![1684986167503.jpg](https://img1.imgtp.com/2023/05/25/jGbA7bYi.jpg)


![1684986313978.png](https://img1.imgtp.com/2023/05/25/nmub8UA1.png)

