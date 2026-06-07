#!/bin/bash
NO=0
RM=0
RP=0
FA=0
while read A B C <&3;
do
	NO=$((NO+1))
	printf "%1s %-5s %-10s %30s\n" "$NO" "$A" "$B" "$C"
	read -p "[y/n]" D
	
	if [ "$D" = "y" ]
	then 
		docker rm "$A" && RM=$((RM+1)) || FA=$((FA+1))
	elif [ "$D" = "n" ]
	then
		RP=$((RP+1)) && continue 
	fi
	
done 3< <(docker ps -f status=exited --format "{{.Names}}  {{.Image}}  {{.Status}}")
echo "已删除： ${RM}个容器"
echo "跳过：   ${RP}个容器"
echo "失败：   ${FA}个容器"

#清理退出的docker容器
#0、1、2是系统预留的标准通道，0输入，read从0通道读取；1输出，docker ps输出走1；错误走2
#3及以上是空闲的，自定义用，将docker的数据挂到3通道，避免走0通道冲突
# 'read -p "[y/n]" D'  -p打印提示[y/n]，等待输入，并将输入存储D中
# read -p "[y/n]" 如果没有变量，那么输入存入 $REPLY，可以直接调用
#  RP=$((RP+1)) && continue 不能反过来，如果continue先的话RP就不执行了