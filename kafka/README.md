# kafka

* **kafka-quickstart.sh**

  Run a zookeeper and 3 kafka-servers, then create a topic with 2 replicas and 3 partitions.Note that, there are several configuration file in the config folder.

  print info:

  ```
  Starting zookeeper...
  nohup: appending output to 'nohup.out'
  Starting kafka server...
  nohup: appending output to 'nohup.out'
  Starting kafka server-2...
  nohup: appending output to 'nohup.out'
  Starting kafka server-3...
  nohup: appending output to 'nohup.out'
  Creating topic with 3 partitions...
  nohup: appending output to 'nohup.out'
  Topics : 
  VehicleHttpPack
  __consumer_offsets
  Topic-VehicleHttpPack info : 
  Topic:VehicleHttpPack	PartitionCount:3	ReplicationFactor:2	Configs:
  	Topic: VehicleHttpPack	Partition: 0	Leader: 2	Replicas: 2,3	Isr: 2
  	Topic: VehicleHttpPack	Partition: 1	Leader: 3	Replicas: 3,2	Isr: 2
  	Topic: VehicleHttpPack	Partition: 2	Leader: 2	Replicas: 2,3	Isr: 2
  
  ```

* **cluster_conf.sh**

  Kafka cluster and ZooKeeper cluster deploy configuration.

  
  