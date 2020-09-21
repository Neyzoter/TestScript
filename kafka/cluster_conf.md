# Kafka-Zookeeper集群配置

## 1. ZooKeeper集群配置

（1）配置zookeeper配置文件

```
# the directory where the snapshot is stored.
dataDir=/tmp/zookeeper
# the port at which the clients will connect
clientPort=2181
#the blow five lines are added by @author.
initLimit=5
syncLimit=2
## 配置ZK集群中的节点  ##
#### server.0表示0号zk节点
#### IP:PORT1:PORT2的IP表示该节点IP，PORT1表示leader选举端口，PORT2表示zk节点间的通信端口
server.0=192.168.121.34:2888:3888
server.1=192.168.121.35:2889:3889
server.2=192.168.121.36:2890:3890
```

（2）zookeeper节点的id配置

在zookeeper的dataDir目录下创建myid文件，文件中设置zookeeper的id号

```
# 比如设置自己为0号节点，对应到配置文件到server.N中的N
# 其他节点配置成其他节点
0
```

## 2.配置broker集群 

```
# Hostname the broker will bind to. If not set, the server will bind to all interfaces
## broker的ip地址
host.name=192.168.121.34
# A comma seperated list of directories under which to store log files
log.dirs=/tmp/kafka-logs-0
# Zookeeper connection string (see zookeeper docs for details).
# This is a comma separated host:port pairs, each corresponding to a zk
# server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002".
# You can also append an optional chroot string to the urls to specify the
# root directory for all kafka znodes.
# 配置可以连接的zookeeper集群节点
zookeeper.connect=192.168.121.34:2181,192.168.121.35:2181,192.168.121.36:2181
# Timeout in ms for connecting to zookeeper
zookeeper.connection.timeout.ms=60000
```