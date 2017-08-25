#!/bin/bash

docker-machine start manager worker1 worker2 worker3 worker4 worker5
docker-machine ssh manager "docker swarm init --advertise-addr 192.168.99.102:2377"
token=`docker-machine ssh manager "docker swarm join-token --quiet worker"`
echo "Token is $token"
for i in worker1 worker2 worker3 worker4 worker5; do
  docker-machine ssh $i "docker swarm join --token $token 192.168.99.102:2377"
done
