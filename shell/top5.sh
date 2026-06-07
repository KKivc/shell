#!/bin/bash
TARGET_DIR="${1:-.}"
SUM=0
NO=1
FOUND=0
cd "$TARGET_DIR" || { echo "没有该目录"; exit 1; }
printf "%5s %5s %-8s\n" 排名 大小 文件名
while read A B;
do 
	FOUND=1
	printf "%5s %5s %-8s\n" "$NO" "$A" "$B"
	SUM=$((SUM+A))
	NO=$((NO+1))
done < <(du -ka * | sort -rn | head -5)
[[ "$FOUND" == 0 ]] && { echo "没有找到文件"; exit 1; }
printf "%5s 	%-8s\n" 合计 "$SUM"




#作用：找目录中体积大小前5的文件
#使用标志位判断有没有普通文件
#while read 一次可以读取一行，分别定义给变量
#使用while read时，使用进程替换，避免子shell，while read 变量;do ...done < <(command)
#sort：排序，默认从小到大，-n：对数字排序，-r：逆序，从大到小