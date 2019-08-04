#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import socket
for i in range(10):
	# 创建一个socket:
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	# 建立连接:
	s.connect(('115.159.154.160', 8089))
	print("Connected Num : ", i)
