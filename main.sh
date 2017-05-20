#!/bin/bash
#日期:2017-5-20
#内容：自动化脚本安装的主入口文件
#作者：施罗伟

#首先引用配置脚本
source ./config/config.sh
#判断当前用户是否有权限运行脚本
source ./functions/*.sh
#执行判断root用户方法
judegRoot

#做自动化安装选项的说明
echo '自动化安装OpenResty----------输入：OpenResty'
echo '自动化安装Mariadb----------输入：Mariadb'

#标准输入read 定义20秒输入超时退出
read -t 10 -p '请输入相应的安装选项：'  choose
#echo $choose

case "$choose" in 
	OpenResty)
		echo '开始安装OpenResty'
		source ./functions/OpenResty.sh
		OpenRestyInstall
;;
	Mariadb)
		echo '开始安装Mariadb'
;;
	*)
		echo -e  "${RED_COLOR}输入错误${RES}"

		echo "使用方法：bash $0 OpenResty|Mariadb"
		exit 1
;;
esac
