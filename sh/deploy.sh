#!/bin/bash
docker stop nifi-rtmdemo || true
docker rm nifi-rtmdemo || true

set -e
docker pull fbrillon/nifi-rtmdemo
docker run \
	--detach \
	--publish 8080:8080 \
	--name nifi-rtmdemo \
	--mount source=lgc-rtmdemo--nifi-vol,destination=/home/nifi/lgc/rtmdemo-nifi/ \
	fbrillon/nifi-rtmdemo
