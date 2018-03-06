#!/bin/bash
set -e

mkdir -p /lgc/share/
mkdir -p /lgc/nifi/

docker stop nifi-rtmdemo

docker rm nifi-rtmdemo

docker pull fbrillon/nifi-rtmdemo

docker run \
	--detach \
	--publish 8080-8081:8080-8081 \
	--name nifi-rtmdemo \
	fbrillon/nifi-rtmdemo
