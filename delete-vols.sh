# !/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Please give a base name for the volumes"
  exit -1
fi

echo "Deleting volumes with name $1..."

docker volume rm $1-home
docker volume rm $1-bin
docker volume rm $1-var
docker volume rm $1-etc
docker volume rm $1-usr
docker volume rm $1-dev
docker volume rm $1-lib
