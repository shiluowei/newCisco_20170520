#!/bin/bash
#内容：用来判断执行脚本的用户是否是root，如果是则执行，否则退出
#引用配置文件
# source ../config/config.sh
function judegRoot(){
	#root 用户的UID是0
	#echo -e "${RED_COLOR}$UID${RES}"

	if [ $UID -eq 0 ]
		then
		echo "当前用户为root用户，开始执行安装程序"
	else
		echo -e "${RED_COLOR}当前用户为非root用户，没有权限运行脚本${RES}"
		exit 2
	fi
}