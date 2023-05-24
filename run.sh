#!/usr/bin/env bash
# 重新安装直接删除
# rm -rf $XDG_DATA_HOME/weixin_deepin
# rm -rf $XDG_DATA_HOME/weixindir
mkdir -p $XDG_DATA_HOME/weixin_deepin
# https://home-store-img.uniontech.com/apppkg/39331e35ad664664aececa2c817f413c.deb
# 检查文件夹是不是为空,为空就解压/app/weixin_deepin/files.7z
if [ -z "$(ls -A $XDG_DATA_HOME/weixin_deepin)" ]; then
  echo "The directory is empty."
  7z x /app/weixin_deepin/files.7z -o$XDG_DATA_HOME/weixin_deepin
else
  echo "The directory is not empty."
fi

# 创建新的运行文件夹
export WINEPREFIX=$XDG_DATA_HOME/weixindir
export WINEARCH=win32

wine "$XDG_DATA_HOME/weixin_deepin/drive_c/Program Files/Tencent/WeChat/WeChat.exe"

