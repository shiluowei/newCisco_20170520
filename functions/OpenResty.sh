#!/bin/bash
#内容：OpenResty安装函数方法
#安装
#卸载

function OpenRestyInstall(){
	reval=0
	#创建安装路径
	mkdir -p ${OpenRestyInstallPath}
	#创建用户和用户组
	groupadd -r ${OpenRestyUser}
	useradd -s /sbin/nologin -g ${OpenRestyGroup} -r ${OpenRestyUser}
	#安装依赖 
	yum install readline-devel pcre-devel openssl-devel gcc make -y > /dev/null 2>&1
	if [ $? -ne 0 ];then
		echo -e  "${RED_COLOR}安装依赖失败，退出安装进程${RES}"
		exit 3
	fi
	#解压到指定路径
	tar xfz ./src/OpenResty/openresty-${OpenRestyVersion} -C ${OpenRestyInstallPath}
	#安装luajit
	echo -e  "${YELOW_COLOR}开始安装Luajit${RES}"
	cd ${OpenRestyInstallPath}/openresty-${OpenRestyVersion%.tar.gz}/bundle/LuaJIT-2.1-20170405/
	(make clean && make && make install) > /dev/null 2>&1
	echo -e  "${GREEN_COLOR}安装Luajit成功${RES}"
	#解压缩扩展模块
	# cd -
	# mv ./src/OpenResty/2.3.tar.gz ./src/OpenResty/v0.3.0.tar.gz  ${OpenRestyInstallPath}/openresty-${OpenRestyVersion%.tar.gz}/bundle
	# cd ${OpenRestyInstallPath}/openresty-${OpenRestyVersion%.tar.gz}/bundle
	# tar xfz 2.3.tar.gz
	# tar xfz v0.3.0.tar.gz
	cd ..
	wget https://github.com/FRiCKLE/ngx_cache_purge/archive/2.3.tar.gz > /dev/null 2>&1
	tar xfz 2.3.tar.gz
	wget https://github.com/yaoweibin/nginx_upstream_check_module/archive/v0.3.0.tar.gz > /dev/null 2>&1
	tar xfz v0.3.0.tar.gz

	#编译安装openresty
	cd ${OpenRestyInstallPath}/openresty-${OpenRestyVersion%.tar.gz}
	(./configure --prefix=${OpenRestyInstallPath} \
	--with-http_realip_module \
	--with-http_gzip_static_module \
	--with-pcre \
	--with-luajit \
	--add-module=./bundle/ngx_cache_purge-2.3/ \
	--add-module=./bundle/nginx_upstream_check_module-0.3.0/) > /dev/null 2>&1
	if [ $? -ne 0 ];then
		echo -e  "${RED_COLOR}编译OpenResty失败，退出安装进程${RES}"
		exit 3
	fi
	(make && make install) > /dev/null 2>&1
	if [ $? -ne 0 ];then
		echo -e  "${RED_COLOR}make install OpenResty失败，退出安装进程${RES}"
		exit 3
	fi
	${OpenRestyInstallPath}/nginx/sbin/nginx
	if [ $? -ne 0 ];then
		echo -e  "${RED_COLOR}启动失败，退出安装进程${RES}"
		exit 3
	else 
		echo -e  "${GREEN_COLOR}启动openresty成功${RES}"
	fi
}

function OpenRestyRemove(){
	echo '删除'
}