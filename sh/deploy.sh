#!/bin/bash
sudo docker stop nifi-rtmdemo || true
sudo docker rm nifi-rtmdemo || true

set -e
DOCKER_USER=`sudo docker info | sed '/Username:/!d;s/.* //'`
sudo docker pull ${DOCKER_USER}/nifi-rtmdemo
sudo docker run \
		--detach \
		--publish 8080:8080 \
		--name nifi-rtmdemo \
		--mount source=lgc-rtmdemo-nifi-vol,destination=/home/nifi/lgc/rtmdemo/nifi/ \
		${DOCKER_USER}/nifi-rtmdemo
