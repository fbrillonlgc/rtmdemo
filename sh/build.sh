#!/bin/bash
set -e
pushd ./java/rtmdemo/
mvn package
popd
DOCKER_USER=`sudo docker info | sed '/Username:/!d;s/.* //'`
sudo docker build . -t ${DOCKER_USER}/nifi-rtmdemo
sudo docker push ${DOCKER_USER}/nifi-rtmdemo

