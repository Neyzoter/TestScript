# 副本集群创建
（1）创建所需的文件夹

```
mkdir -p /data/mongodb/27017/{data,logs,tmp,etc,keyfile}
```

（2）创建所需的mongod.conf文件

存放在etc文件夹中


```yml
storage:
 dbPath: /data/mongodb/27017/data
 journal:
  enabled: true
systemLog:
 destination: file
 logAppend: true
 path: /data/mongodb/27017/logs/mongod.log
processManagement:
 fork: true
 pidFilePath: /data/mongodb/27017/tmp/mongod.pid
net:
 port: 27017
 bindIp: 0.0.0.0
replication:
 replSetName: "test1"
```

```yml
storage:
 dbPath: /data/mongodb/27018/data
 journal:
  enabled: true
systemLog:
 destination: file
 logAppend: true
 path: /data/mongodb/27018/logs/mongod.log
processManagement:
 fork: true
 pidFilePath: /data/mongodb/27018/tmp/mongod.pid
net:
 port: 27018
 bindIp: 0.0.0.0
replication:
 replSetName: "test1"
```


```yml
storage:
 dbPath: /data/mongodb/27019/data
 journal:
  enabled: true
systemLog:
 destination: file
 logAppend: true
 path: /data/mongodb/27019/logs/mongod.log
processManagement:
 fork: true
 pidFilePath: /data/mongodb/27019/tmp/mongod.pid
net:
 port: 27019
 bindIp: 0.0.0.0
replication:
 replSetName: "test1"
```

（3）配置任意一个节点

设置第三个第三个节点为仲裁节点

```js
rs.initiate( { _id: "test1", members: [{ _id: 0, host: "127.0.0.1:27017"}, { _id: 1, host: "127.0.0.1:27018"}, { _id: 2, host: "127.0.0.1:27019", arbiterOnly:true} ]})
```

输出：

```json
{
	"ok" : 1,
	"operationTime" : Timestamp(1600173595, 1),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1600173595, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}
```

```js
# 查看状态
test1:PRIMARY> rs.status()
```

输出

```json
{
	"set" : "test1",
	"date" : ISODate("2020-09-15T12:40:53.955Z"),
	"myState" : 1,
	"term" : NumberLong(1),
	"syncingTo" : "",
	"syncSourceHost" : "",
	"syncSourceId" : -1,
	"heartbeatIntervalMillis" : NumberLong(2000),
	"optimes" : {
		"lastCommittedOpTime" : {
			"ts" : Timestamp(1600173645, 1),
			"t" : NumberLong(1)
		},
		"readConcernMajorityOpTime" : {
			"ts" : Timestamp(1600173645, 1),
			"t" : NumberLong(1)
		},
		"appliedOpTime" : {
			"ts" : Timestamp(1600173645, 1),
			"t" : NumberLong(1)
		},
		"durableOpTime" : {
			"ts" : Timestamp(1600173645, 1),
			"t" : NumberLong(1)
		}
	},
	"lastStableCheckpointTimestamp" : Timestamp(1600173605, 2),
	"electionCandidateMetrics" : {
		"lastElectionReason" : "electionTimeout",
		"lastElectionDate" : ISODate("2020-09-15T12:40:05.777Z"),
		"electionTerm" : NumberLong(1),
		"lastCommittedOpTimeAtElection" : {
			"ts" : Timestamp(0, 0),
			"t" : NumberLong(-1)
		},
		"lastSeenOpTimeAtElection" : {
			"ts" : Timestamp(1600173595, 1),
			"t" : NumberLong(-1)
		},
		"numVotesNeeded" : 2,
		"priorityAtElection" : 1,
		"electionTimeoutMillis" : NumberLong(10000),
		"numCatchUpOps" : NumberLong(0),
		"newTermStartDate" : ISODate("2020-09-15T12:40:05.782Z"),
		"wMajorityWriteAvailabilityDate" : ISODate("2020-09-15T12:40:06.424Z")
	},
	"members" : [
		{
			"_id" : 0,
			"name" : "127.0.0.1:27017",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 1465,
			"optime" : {
				"ts" : Timestamp(1600173645, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2020-09-15T12:40:45Z"),
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "could not find member to sync from",
			"electionTime" : Timestamp(1600173605, 1),
			"electionDate" : ISODate("2020-09-15T12:40:05Z"),
			"configVersion" : 1,
			"self" : true,
			"lastHeartbeatMessage" : ""
		},
		{
			"_id" : 1,
			"name" : "127.0.0.1:27018",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 58,
			"optime" : {
				"ts" : Timestamp(1600173645, 1),
				"t" : NumberLong(1)
			},
			"optimeDurable" : {
				"ts" : Timestamp(1600173645, 1),
				"t" : NumberLong(1)
			},
			"optimeDate" : ISODate("2020-09-15T12:40:45Z"),
			"optimeDurableDate" : ISODate("2020-09-15T12:40:45Z"),
			"lastHeartbeat" : ISODate("2020-09-15T12:40:53.783Z"),
			"lastHeartbeatRecv" : ISODate("2020-09-15T12:40:52.920Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "127.0.0.1:27017",
			"syncSourceHost" : "127.0.0.1:27017",
			"syncSourceId" : 0,
			"infoMessage" : "",
			"configVersion" : 1
		},
		{
			"_id" : 2,
			"name" : "127.0.0.1:27019",
			"health" : 1,
			"state" : 7,
			"stateStr" : "ARBITER",
			"uptime" : 58,
			"lastHeartbeat" : ISODate("2020-09-15T12:40:53.783Z"),
			"lastHeartbeatRecv" : ISODate("2020-09-15T12:40:53.321Z"),
			"pingMs" : NumberLong(0),
			"lastHeartbeatMessage" : "",
			"syncingTo" : "",
			"syncSourceHost" : "",
			"syncSourceId" : -1,
			"infoMessage" : "",
			"configVersion" : 1
		}
	],
	"ok" : 1,
	"operationTime" : Timestamp(1600173645, 1),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1600173645, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}
```


（4）开启认证的方法

创建用户

```js
test1:PRIMARY> db.createUser({user: "root", pwd: "Root#123", roles: [{role: "root", db: "admin"}]})
Successfully added user: {
 "user" : "root",
 "roles" : [
  {
   "role" : "root",
   "db" : "admin"
  }
 ]
}
```

在主库上执行脚本生成key文件，然后将结拷贝到另外2个节点

```
[root@m1 mongodb]# cd /data/mongodb/27017/keyfile/
[root@m1 keyfile]# openssl rand -base64 756 > mongo.key
[root@m1 keyfile]# chmod 600 mongo.key # 必须修改为600权限，否则无法启动
```


配置文件中 添加如下内容，注意不同节点的文件路径

```
security:
 authorization: enabled
 clusterAuthMode: keyFile
 keyFile: /data/mongodb/27017/keyfile/mongo.key
```

重启后并用认证模式登陆

# 读写分离
（1）在副本节点上设置setSlaveOk;

（2）代码层面，在读操作过程中设置从副本节点读取数据


# 查看配置

```
db._adminCommand( {getCmdLineOpts: 1})
```