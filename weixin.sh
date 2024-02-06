#!/bin/bash
ln -s /app/weixin/lsb-release /etc/lsb-release
# ln -s /app/lib/libactivation.so /usr/lib/libactivation.so

TMPFILE=/tmp/a3lsaW53ZWl4aW5fbGl1eXVuaGU=.list.tmp

function store_pidlist()
{
	ps -ef | grep weixin | grep -v grep | grep -v weixin.sh | awk '{print $2}' > ${TMPFILE}
}

function is_running()
# 返回 0 表示微信未运行；返回 1 表示微信正在运行
{
	# 1. 获取当前微信的进程数量，非零走判断
	# 2. 如果有tmp文件，获取当前的进程list，比对判断，以tmp为准，tmp中的进程缺失则认定为退出
	# 3. 如果没有tmp文件，非零就退
	WEIXIN_NUMS=`ps -ef | grep weixin | grep -v grep | grep -v weixin.sh | wc -l`
	# 能检索到微信进程的情况下才做判断
	if [ 0 -ne $WEIXIN_NUMS ];then
		if [ -f ${TMPFILE} ];then
			WeixinPIDList=(`ps -ef | grep weixin | grep -v grep | grep -v weixin.sh | awk '{print $2}'`)
			for item in `cat ${TMPFILE}`;do
				# 如果有pid不在当前进程中，则返回0
				[[ ${WeixinPIDList[@]/${item}/} != ${WeixinPIDList[@]} ]]
				if [ $? -eq 1 ];then
					return 0
				fi
			done
			return 1
		else
			# 如果文件丢失，直接认为微信未运行
			return 0
		fi
	fi

	return 0
}

is_running
if [ $? -eq 1 ];then
	echo "Weixin is already running..."
else
	# killall weixin
	/app/weixin/opt/weixin/weixin --no-sandbox
fi
