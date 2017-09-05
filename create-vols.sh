# !/bin/bash

keydir="/Volumes/Lavender/$2"

if [ ! -d "$keydir" ]; then
  echo "Please ensure $keydir is available"
  exit -1
fi

if [ "$#" -ne 3 ]; then
  echo "Please give a base name for the volumes and also dir for github key and key file base name."
  exit -1
fi

echo "Creating volumes with name $1..."

docker volume create --name $1-home
docker volume create --name $1-bin
docker volume create --name $1-var
docker volume create --name $1-etc
docker volume create --name $1-usr
docker volume create --name $1-dev
docker volume create --name $1-lib

docker run --rm -v $1-home:/home --name test-$1-home lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 java -version
docker run --rm -v $1-bin:/bin --name test-$1-bin lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 java -version
docker run --rm -v $1-var:/var --name test-$1-var lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 java -version
docker run --rm -v $1-etc:/etc --name test-$1-etc lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 java -version
docker run --rm -v $1-usr:/usr --name test-$1-usr lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 java -version
docker run --rm -v $1-lib:/lib --name test-$1-lib lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 java -version
docker run --rm -v $1-dev:/home/hmrc/dev --name test-$1-dev lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 java -version

docker create -ti -w /home/flower -v "/Volumes/shared/docker:/home/flower/shared" -v "/Volumes/shared/docker/work/hmrc/docker-services:/home/flower/dev/ddcnls-docker" -v $1-etc:/etc -v $1-usr:/usr -v $1-bin:/bin -v $1-var:/var -v $1-home:/home -v $1-dev:/home/flower/dev -v $1-lib:/lib --name $1 --rm lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8

docker cp $keydir/$3 $1:/home/flower
docker cp $keydir/$3.pub $1:/home/flower
docker cp setup.sh $1:/home/flower
docker container start $1 
docker exec -it $1 /bin/bash -c "sudo chown flower:flower setup.sh && sudo chmod +x setup.sh && ./setup.sh && rm ./setup.sh"
docker stop $1 

echo '# !/bin/bash' > start.sh
echo '' >> start.sh
echo $"docker run -ti -w /home/flower -v "/Volumes/shared/docker:/home/flower/shared" -v "/Volumes/shared/docker/work/hmrc/docker-services:/home/flower/dev/ddcnls-docker" -v $1-etc:/etc -v $1-usr:/usr -v $1-bin:/bin -v $1-var:/var -v $1-home:/home -v $1-dev:/home/flower/dev -v $1-lib:/lib --name $1 --rm lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8 /bin/zsh" >> start.sh
chmod +x start.sh

echo '# !/bin/bash' > shell.sh
echo '' >> shell.sh
echo "/usr/local/bin/docker exec -it $1 /bin/zsh" >> shell.sh
chmod +x shell.sh 
