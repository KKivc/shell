#!/bin/bash
TARGET_DIR="${1:-.}"
cd "$TARGET_DIR" || { echo "没有该目录"; exit 1; }
while true
do
	echo "═══════════════════════════"
	echo "  工具菜单"
	echo "═══════════════════════════"
	echo "  1)  显示当前目录大小"
	echo "  2） 统计 .log 文件行数"
	echo "  3） 清理过期文件"
	echo "  4） 退出"
	echo "═══════════════════════════"
	read -p "option: "
	
	case "$REPLY" in
		1) du -k ;;
		2) wc -l *.log | tail -1 ;;
		3) SUM=0
			for file in * 
			do
				[ -f "$file" ] || continue
				[ $(find "${file}" -mtime +7) ] || continue
				A=$(du -k "$file" | cut -f 1)
	
				mkdir -p "$TARGET_DIR"/archive/
				mv "$file" "$TARGET_DIR"/archive/
				SUM=$(( SUM+1 ))
			done 
			echo "移动了${SUM}个文件" ;;
		 4) echo "bye!" && break ;;
		 *) echo "无效选择"
	esac
done



#交互式菜单
#while true保证循环不会自己结束；
#case模式匹配，比if简单；基本语法：
#case <表达式> in
#  模式1)
#    命令1 ;;
# 模式2)
#   命令2 ;;
# *)
#   默认命令 ;;
#esac
