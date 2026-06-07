#传目录——判断文件——mv文件，mkdir -p自创——echo

#!/bin/bash
TARGET_DIR="${1:-.}"
SUM1=0
SUM2=0
cd "$TARGET_DIR" || { echo "没有该目录" ; exit 1; }

for file in *
do
	[ -f "$file" ] || continue
	[ $(find "${file}" -mtime +7) ] || continue
	A=$(du -k "$file" | cut -f 1)
	
	mkdir -p "$TARGET_DIR"/archive/
	mv "$file" "$TARGET_DIR"/archive/
	SUM1=$(( SUM1+A ))
	SUM2=$(( SUM2+1 ))
done

echo "释放了${SUM1}KB空间"
echo "移动了${SUM2}个文件"