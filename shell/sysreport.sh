#!/bin/bash
TARGET_DIR="${1:-.}"
SUM1=0
SUM2=0
SUM3=0
FOUND=0
cd "$TARGET_DIR" || { echo "没有该目录"; exit 1; }
printf "%-8s %5s %4s %4s\n" 文件 ERROR WARN INFO
for file in *
do
	[ -f "$file" ] || continue
	ext="${file##*.}"
	[[ "$ext" == log ]] || continue
	FOUND=1
	A=$(grep -c "ERROR" "$file")
	B=$(grep -c "WARN" "$file")
	C=$(grep -c "INFO" "$file")
	SUM1=$((SUM1+A))
	SUM2=$((SUM2+B ))
	SUM3=$((SUM3+C))
	
	printf "%-8s %5s %4s %4s\n" "$file" "$A" "$B" "$C"

	
done
[[ "$FOUND" == 0 ]] && { echo "没有找到.log文件"; exit 1; }
printf "%-8s %5s %4s %4s\n" 总计 "$SUM1" "$SUM2" "$SUM3"
