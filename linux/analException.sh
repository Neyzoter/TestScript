#!/bin/bash
# 遍历所有异常，排序，消除重复
for X in $(egrep -o "[A-Z]\w*Exception" log.txt | sort | uniq);
do
	# 异常输出到控制台上
	echo -n -e "$X "
	# 统计个数
	grep -c "$X" log.txt
done
