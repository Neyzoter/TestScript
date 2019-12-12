#!/bin/bash

# sometimes docker need to read files in host, but docker's volume is seperated to host's
# we can mount host's dir to docker
# for example, we mount host's /etc to docker's, so docker can access to /etc of host
docker run --network=host -v /etc:/etc neyzoter/rcloud:latest

