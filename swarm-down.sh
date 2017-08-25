#!/bin/bash

for i in worker1 worker2 worker3 worker4 worker5 manager; do
  docker-machine ssh $i "docker swarm leave --force"
done
docker-machine stop manager worker1 worker2 worker3 worker4 worker5
