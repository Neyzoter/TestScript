#!/bin/bash

# 将所有的host宿主机的端口映射到容器，实现容器可以访问宿主机端口
## 并不推荐这样做，docker设计的初衷
# map all ports of host to container,so container can access to ports' of host
## such as container access to db of host

docker run --network=host <repository>
