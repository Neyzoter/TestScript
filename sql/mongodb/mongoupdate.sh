#!/bin/sh

# 输入实例
## data is database name
cmd="db.space.update({},{\$set:{'free_space':'21G'}},{upsert:true});"
echo $cmd | mongo data --shell

