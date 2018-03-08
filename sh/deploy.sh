#!/bin/bash
docker stop nifi-rtmdemo || true
docker rm nifi-rtmdemo || true

set -e
docker pull fbrillon/nifi-rtmdemo
docker run \
	--detach \
	--publish 8080:8080 \
	--name nifi-rtmdemo \
	--mount source=nifi-rtmdemo-vol,destination=/opt/nifi/nifi-1.5.0.3.1.0.0-564/ \
	--mount source=lgc-rtmdemo-vol,destination=/home/nifi/lgc/ \
	fbrillon/nifi-rtmdemo
