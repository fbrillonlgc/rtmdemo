#!/bin/bash
set -e

mkdir -p /lgc/share/
mkdir -p /lgc/nifi/

docker stop nifi-rtmdemo

docker rm nifi-rtmdemo

docker pull fbrillon/nifi-rtmdemo

docker run \
	--detach \
	--publish 8080:8080 \
	--name nifi-rtmdemo \
	--mount source=nifi-rtmdemo-vol,destination=/opt/nifi/nifi-1.5.0.3.1.0.0-564/ \
	--mount source=lgc-rtmdemo-vol,destination=/home/nifi/lgc/ \
	fbrillon/nifi-rtmdemo
