
# 运行于mongo shell
# mongoexport -h 主机地址 -d 数据库名称 -c 集合名称 --csv --field 字段列表 -o 输出地址
mongoexport -h 127.0.0.1 -d udp -c 2019-07 -o ./mongoexportdata/2019-07.json
