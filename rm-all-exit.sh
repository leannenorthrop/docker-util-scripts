#!/bin/bash

docker ps --filter "status=exited" --format "table {{.ID}}" | tail -n +2 | xargs docker rm
