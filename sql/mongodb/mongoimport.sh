#!/bin/bash


# mongoexport --db 数据库名称 --collection 集合名称 --file 数据来源
mongoimport --db udp --collection data --file data.json
