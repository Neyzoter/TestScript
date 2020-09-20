#!/bin/bash
data_cmd=`date +%Y-%m-%dT%H:%M:%S`
test_num=1
user="scc"
password="123454"
test="Test"
data_num=0

testname=$test+$test_num+$data_cmd

echo $testname
